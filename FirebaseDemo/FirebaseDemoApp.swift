//
//  FirebaseDemoApp.swift
//  FirebaseDemo
//
//  Created by Luis Calmon on 28/12/20.
//

import SwiftUI
import Firebase
import StoreKit

@main
struct FirebaseDemoApp: App {
    
    let productIDs = [
           //Use your product IDs instead
           "ThankForYourSupportProductID"
       ]
    
    @StateObject var storeManager = StoreManager()
    @StateObject var userManager = UserManager()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear(perform: {
                    storeManager.getProducts(productIDs: productIDs)
                    SKPaymentQueue.default().add(storeManager)
                })
                .environmentObject(storeManager)
                .environmentObject(userManager)
        }
    }
    init() { FirebaseApp.configure() }
}
