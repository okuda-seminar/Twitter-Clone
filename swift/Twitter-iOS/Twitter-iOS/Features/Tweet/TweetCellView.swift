import SwiftUI

struct TweetCellView: View {
  @Binding public var showShareSheet: Bool
  // We need to wait for dismissal completion. pendingShowShareSheet
  // will be propageted to showShareSheet after the completion.
  @State private var pendingShowShareSheet: Bool = false

  @State var showSheet: Bool = false

  public var userIcon: Image
  public var userName: String
  public var tweetBody: String

  @State private var isBottomSheetPresented = false

  private enum LayoutConstant {
    static let userIconSize: CGFloat = 32.0
    static let initialBottomSheetHeight: CGFloat = 250.0
  }

  var body: some View {
    VStack {
      Divider()

      HStack(alignment: .top) {
        userIcon
          .resizable()
          .scaledToFit()
          .frame(width: LayoutConstant.userIconSize, height: LayoutConstant.userIconSize)
          .padding(.trailing)

        VStack(alignment: .leading) {
          HStack {
            Text(userName)
            Spacer()
            Button(
              action: {
                print("Need to show ContextMenu.")
              },
              label: {
                Image(systemName: "ellipsis")
              }
            )
            .foregroundStyle(.primary)
            .buttonStyle(.plain)
          }

          Text(tweetBody)
            .padding(.bottom)

          HStack {
            Spacer()
            Button(
              action: {
                print("Need to trigger bookmark.")
              },
              label: {
                Image(systemName: "bookmark")
              }
            )
            .foregroundStyle(.primary)
            .buttonStyle(.plain)

            Button(
              action: {
                isBottomSheetPresented.toggle()
              },
              label: {
                Image(systemName: "square.and.arrow.up")
              }
            )
            .foregroundStyle(.primary)
            .buttonStyle(.plain)
            .sheet(
              isPresented: $isBottomSheetPresented,
              onDismiss: {
                Task { @MainActor in
                  showShareSheet = pendingShowShareSheet
                }
              },
              content: {
                TweetShareBottomSheet(showShareSheet: $pendingShowShareSheet)
                  .presentationDetents([.height(LayoutConstant.initialBottomSheetHeight)])
              })
          }
        }
      }
      .padding()

      Divider()
    }
  }
}

func createFakeTweetCellView() -> TweetCellView {
  return TweetCellView(
    showShareSheet: .constant(false), userIcon: Image(systemName: "apple.logo"), userName: "Apple",
    tweetBody:
      "If you’re looking to make your app more responsive or simply want to give your users access to certain features through various methods like a long press or hidden button, then you absolutely have to read this post!"
  )
}

#Preview {
  createFakeTweetCellView()
}
