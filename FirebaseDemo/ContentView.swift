//
//  ContentView.swift
//  FirebaseDemo
//
//  Created by Luis Calmon on 28/12/20.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var userManager = UserManager()
    @AppStorage ("userid") var userid: String?
    
    var body: some View {
        TabView {
            UserView(userManager: userManager).tabItem { Text("User") }
            if userid != nil {
                //
                // Each <Type> added here must also be added in UserManager.deleteUser
                // This is a very bad design
                // I'm still looking for a better solution
                //
                Rows<Note>().tabItem { Text(Note.title) }
                Rows<Appointment>().tabItem { Text(Appointment.title) }
                Rows<Task>().tabItem { Text(Task.title) }
                Rows<Message>(justOwnElements: false).tabItem { Text(Message.title) }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
