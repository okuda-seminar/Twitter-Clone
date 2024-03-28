import SwiftUI

struct NewTweetButton: View {
  @State var showSheet: Bool = false

  private enum LayoutConstant {
    static let buttonWidth = 84.0
    static let buttonHeight = 44.0
  }

  var body: some View {
    Button(action: {
      showSheet.toggle()
    }, label: {
      Text(String(localized: "Post"))
        .underline()
        .frame(width: LayoutConstant.buttonWidth, height: LayoutConstant.buttonHeight)
    })
    .clipShape(Capsule())
    .buttonStyle(RoundedButtonStyle())
  }
}

#Preview {
    NewTweetButton()
}
