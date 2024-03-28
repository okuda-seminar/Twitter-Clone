import SwiftUI

struct ContentView: View {
  var body: some View {
    TabView {
      HomeView()
        .tabItem{ Image(systemName: "house") }
    }
  }
}

#Preview {
  ContentView()
}
