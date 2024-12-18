//
//  RegisterView.swift
//  ToDoList
//
//  Created by Luiz Ricini on 01/09/24.
//

import SwiftUI

struct RegisterView: View {
    
    @StateObject var viewModel = RegisterViewViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                // Header
                HeaderView(title: "Register", subtitle: "Start organizing todos", background: .mint)
                
                // Login form
                Form {
                    TextField("Full name", text: $viewModel.name)
                        .textFieldStyle(DefaultTextFieldStyle())
                        .autocorrectionDisabled()
                    TextField("Email address", text: $viewModel.email)
                        .textFieldStyle(DefaultTextFieldStyle())
                        .autocorrectionDisabled()
                        .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                    SecureField("Enter password", text: $viewModel.password)
                        .textFieldStyle(DefaultTextFieldStyle())
                    
                    CustomButton(
                        label: "Register",
                        labelcolor: .white,
                        background: .mint
                    ) {
                        viewModel.register()
                    }
                    .padding()
                }
                .offset(y: -50)
                // Create account
                // VStack {
                //    Text("Do you have account?")
                //
                //    NavigationLink("Login here", destination: LoginView())
                // }
            }
            Spacer()
        }
    }
}

#Preview {
    RegisterView()
}
