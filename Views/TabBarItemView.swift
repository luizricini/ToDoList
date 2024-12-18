//
//  TabBarItemView.swift
//  ToDoList
//
//  Created by Henrique on 03/09/24.
//

import SwiftUI

struct TabBarItemView: View {
    let imageUrl: String?
    
    var body: some View {
        if let imageUrl = imageUrl, let url = URL(string: imageUrl) {
            AsyncImage(url: url) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 20, height: 20)
                    .clipShape(Circle())
            } placeholder: {
                Image(systemName: "person.circle")
            }
        } else {
            Image(systemName: "person.circle")
                .resizable()
                .frame(width: 20, height: 20)
        }
        }
    }


#Preview {
    TabBarItemView(imageUrl: "")
}
