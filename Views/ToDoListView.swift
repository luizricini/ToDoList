//
//  ToDoListView.swift
//  ToDoList
//
//  Created by Luiz Ricini on 01/09/24.
//

import FirebaseFirestore
import SwiftUI

struct ToDoListView: View {
    @StateObject var viewModel: ToDoListViewViewModel
    @FirestoreQuery var items: [ToDoListItem]
    
    init (userId: String) {
        self._items = FirestoreQuery(
            collectionPath: "users/\(userId)/todos"
        )
        self._viewModel = StateObject(
            wrappedValue: ToDoListViewViewModel(userId: userId)
        )
    }
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                  ForEach(groupedItems.keys.sorted(), id: \.self) { date in
                      Section(header: Text(dateFormatted(date))) {
                          ForEach(groupedItems[date] ?? []) { item in
                              ToDoListItemView(item: item)
                                  .swipeActions {
                                      Button("Delete") {
                                          viewModel.delete(id: item.id)
                                      }
                                      .tint(.red)
                                  }
                          }
                      }
                  }
                }
                .listStyle(PlainListStyle())
            }
            .navigationTitle("todo4me")
            .toolbar {
                Button {
                    viewModel.showingNewItemView = true
                } label: {
                    Image(systemName: "plus")
                }

            }
            .sheet(isPresented: $viewModel.showingNewItemView) {
                NewItemView(newItemPresentend: $viewModel.showingNewItemView)
            }
        }
    }
    
    func dateFormatted(_ date: Date) -> String {
        return DateFormatter.localizedString(from: date, dateStyle: .medium, timeStyle: .none)
    }
    
    private var groupedItems: [Date: [ToDoListItem]] {
        Dictionary(grouping: items) { item in
            Calendar.current.startOfDay(for: Date(timeIntervalSince1970: item.dueDate))
            
        }
    }
}

#Preview {
    ToDoListView(userId: "NFQWdZrzgHVGTdBt4zuIqldhhce2")
}
