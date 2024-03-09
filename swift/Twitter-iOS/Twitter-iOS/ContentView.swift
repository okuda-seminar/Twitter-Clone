//
//  ContentView.swift
//  Twitter-iOS
//
//  Created by 奥田遼 on 2024/03/09.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]

    var body: some View {
      TabView {
        Text("X").tabItem { Image(systemName: "house") }
        Text("Search").tabItem { Image(systemName: "magnifyingglass") }
        Text("Communities").tabItem { Image(systemName: "person.2") }
        Text("Notifications").tabItem { Image(systemName: "bell") }
        Text("Messages").tabItem { Image(systemName: "envelope") }
      }
    }

    private func addItem() {
        withAnimation {
            let newItem = Item(timestamp: Date())
            modelContext.insert(newItem)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
