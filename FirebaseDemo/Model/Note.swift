//
//  Note.swift
//  FirestoreDemo
//
//  Created by Luis Calmon on 26/12/20.
//

import SwiftUI

struct Note: RemoteBackendHelper {
    init(userid: String) {
        self.userid = userid
    }
    
    static func <(lhs: Self, rhs: Self) -> Bool { lhs.date > rhs.date }
    static func descriptionView(_ element: Note) -> some View {
        Text(element.text).lineLimit(2)
    }
    static func detailView(_ element: Binding<Note>) -> some View {
        TextEditor(text: element.text)
    }
    static var title = "Notes"
    static var container = "Notes"
    var id = UUID()
    var userid: String
    var date = Date()
    
    var text = "new note" {
        didSet {
            date = Date()
        }
    }
}
