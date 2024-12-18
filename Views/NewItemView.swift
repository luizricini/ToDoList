//
//  NewItemView.swift
//  ToDoList
//
//  Created by Luiz Ricini on 01/09/24.
//

import SwiftUI

struct NewItemView: View {
    @StateObject var viewModel = NewItemViewViewModel()
    @Binding var newItemPresentend: Bool
    
    var body: some View {
        VStack {
            Text("New item")
                .font(.system(size: 28))
                .bold()
                .padding()
            
            Form {
                // Title
                TextField("Title", text: $viewModel.title)
                    .textFieldStyle(DefaultTextFieldStyle())
                // Due date
                DatePicker("Due date", selection: $viewModel.dueDate)
                    .datePickerStyle(GraphicalDatePickerStyle())
                
                // Button
                CustomButton(label: "Save",
                             labelcolor: .white, 
                             background: .accentColor) {
                    if viewModel.canSave {
                        viewModel.save()
                        newItemPresentend = false
                    } else {
                        viewModel.showAlert = true
                    }
                }
                             .padding()
            }
            .alert(isPresented: $viewModel.showAlert) {
                Alert(
                    title: Text("Error"),
                    message: Text("Please fill all fields and select due date that is today or newer."))
            }
        }
    }
}

#Preview {
    NewItemView(newItemPresentend: Binding(get: {
        return true
    }, set: { _ in
        
    }))
}
