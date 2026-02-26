//
//  SearchView.swift
//  Huddle
//
//  Created by Salvatore Scaravalle on 20/02/26.
//

import SwiftUI
import Foundation

struct EngineeringCategory: Identifiable {
    let id = UUID()
    let name: String
    let icon: String
    let color: Color
}

let engCategories = [
    EngineeringCategory(name: "Computer", icon: "desktopcomputer", color: .cyan),
    EngineeringCategory(name: "Management", icon: "chart.bar.fill", color: .green),
    EngineeringCategory(name: "Electrical", icon: "bolt.fill", color: .orange),
    EngineeringCategory(name: "Civil", icon: "building.2.fill", color: .gray),
    EngineeringCategory(name: "Biomedical", icon: "heart.text.square.fill", color: .red),
    EngineeringCategory(name: "Mechanical", icon: "gearshape.fill", color: .blue)
]

struct SearchView: View {
    @State var huddles: [Huddle] = []
    @Binding var user: User
    @State private var searchText = ""
    @State private var selectedCategory: String? = nil
    
    // VARIABILE PER I FILTRI
    var filteredHuddles: [Huddle] {
        var result = huddles
        
        if let category = selectedCategory {
            result = result.filter { $0.subject == category || $0.engineering == category }
        }
        
        if !searchText.isEmpty {
            result = result.filter { $0.subject.lowercased().contains(searchText.lowercased()) }
        }
        
        return result
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {

                    Text("Explore Huddle")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.horizontal)
                        .foregroundColor(.blue)

                    // BARRA DI RICERCA
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                        TextField("Search", text: $searchText)
                    }
                    .padding(12)
                    .background(Color(.systemGray6))
                    .cornerRadius(15)
                    .padding(.horizontal)

                    // CATEGORIE INGEGNERIA
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 15) {
                            ForEach(engCategories) { category in
                                Button(action: {
                                    if selectedCategory == category.name {
                                        selectedCategory = nil
                                    } else {
                                        selectedCategory = category.name
                                    }
                                }) {
                                    CategoryButton(
                                        icon: category.icon,
                                        title: category.name,
                                        color: category.color
                                    )
                                }
                            }
                        }
                        .padding(.horizontal)
                    }

                    // LISTA DEGLI HUDDLE
                    VStack(spacing: 16) {
                        ForEach(filteredHuddles) { huddle in
                            NavigationLink(destination: DetailView(user: $user, huddle: huddle)) {
                                HuddleCard(huddle: huddle)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    .padding(.horizontal)
                }
                .padding(.top)
            }
            .onAppear {
                // Appena si apre la schermata, scarica i dati da ParthenoKit!
                self.huddles = HuddleService.shared.fetchAllHuddles()
            }
        }
    }
}

struct CategoryButton: View {
    var icon: String
    var title: String
    var color: Color
    
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.title)
                .foregroundColor(.white)
                .frame(width: 70, height: 70)
                .background(color)
                .cornerRadius(20)
            
            Text(title)
                .font(.caption)
                .bold()
                .foregroundColor(.primary)
        }
    }
}

struct HuddleCard: View {
    let huddle: Huddle
    
    private func getCategoryInfo() -> (icon: String, color: Color) {
        if let category = engCategories.first(where: { $0.name == huddle.engineering }) {
            return (category.icon, category.color)
        }
        return ("person.3.fill", .blue)
    }
    
    var body: some View {
        HStack(spacing: 15) {
            ZStack {
                let info = getCategoryInfo()
                
                RoundedRectangle(cornerRadius: 12)
                    .fill(info.color.opacity(0.1))
                    .frame(width: 60, height: 60)
                
                Image(systemName: info.icon)
                    .foregroundColor(info.color)
                    .font(.title2)
            }
            
            VStack(alignment: .leading, spacing: 2) {
                Text(huddle.engineering)
                    .font(.caption2)
                    .foregroundColor(.secondary)
                
                Text(huddle.subject)
                    .font(.headline)
                
                HStack(spacing: 4) {
                    Image(systemName: "mappin.and.ellipse")
                    Text("\(huddle.building) \(huddle.room)")
                }
                .font(.caption2)
                .foregroundColor(.secondary)
            }
            
            Spacer()
            
            Text(huddle.date, format: .dateTime.hour().minute())
                .font(.system(size: 14, weight: .bold))
                .padding(.horizontal, 10)
                .padding(.vertical, 6)
                .background(Color(.systemGray5))
                .cornerRadius(10)
        }
        .padding()
        .background(Color(.systemGray6).opacity(0.4))
        .cornerRadius(20)
    }
}

#Preview {
    SearchView(
        user: .constant(User(userName: "Daniele", mail: "daniele@community.unipa.it", huddles: []))
    )
}
