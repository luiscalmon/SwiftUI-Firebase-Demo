//
//  UserManager.swift
//  FirebaseDemo
//
//  Created by Luis Calmon on 29/12/20.
//

import SwiftUI
import FirebaseAuth

class UserManager: ObservableObject {
    
    @AppStorage ("userid") var userid: String?
        
    enum CommandResult { case processing, result(Result<User?, Error>) }
    
    @Published private var commandResult = CommandResult.processing {
        didSet {
            if case Status.logged(let user) = status {
                userid = user.uid
            } else {
                userid = nil
            }
        }
    }
    
    enum Status {
        case loggedout, processing, logged(User), waitingVerification(User), error(Error)
    }
    
    var status: Status {
        switch commandResult {
        case .processing:
            return .processing
        case .result(let result):
            switch result {
            case .failure(let error):
                return .error(error)
            case .success(let user):
                if let user = user {
                    return user.isEmailVerified ? .logged(user): .waitingVerification(user)
                } else {
                    return .loggedout
                }
            }
        }
    }
    
    var email = ""
    var password = ""
    
    func sign(command: (String, String, ((AuthDataResult?, Error?) -> Void)?) -> Void, sendEmail: Bool = false) {
        commandResult = .processing
        command(email, password) { [self] result, error in
            if let user = result?.user {
                commandResult = .result(.success(user))
                if sendEmail {
                    user.sendEmailVerification()
                }
            } else if let error = error {
                commandResult = .result(.failure(error))
            }
        }
    }
    func signUp() {
        sign(command: Auth.auth().createUser, sendEmail: true)
    }
    func signIn() {
        sign(command: Auth.auth().signIn(withEmail:password:completion:))
    }
    func signOut() {
        do {
            try Auth.auth().signOut()
        } catch {
            commandResult = .result(.failure(error))
        }
    }
    func sendEmailVerification() {
        guard case Status.waitingVerification(let user) = status else {
            return
        }
        commandResult = .processing
        user.sendEmailVerification() { [self] in
            if let error = $0 {
                commandResult = .result(.failure(error))
            } else {
                commandResult = .result(.success(user))
            }
        }
    }
    func resetPasswd() {
        Auth.auth().sendPasswordReset(withEmail: email) { [self] in
            if let error = $0 {
                commandResult = .result(.failure(error))
            } else {
                commandResult = .result(.success(nil))
            }
        }
    }
    
    //
    // Each <Type> added in ContentView.body TabView must also be added here
    // This is a very bad design
    // I'm still looking for a better solution
    //
    let notes = FirestoreBackend<Note>()
    let appointments = FirestoreBackend<Appointment>()
    let tasks = FirestoreBackend<Task>()
    let messages = FirestoreBackend<Message>()

    func deleteUser() {
        let user: User
        switch status {
        case .logged(let innerUser), .waitingVerification(let innerUser):
            user = innerUser
        default:
            return
        }
        commandResult = .processing
        user.delete { [self] in
            if let error = $0 {
                commandResult = .result(.failure(error))
            } else {
                //
                // Each <Type> added in ContentView.body TabView must also be added here
                // This is a very bad design
                // I'm still looking for a better solution
                //
                notes.delete(user.uid)
                appointments.delete(user.uid)
                tasks.delete(user.uid)
                messages.delete(user.uid)
                //
                commandResult = .result(.success(Auth.auth().currentUser))
            }
        }
    }
    
    lazy var listenerHandle = Auth.auth().addStateDidChangeListener { self.commandResult = .result(.success($1)) }
    
    init() {
        let _ = listenerHandle
    }
    deinit {
        Auth.auth().removeStateDidChangeListener(listenerHandle)
    }
}
