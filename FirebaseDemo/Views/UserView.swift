//
//  UserView.swift
//  FirebaseDemo
//
//  Created by Luis Calmon on 31/12/20.
//

import SwiftUI

struct UserView: View {
    
    @EnvironmentObject var userManager: UserManager
    
    var body: some View {
        VStack {
            
            switch userManager.status {
            case .processing:
                Text("processing")
            case .error(let error):
                Text(error.localizedDescription)
            case .logged(let user), .waitingVerification(let user):
                Text(user.email ?? "userID: " + user.uid)
                if case UserManager.Status.waitingVerification = userManager.status {
                    Text("email verification pending")
                }
            case .loggedout:
                Text("not logged")
            }
            
            switch userManager.status {
            case .logged, .waitingVerification:
                Button(action: { userManager.signOut() }) {
                    Text("Log Out")
                        .frame(maxWidth: .infinity)
                        .contentShape(Rectangle())
                }
                .padding()
                .background(Color.red).cornerRadius(29)
                Button(action: { userManager.deleteUser() }) { Text("Delete User")}
                    .padding()
                if case UserManager.Status.waitingVerification = userManager.status {
                    Button(action: { userManager.sendEmailVerification() }) { Text("Resend Email Verification")}
                        .padding()
                }
            default:
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
        }
        .padding()
    }
}
