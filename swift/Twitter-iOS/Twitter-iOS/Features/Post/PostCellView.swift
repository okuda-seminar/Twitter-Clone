import SwiftUI

struct PostCellView: View {
  @Binding public var showReplyEditSheet: Bool
  @Binding public var reposting: Bool
  @Binding public var postToRepost: PostModel?
  @Binding public var showShareSheet: Bool
  @Binding public var urlStrToOpen: String
  @State public var isRepostedByCurrentUser: Bool = false

  @Environment(\.openURL) private var openURL
  // We need to wait for dismissal completion. pendingShowShareSheet
  // will be propageted to showShareSheet after the completion.
  @State private var pendingShowShareSheet: Bool = false
  @State private var showSheet: Bool = false

  public var postModel: PostModel
  public var canReply: Bool = true

  @State private var isBottomSheetPresented = false

  private enum LayoutConstant {
    static let userIconSize: CGFloat = 32.0
    static let initialBottomSheetHeight: CGFloat = 250.0
  }

  var body: some View {
    VStack {
      Divider()

      HStack(alignment: .top) {
        Image(uiImage: postModel.userIcon)
          .resizable()
          .scaledToFit()
          .frame(width: LayoutConstant.userIconSize, height: LayoutConstant.userIconSize)
          .padding(.trailing)

        VStack(alignment: .leading) {
          HStack {
            Text(postModel.userName)
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

          Text(LocalizedStringKey(postModel.bodyText))
            .padding(.bottom)
            .environment(
              \.openURL,
              OpenURLAction { url in
                urlStrToOpen = url.absoluteString
                return .handled
              })

          ActionItemStack()
        }
      }
      .padding()

      Divider()
    }
  }

  @ViewBuilder
  private func ActionItemStack() -> some View {
    HStack {
      if canReply {
        Button(
          action: {
            showReplyEditSheet = true
          },
          label: {
            Image(systemName: "message")
          }
        )
        .foregroundStyle(.primary)
        .buttonStyle(.plain)
      } else {
        Button(
          action: {},
          label: {
            Image(systemName: "message")
          }
        )
        .foregroundStyle(.primary)
        .buttonStyle(.plain)
        .disabled(true)
        .onTapGesture {
          // TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/330
          // - Open "You can't reply ... yet" bottom sheet when tapping disabled reply buttons in the Communities Explore tab.
          NotificationCenter.default.post(name: .didConductForbittenReply, object: nil)
        }
      }

      Button(
        action: {
          postToRepost = postModel
          reposting.toggle()
        },
        label: {
          Image(systemName: "arrow.rectanglepath")
        }
      )
      .foregroundStyle(isRepostedByCurrentUser ? Color.green : .primary)
      .buttonStyle(.plain)

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
          PostShareBottomSheet(showShareSheet: $pendingShowShareSheet)
            .presentationDetents([.height(LayoutConstant.initialBottomSheetHeight)])
        })
    }
  }
}

func createFakePostCellView(canReply: Bool = false) -> PostCellView {
  return PostCellView(
    showReplyEditSheet: .constant(false),
    reposting: .constant(false),
    postToRepost: .constant(nil),
    showShareSheet: .constant(false),
    urlStrToOpen: .constant(""),
    postModel: createFakePostModel(),
    canReply: canReply
  )
}

#Preview {
  VStack(spacing: 0) {
    createFakePostCellView(canReply: true)
    createFakePostCellView()
  }
}
