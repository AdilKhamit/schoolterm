//
//  structOfDesing.swift
//  schoolTerms
//
//  Created by Sanzhar  Zhabagin  on 25.03.2025.
//

import SwiftUI

struct SearchBar: View {
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
            Text("Search a word")
                .foregroundColor(.gray)
            Spacer()
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .padding(.horizontal, 16)
    }
}

struct DictionaryCard: View {
    let title: String
    let iconName: String
    let isSelected: Bool
    
    var body: some View {
        VStack {
            Image(systemName: iconName)
                .font(.system(size: 40))
                .foregroundColor(isSelected ? .white : .black)
            Text(title)
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(isSelected ? .white : .black)
        }
        .frame(width: 150, height: 150)
        .background(isSelected ? Color.blue : Color.white)
        .cornerRadius(12)
        .shadow(radius: isSelected ? 5 : 2)
    }
}

struct DictionaryView: View {
    let subjects = ["Математика", "Физика", "Биология", "Естествознание", "Информатика", "Химия", "География"]
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.blue)
                        .font(.title2)
                }
                Spacer()
            }
            .padding()
            
            ScrollView {
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                    ForEach(subjects, id: \ .self) { subject in
                        NavigationLink(destination: TermsView(subject: subject)) {
                                                    DictionaryCard(title: subject, iconName: "book", isSelected: false)
                                                }
                    }
                }
                .padding()
            }
        }
        .navigationTitle("Словарь")
        .navigationBarHidden(true)
    }
}

struct TermsView: View {
    let subject: String
    let terms: [String] = ["Термин 1", "Термин 2", "Термин 3"] // Заглушка

    var body: some View {
        List(terms, id: \.self) { term in
            NavigationLink(destination: TermDetailView(term: term)) {
                Text(term)
                    .font(.headline)
                    .padding()
            }
        }
        .navigationTitle(subject)
    }
}

struct TermDetailView: View {
    let term: String
    @State private var isFavorite = false
    @AppStorage("favoriteTerms") private var favoriteTerms: String = ""

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text(term)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Spacer()
                
                Button(action: {
                    toggleFavorite()
                }) {
                    Image(systemName: isFavorite ? "heart.fill" : "heart")
                        .resizable()
                        .frame(width: 28, height: 28)
                        .foregroundColor(isFavorite ? .red : .gray)
                }
            }
            .padding()

            Text("Здесь будет API. Надо доработать")
                .font(.body)
                .padding(.horizontal)

            Spacer()
        }
        .navigationTitle("Термин")
        .padding()
        .onAppear {
            isFavorite = getFavoriteStatus()
        }
    }

    private func toggleFavorite() {
        var terms = favoriteTerms.split(separator: ",").map(String.init)
        
        if let index = terms.firstIndex(of: term) {
            terms.remove(at: index)
        } else {
            terms.append(term)
        }
        
        favoriteTerms = terms.joined(separator: ",")
        isFavorite.toggle()
    }

    private func getFavoriteStatus() -> Bool {
        let terms = favoriteTerms.split(separator: ",").map(String.init)
        return terms.contains(term)
    }
}


struct FavoritesView: View {
    @AppStorage("favoriteTerms") private var favoriteTerms: String = ""

    var body: some View {
        VStack {
            if favoriteTerms.isEmpty {
                Text("Избранных терминов пока нет")
                    .foregroundColor(.gray)
                    .font(.headline)
                    .padding()
            } else {
                List(favoriteTerms.split(separator: ",").map(String.init), id: \.self) { term in
                    Text(term)
                }
            }
        }
        .navigationTitle("Избранное")
    }
}

