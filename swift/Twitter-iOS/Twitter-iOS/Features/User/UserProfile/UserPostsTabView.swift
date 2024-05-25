import SwiftUI

struct UserPostsTabView: View {
  var body: some View {
    // TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/189
    // - Disable bounce of ScrollView in UserPostsTabView.
    ScrollView {
      LazyVStack(spacing: 0) {
        ForEach(0..<30) { _ in
          createFakeTweetCellView()
        }
      }
    }
  }
}

#Preview {
  UserPostsTabView()
}
