//
//  MainViewViewModel.swift
//  ToDoList
//
//  Created by Luiz Ricini on 01/09/24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class MainViewViewModel: ObservableObject {
    @Published var currentUserId: String = ""
    @Published var currentUserAvatar: String = ""
    private var handler: AuthStateDidChangeListenerHandle?
    
    init() {
        self.handler = Auth.auth().addStateDidChangeListener { [weak self] _, user in
            DispatchQueue.main.async {
                self?.currentUserId = user?.uid ?? ""
            }
        }
        
        // if isSignedIn, !currentUserId.isEmpty {
        //     fetchUserAvatar()
        // }
    }
    
    func fetchUserAvatar() {
        let db = Firestore.firestore()
        db.collection("users").document(currentUserId).getDocument { [weak self ] snapshot, error in
            guard let data = snapshot?.data(), error == nil else {
                return
            }
            
            DispatchQueue.main.async {
                self?.currentUserAvatar = data["profilePic"] as? String ?? ""
            }
        }
    }
    
    public var isSignedIn: Bool {
        return Auth.auth().currentUser != nil
    }
}
