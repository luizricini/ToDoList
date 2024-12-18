//
//  CustomButton.swift
//  ToDoList
//
//  Created by Luiz Ricini on 01/09/24.
//

import SwiftUI

struct CustomButton: View {
    
    let label: String
    let labelcolor: Color
    let background: Color
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(background)
                 
                Text(label)
                    .foregroundColor(labelcolor)
                    .bold()
            }
        }
    }
}

#Preview {
    CustomButton(label: "Text", 
                 labelcolor: .white,
                 background: .accentColor) {
        // Action
    }
}
