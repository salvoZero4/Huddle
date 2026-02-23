//
//  SearchView.swift
//  Huddle
//
//  Created by Salvatore Scaravalle on 20/02/26.
//

import SwiftUI

struct SearchView: View {
    @Binding var huddles: [Huddle]
    @Binding var user: User
    
    @State private var searchText = ""
    @State private var selectedCategory: String? = nil
    
    let categories: [(String, String, Color)] = [
        ("All",           "square.grid.2x2",      Color.gray),
        ("Calculus",      "function",              Color.blue),
        ("Physics",       "atom",                  Color.orange),
        ("Computer",      "desktopcomputer",        Color.green),
        ("Medicine",      "cross.case.fill",        Color.red),
        ("Biology",       "leaf.fill",              Color.teal),
        ("Chemistry",     "flask.fill",             Color.purple),
        ("Design",        "paintbrush.fill",        Color.pink),
        ("Linear Algebra","sum",                    Color.indigo),
        ("Data Mining",   "chart.dots.scatter",     Color.cyan)
    ]
    
    var filteredHuddles: [Huddle] {
        huddles.filter { huddle in
            let matchesSearch = searchText.isEmpty ||
                huddle.subject.localizedCaseInsensitiveContains(searchText) ||
                huddle.engineering.localizedCaseInsensitiveContains(searchText)
            let matchesCategory = selectedCategory == nil ||
                huddle.subject.localizedCaseInsensitiveContains(selectedCategory!) ||
                huddle.engineering.localizedCaseInsensitiveContains(selectedCategory!)
            return matchesSearch && matchesCategory
        }
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    
                    // MARK: - Title
                    Text("Explore Huddle")
                        .font(.largeTitle).bold()
                        .padding(.horizontal)
                    
                    // MARK: - Category Pills
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 16) {
                            ForEach(categories, id: \.0) { name, icon, color in
                                VStack(spacing: 6) {
                                    Button(action: {
                                        if name == "All" {
                                            selectedCategory = nil
                                        } else {
                                            selectedCategory = selectedCategory == name ? nil : name
                                        }
                                    }) {
                                        Image(systemName: icon)
                                            .font(.system(size: 24))
                                            .foregroundColor(.white)
                                            .frame(width: 60, height: 60)
                                            .background(
                                                (name == "All" && selectedCategory == nil) || selectedCategory == name
                                                    ? color.opacity(0.5) : color
                                            )
                                            .cornerRadius(16)
                                    }
                                    Text(name)
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                    
                    // MARK: - Search Bar
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                        TextField("Search", text: $searchText)
                    }
                    .padding(12)
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                    .padding(.horizontal)
                    
                    // MARK: - Results
                    VStack(spacing: 12) {
                        if filteredHuddles.isEmpty {
                            Text("No huddles found")
                                .foregroundColor(.gray)
                                .frame(maxWidth: .infinity)
                                .padding(.top, 40)
                        } else {
                            ForEach(filteredHuddles) { huddle in
                                NavigationLink(destination: DetailView(huddle: huddle,user: $user)) {
                                    HuddleCardView(huddle: huddle)
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                .padding(.top)
            }
        }
    }
}
