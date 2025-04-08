//
//  ContentView.swift
//  schoolTerms
//
//  Created by Sanzhar  Zhabagin  on 25.03.2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                VStack {
                    SearchBar()
                }
                .padding()
                .background(Color.blue)
                .cornerRadius(20)
                
                HStack(spacing: 16) {
                    NavigationLink(destination: DictionaryView()) {
                        DictionaryCard(title: "Словарь", iconName: "book", isSelected: true)
                    }
                    
                    NavigationLink(destination: FavoritesView()) {
                        DictionaryCard(title: "Избранное", iconName: "bookmark", isSelected: false)
                    }
                }
                .padding(.horizontal, 16)
                
                Spacer()
            }
            .background(Color(UIColor.systemGroupedBackground))
            
        }
    }
}



#Preview {
    ContentView()
}
