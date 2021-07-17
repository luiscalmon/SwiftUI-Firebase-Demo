//
//  ContentView.swift
//  FirebaseDemo
//
//  Created by Luis Calmon on 28/12/20.
//

import SwiftUI

struct ContentView: View {
    
    
    @AppStorage ("userid") var userid: String?
        
    var body: some View {
        TabView {
            
            UserView().tabItem {Label("User", systemImage: "person.circle")}

            if userid != nil {
                //
                // Each <Type> added here must also be added in UserManager as a property and in UserManager.deleteUser
                // This is a very bad design
                // I'm still looking for a better solution
                //
                Rows<Note>().tabItem {Label(Note.title, systemImage: "note.text")}
                Rows<Appointment>().tabItem {Label(Appointment.title, systemImage: "calendar")}
                Rows<Task>().tabItem {Label(Task.title, systemImage: "list.bullet")}
                Rows<Message>(justOwnElements: false).tabItem {Label(Message.title, systemImage: "megaphone.fill")}
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
