//
//  Rows.swift
//  FirestoreDemo
//
//  Created by Luis Calmon on 26/12/20.
//

import SwiftUI

struct Rows<T: GenericHelper>: View {
    
    @AppStorage ("userid") var userid: String!
    
    @ObservedObject var repository = FirestoreBackend<T>()
    @State var newRow = false
    @State var thanks = false
    var justOwnElements = true
    
    var body: some View {
        NavigationView {
            List {
                ForEach(repository.elements.filter({justOwnElements ? $0.userid == userid: true})) { row in
                    NavigationLink(destination: Row(repository: repository, row: row)) {
                        T.descriptionView(row)
                    }
                    .disabled(row.userid != userid)
                    .deleteDisabled(row.userid != userid)
                }
                .onDelete { indexSet in
                    if let index = indexSet.first {
                        repository.delete(repository.elements[index])
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        newRow.toggle()
                    }) {
                        Image(systemName: "plus")
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        thanks.toggle()
                    }) {
                        Image(systemName: "figure.wave")
                    }
                }

            }
            .sheet(isPresented: $newRow) {
                Row(repository: repository, row: T(userid: userid), new: true)
            }
            .sheet(isPresented: $thanks) {
                Thanks()
            }
            .navigationBarTitle(Text(T.title))
        }
        .padding()
    }
}
