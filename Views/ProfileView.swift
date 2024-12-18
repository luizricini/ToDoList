//
//  ProfileView.swift
//  ToDoList
//
//  Created by Luiz Ricini on 01/09/24.
//


import SwiftUI

struct ProfileView: View {
    @StateObject var viewModel = ProfileViewViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                if let user = viewModel.user {
                    profile(user: user)
                } else {
                    Text("Loading profile...")
                }
            }
            .navigationTitle("Profile")
        }
        .onAppear {
            viewModel.fetchUser()
            viewModel.fetchAvatars()
        }
    }
    
    @ViewBuilder
    func profile(user: User) -> some View {
        // Avatar
        if let profilePic = URL(string: user.profilePic), !user.profilePic.isEmpty {
            AsyncImage(url: profilePic) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 125, height: 125)
                    .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                    .padding()
            } placeholder: {
                ProgressView()
                    .frame(width: 125, height: 125)
            }
        } else {
            Image(systemName: "person.circle")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundColor(Color.accentColor)
                .frame(width: 125, height: 125)
                .padding()
        }
        
        // Infos
        VStack(alignment: .leading) {
            HStack {
                Text("Name: ")
                    .bold()
                Text(user.name)
            }
            
            HStack {
                Text("Email: ")
                    .bold()
                Text(user.email)
            }
            
            HStack {
                Text("Member since: ")
                    .bold()
                Text("\(Date(timeIntervalSince1970: user.joined).formatted(date: .abbreviated, time: .shortened))")
            }
        }
        .padding()
        
        // Avatars selection
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(viewModel.availableAvatars, id: \.self) { avatar in
                    Button(action: {
                        viewModel.updateProfilePic(url: avatar)
                    }) {
                        AsyncImage(url: URL(string: avatar)) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 60, height: 60)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.accentColor, lineWidth: 2))
                        } placeholder: {
                            ProgressView()
                                .frame(width: 60, height: 60)
                        }
                    }
                    .padding()
                }
            }
        }
        .padding()
        
        // Sign out
        Button("Sign out"){
            viewModel.logOut()
        }
        .tint(.red)
        .padding()
        Spacer()
    }
}

#Preview {
    ProfileView()
}
