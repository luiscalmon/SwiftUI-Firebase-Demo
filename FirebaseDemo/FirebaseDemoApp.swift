//
//  FirebaseDemoApp.swift
//  FirebaseDemo
//
//  Created by Luis Calmon on 28/12/20.
//

import SwiftUI
import Firebase

@main
struct FirebaseDemoApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
    init() { FirebaseApp.configure() }
}
