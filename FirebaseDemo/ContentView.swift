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
            UserView(userManager: userManager).tabItem {
                Image(systemName: "person.circle")
                Text("User")
            }
            if userid != nil {
                //
                // Each <Type> added here must also be added in UserManager as a property and in UserManager.deleteUser
                // This is a very bad design
                // I'm still looking for a better solution
                //
                Rows<Note>().tabItem {
                    Image(systemName: "note.text")
                    Text(Note.title)
                }
                Rows<Appointment>().tabItem {
                    Image(systemName: "calendar")
                    Text(Appointment.title)
                }
                Rows<Task>().tabItem {
                    Image(systemName: "list.bullet")
                    Text(Task.title)
                }
                Rows<Message>(justOwnElements: false).tabItem {
                    Image(systemName: "megaphone.fill")
                    Text(Message.title)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
