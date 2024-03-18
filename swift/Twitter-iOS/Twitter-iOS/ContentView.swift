//
//  ContentView.swift
//  Twitter-iOS
//
//  Created by 奥田遼 on 2024/03/09.
//

import SwiftUI
import SwiftData

struct ContentView: View {
  var body: some View {
    HomeFooterTabView()
  }
}



#Preview {
  ContentView()
    .modelContainer(for: Item.self, inMemory: true)
}
