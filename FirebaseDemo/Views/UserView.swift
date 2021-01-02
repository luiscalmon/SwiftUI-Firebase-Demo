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
            case .loggedout:
                Text("not logged")
            }
            if userManager.status.logged {
                Button(action: { userManager.signOut() }) {
                    Text("Log Out")
                        .frame(maxWidth: .infinity)
                        .contentShape(Rectangle())
                }
                .padding()
                .background(Color.red).cornerRadius(29)
            } else {
                TextField("Email", text: $userManager.email)
                    .font(.title2)
                    .border(Color.primary, width: 1)
                SecureField("Password", text: $userManager.password)
                    .font(.title2)
                    .border(Color.primary, width: 1)
                Button(action: {userManager.signIn()}) {
                    Text("Login")
                        .frame(maxWidth: .infinity)
                        .contentShape(Rectangle())
                }
                .padding()
                .background(Color.red).cornerRadius(29)
                Button(action: {userManager.signUp()}) { Text("Create User")}
                    .padding()
                Button(action: {userManager.resetPasswd()}) { Text("Reset password")}
                    .padding()
            }
            if userManager.status.mayDelete {
                Button(action: { userManager.deleteUser() }) { Text("Delete User")}
                    .padding()
            }
        }
        .padding()
    }
}
