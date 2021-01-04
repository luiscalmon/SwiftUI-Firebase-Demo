//
//  GenericHelper.swift
//  FirebaseDemo
//
//  Created by Luis Calmon on 2/1/21.
//

import SwiftUI

protocol GenericHelper: Codable & Identifiable & Comparable {
    
    associatedtype C0: View
    associatedtype C1: View
    
    static var title: String { get }
    static var container: String { get }
    
    static func descriptionView(_ element: Self) -> C0
    static func detailView(_ element: Binding<Self>) -> C1
    
    var userid: String { get set }
    init(userid: String)
    
}
