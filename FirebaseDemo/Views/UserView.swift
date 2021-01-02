//
//  UserView.swift
//  FirebaseDemo
//
//  Created by Luis Calmon on 31/12/20.
//

import SwiftUI

struct UserView: View {
    
    @ObservedObject var userManager: UserManager
    
    var body: some View {
        VStack {
            switch userManager.status {
            case .processing:
                Text("processing")
            case .error(let error):
                Text(error.localizedDescription)
            case .logged(let user):
                Text(user.email ?? user.uid)
            case .waitingVerification:
                Text("email verification pending")
                Button(action: { userManager.sendEmailVerification() }) { Text("Resend Email Verification")}
                    .border(Color.red, width: 2)
            case .loggedout:
                Text("not logged")
            }
            if userManager.status.logged {
                Button(action: { userManager.signOut() }) { Text("Log Out")}.border(Color.red, width: 2)
            } else {
                TextField("Email", text: $userManager.email).border(Color.red, width: 2)
                TextField("Password", text: $userManager.password).border(Color.red, width: 2)
                Button(action: {userManager.signIn()}) { Text("Login")}.border(Color.red, width: 2)
                Button(action: {userManager.signUp()}) { Text("Create User")}.border(Color.red, width: 2)
                Button(action: {userManager.resetPasswd()}) { Text("Reset password")}.border(Color.red, width: 2)
            }
            if userManager.status.mayDelete {
                Button(action: { userManager.deleteUser() }) { Text("Delete User")}.border(Color.red, width: 2)
            }
        }
        .padding()
    }
}
