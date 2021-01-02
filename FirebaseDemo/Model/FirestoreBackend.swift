//
//  FirestoreBackend.swift
//  FirestoreDemo
//
//  Created by Luis Calmon on 26/12/20.
//

import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseAuth


protocol ContainerHelper {
    associatedtype C0: View
    associatedtype C1: View
    
    static var title: String { get }
    static var container: String { get }
    
    static func descriptionView(_ element: Self) -> C0
    static func detailView(_ element: Binding<Self>) -> C1
    
    var userid: String { get set }
    init(userid: String)
}

typealias RemoteBackendHelper = Codable & Identifiable & ContainerHelper & Comparable 

class FirestoreBackend<T: RemoteBackendHelper>: ObservableObject {
    struct Document: Codable {
        @DocumentID var documentID: String?
        var documentDATA: T
    }
    private var collection = Firestore.firestore().collection(T.container)
    @Published private var documents = [Document]()
    var elements: [T] {
        documents.map { $0.documentDATA }.sorted()
    }
    init() {
        self.collection.addSnapshotListener { (querySnapshot, _) in
            if let querySnapshot = querySnapshot {
                self.documents = querySnapshot.documents.compactMap {
                    try? $0.data(as: Document.self)
                }
            }
        }
    }
    func add(_ element: T) {
        let _ = try? collection.addDocument(from: Document(documentDATA: element))
    }
    func update(_ element: T) {
        if let document = documents.first(where: { $0.documentDATA.id == element.id }),
           let documentID = document.documentID {
            let _ = try? collection.document(documentID).setData(from: Document(documentDATA: element))
        }
    }
    func delete(_ element: T) {
        if let document = documents.first(where: { $0.documentDATA.id == element.id }),
           let documentID = document.documentID {
            collection.document(documentID).delete()
        }
    }
    func delete(_ userid: String) {
        let a = documents
        let b = a.count
        documents.filter {
            $0.documentDATA.userid == userid
        }
        .forEach {
            if let documentID = $0.documentID {
                collection.document(documentID).delete()
            }
        }
    }
}