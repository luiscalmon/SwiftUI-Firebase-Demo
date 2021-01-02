//
//  Classified.swift
//  FirebaseDemo
//
//  Created by Luis Calmon on 2/1/21.
//

import SwiftUI

struct Classified: RemoteBackendHelper {
    init(userid: String) {
        self.userid = userid
    }
    
    static func <(lhs: Self, rhs: Self) -> Bool { lhs.date > rhs.date }
    static func descriptionView(_ element: Classified) -> some View {
        Text(element.text).lineLimit(4)
    }
    static func detailView(_ element: Binding<Classified>) -> some View {
        TextEditor(text: element.text).lineLimit(4)
    }
    static var title = "Classifieds"
    static var container = "Classified"
    var id = UUID()
    var userid: String
    var date = Date()
    
    var text = "new classified"
}
