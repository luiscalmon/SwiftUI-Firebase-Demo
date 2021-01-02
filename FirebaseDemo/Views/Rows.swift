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
                Button(action: {
                    newRow.toggle()
                }) {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $newRow) {
                Row(repository: repository, row: T(userid: userid), new: true)
            }
            .navigationBarTitle(Text(T.title))
        }
        .padding()
    }
}
