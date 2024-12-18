//
//  ToDoListItemView.swift
//  ToDoList
//
//  Created by Luiz Ricini on 01/09/24.
//

import SwiftUI

struct ToDoListItemView: View {
    @StateObject var viewModel = ToDoListItemViewViewModel()
    let item: ToDoListItem
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(item.title)
                    .font(.body)
                Text("\(Date(timeIntervalSince1970: item.dueDate).formatted(date: .omitted, time: .shortened))")
                    .font(.footnote)
                    .foregroundStyle(Color(.secondaryLabel))
                
                // Tag status
                Text(statusText)
                    .font(.caption2)
                    .padding(5)
                    .background(statusBackgroundColor)
                    .foregroundColor(.white)
                    .clipShape(Capsule())
            }
            Spacer()
            
            Button {
                viewModel.toggleIsDone(item: item)
            } label: {
                Image(systemName: item.isDone ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(Color.accentColor)
            }
            
        }
    }
    
    private var statusText: String {
        if item.isDone {
            return "Done"
        } else if Date().timeIntervalSince1970 > item.dueDate {
            return "Missed"
        } else if Date().timeIntervalSince1970 > item.dueDate - 3600 {
            return "Expiring soon"
        } else {
            return "Active"
        }
    }
    
    private var statusBackgroundColor: Color {
        if item.isDone {
            return Color.accentColor
        } else if Date().timeIntervalSince1970 > item.dueDate {
            return Color.red
        } else if Date().timeIntervalSince1970 > item.dueDate - 3600 {
            return Color.orange
        } else {
            return Color.green
        }
    }
}

#Preview {
    ToDoListItemView(item: .init(
        id: "123",
        title: "Get milk",
        dueDate: Date().timeIntervalSince1970,
        createdDate: Date().timeIntervalSince1970,
        isDone: false
    ))
}
