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
                    .padding()
                    .background(Color.red).cornerRadius(29)
            case .loggedout:
                Text("not logged")
            }
            if userManager.status.logged {
                Button(action: { userManager.signOut() }) { Text("Log Out")}
                    .padding()
                    .background(Color.red).cornerRadius(29)
            } else {
                TextField("Email", text: $userManager.email)
                    .border(Color.primary, width: 1)
                TextField("Password", text: $userManager.password)
                    .border(Color.primary, width: 1)
                HStack {
                    Button(action: {userManager.signIn()}) { Text("Login")}
                        .padding()
                        .background(Color.red).cornerRadius(29)
                    Button(action: {userManager.signUp()}) { Text("Create User")}
                        .padding()
                        .background(Color.red).cornerRadius(29)
                }
                Button(action: {userManager.resetPasswd()}) { Text("Reset password")}
                    .padding()
                    .background(Color.red).cornerRadius(29)
            }
            if userManager.status.mayDelete {
                Button(action: { userManager.deleteUser() }) { Text("Delete User")}
                    .padding()
                    .background(Color.red).cornerRadius(29)
            }
        }
        .padding()
    }
}
