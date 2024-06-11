import SwiftUI

struct UserPostsTabView: View {
  var body: some View {
    // TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/189
    // - Disable bounce of ScrollView in UserPostsTabView.
    VStack(spacing: 0) {
      ForEach(0..<30) { _ in
        createFakePostCellView()
      }
    }
  }
}

#Preview {
  UserPostsTabView()
}
