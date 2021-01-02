//
//  Row.swift
//  FirebaseDemo
//
//  Created by Luis Calmon on 2/1/21.
//

import SwiftUI

struct Row<T: RemoteBackendHelper>: View {
    
    let repository: FirestoreBackend<T>
    @Environment(\.presentationMode) var presentationMode
    @State var row: T
    var new = false
    
    var body: some View {
        if new {
            NavigationView {
                T.detailView($row)
                    .navigationBarItems(
                        leading: Button(
                            action: {
                                presentationMode.wrappedValue.dismiss()
                            },
                            label: {Text("Cancel")}),
                        trailing: Button(
                            action: {
                                repository.add(row)
                                presentationMode.wrappedValue.dismiss()
                            },
                            label: {Text("Done")})
                        
                    )
                    .navigationBarBackButtonHidden(true)
                    .padding()
            }
        } else {
            T.detailView($row)
                .onDisappear {
                    repository.update(row)
                }
                .padding()
        }
    }
}
