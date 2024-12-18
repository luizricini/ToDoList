//
//  ToDoListViewViewModel.swift
//  ToDoList
//
//  Created by Luiz Ricini on 01/09/24.
//

import FirebaseFirestore
import Foundation

class ToDoListViewViewModel: ObservableObject {
    @Published var showingNewItemView = false
    @Published var groupedItems: [Date: [ToDoListItem]] = [:]
    
    private let userId: String
    private var listenerRegistration: ListenerRegistration?
    
    init(userId: String) {
        self.userId = userId
        fetchTasks()
    }
    
    func fetchTasks() {
        let db = Firestore.firestore()
        
        listenerRegistration = db.collection("users")
            .document(userId)
            .collection("todos")
            .addSnapshotListener { [weak self] snapshot, error in
                guard let documents = snapshot?.documents, error == nil else {
                    return
                }
                
                let items = documents.compactMap { document -> ToDoListItem? in
                    try? document.data(as: ToDoListItem.self)
                }
                
                self?.groupedItems = Dictionary(grouping: items) { item in
                    let date = Date(timeIntervalSince1970: item.dueDate)
                    return Calendar.current.startOfDay(for: date)
                }
            }
    }
    
    func delete(id: String) {
        let db = Firestore.firestore()
        
        db.collection("users")
            .document(userId)
            .collection("todos")
            .document(id)
            .delete()
    }
    
    deinit {
        listenerRegistration?.remove()
    }
}
