//
//  ProfileViewViewModel.swift
//  ToDoList
//
//  Created by Luiz Ricini on 01/09/24.
//

import FirebaseAuth
import FirebaseFirestore
import Foundation

class ProfileViewViewModel: ObservableObject {
    init() {
    }
    
    @Published var user: User? = nil
    @Published var availableAvatars: [String] = []
    
    func fetchUser() {
        guard let userId = Auth.auth().currentUser?.uid else {
            return
        }
        
        let db = Firestore.firestore()
        db.collection("users").document(userId).getDocument {
            [weak self] snapshot, error in
            guard let data = snapshot?.data(), error == nil else {
                return
            }
            
            // Let's try get profile pic (from Firebase)
            
            DispatchQueue.main.async {
                self?.user = User(
                    profilePic: data["profilePic"] as? String ?? "",
                    id: data["id"] as? String ?? "",
                    name: data["name"] as? String ?? "",
                    email: data["email"] as? String ?? "",
                    joined: data["joined"] as? TimeInterval ?? 0
                )
            }
        }
        
    }
    
    func fetchAvatars() {
        // we going use dicebear dummies avatars
        let dummyAvatars = [
            "https://avatar.iran.liara.run/public/35",
            "https://avatar.iran.liara.run/public/10",
            "https://avatar.iran.liara.run/public/8",
            "https://avatar.iran.liara.run/public/4",
            "https://avatar.iran.liara.run/public/48",
            "https://avatar.iran.liara.run/public/57",
            "https://avatar.iran.liara.run/public/73",
            "https://avatar.iran.liara.run/public/85",
            "https://avatar.iran.liara.run/public/95",
            "https://avatar.iran.liara.run/public/89",
            "https://avatar.iran.liara.run/public/63"
        ]
        
        DispatchQueue.main.async {
            self.availableAvatars = dummyAvatars
        }
    }
    
    // function for edit avatar
    func updateProfilePic(url: String) {
        guard let userId = Auth.auth().currentUser?.uid else {
            return
        }
        
        // connect db
        let db = Firestore.firestore()
        db.collection("users").document(userId).updateData([
            "profilePic": url
        ]) { error in
            if let error = error {
                print("Error updating profile: \(error)")
            } else {
                DispatchQueue.main.async {
                    self.user?.profilePic = url
                }
            }
            
        }
    }
    
    func logOut() {
        do {
            try Auth.auth().signOut()
        } catch {
            print(error)
        }
    }
}
