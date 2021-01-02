//
//  Task.swift
//  FirestoreDemo
//
//  Created by Luis Calmon on 26/12/20.
//

import SwiftUI

struct Task: RemoteBackendHelper {
    init(userid: String) {
        self.userid = userid
    }
    
    static func <(lhs: Self, rhs: Self) -> Bool { lhs.date < rhs.date }
    static func descriptionView(_ element: Task) -> some View {
        HStack {
            element.completed ? Image(systemName: "checkmark.circle.fill"): Image(systemName: "circle")
            Text(element.text).lineLimit(2)
        }
    }
    static func detailView(_ element: Binding<Task>) -> some View {
        VStack {
            Toggle(isOn: element.completed, label: {Text("Completed")})
            TextEditor(text: element.text)
        }
    }
    static var title = "Tasks"
    static var container = "NewTask"
    var id = UUID()
    var userid: String
    var date = Date()
    
    var text = "new task"
    var completed = false
}
