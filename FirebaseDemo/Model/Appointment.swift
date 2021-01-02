//
//  Appoiment.swift
//  FirestoreDemo
//
//  Created by Luis Calmon on 26/12/20.
//

import SwiftUI

struct Appointment: GenericHelper {
    init(userid: String) {
        self.userid = userid
    }
    
    static func <(lhs: Self, rhs: Self) -> Bool { lhs.date < rhs.date }
    static func descriptionView(_ element: Appointment) -> some View {
        VStack {
            HStack {
                Text(element.date, style: .date)
                Text(element.date, style: .time)
            }
            Text(element.text).lineLimit(2)
        }
    }
    static func detailView(_ element: Binding<Appointment>) -> some View {
        VStack {
            DatePicker(selection: element.date) {
                EmptyView()
            }
            TextEditor(text: element.text)
        }
    }
    static var title = "Agenda"
    static var container = "Agenda"
    var id = UUID()
    var userid: String
    
    var date = Date()
    var text = "new appoiment"
}
