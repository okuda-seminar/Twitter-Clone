import SwiftUI

struct PostCellView: View {

  private enum LocalizedString {
    static let unfollowButtonText = String(localized: "Unfollow")
    static let listButtonText = String(localized: "Add/remove from Lists")
    static let muteButtonText = String(localized: "Mute")
    static let blockButtonText = String(localized: "Block")
    static let reportButtonText = String(localized: "Report post")
  }

  @Binding public var showReplyEditSheet: Bool
  @Binding public var reposting: Bool
  @Binding public var postToRepost: PostModel?
  @Binding public var showShareSheet: Bool
  @Binding public var urlStrToOpen: String

  @State public var isBookmarkedByCurrentUser: Bool = false
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
            PostCellMenu()
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
      ReplyButton()
      RepostButton()

      Spacer()

      BookmarkButton()
      ShareButton()
    }
  }

  @ViewBuilder
  private func ReplyButton() -> some View {
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
  }

  @ViewBuilder
  private func RepostButton() -> some View {
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
  }

  @ViewBuilder
  private func BookmarkButton() -> some View {
    if isBookmarkedByCurrentUser {
      Button(
        action: {
          print("Need to trigger bookmark.")
        },
        label: {
          Image(systemName: "bookmark.fill")
        }
      )
      .foregroundStyle(Color(uiColor: .brandedBlue))
      .buttonStyle(.plain)
    } else {
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
    }
  }

  @ViewBuilder
  private func ShareButton() -> some View {
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

  @ViewBuilder
  private func PostCellMenu() -> some View {
    Menu {
      // TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/383
      // - Implement Appropriate Functionality for Each Menu Item in PostCellView.swift.
      Button(
        action: {

        },
        label: {
          HStack {
            Text(LocalizedString.unfollowButtonText + " @" + postModel.userName)
            
            Image(systemName: "person.fill.xmark")
          }
        }
      )
      .foregroundStyle(.primary)
      .buttonStyle(.plain)

      Button(
        action: {

        },
        label: {
          HStack {
            Text(LocalizedString.listButtonText)

            Image(systemName: "note.text.badge.plus")
          }
        }
      )
      .foregroundStyle(.primary)
      .buttonStyle(.plain)

      Button(
        action: {

        },
        label: {
          HStack {
            Text(LocalizedString.muteButtonText + " @" + postModel.userName)

            Image(systemName: "speaker.slash")
          }
        }
      )
      .foregroundStyle(.primary)
      .buttonStyle(.plain)

      Button(
        action: {

        },
        label: {
          HStack {
            Text(LocalizedString.blockButtonText + " @" + postModel.userName)

            Image(systemName: "circle.slash")
          }
        }
      )
      .foregroundStyle(.primary)
      .buttonStyle(.plain)

      Button(
        action: {

        },
        label: {
          HStack {
            Text(LocalizedString.reportButtonText)
            Image(systemName: "flag")
          }
        }
      )
      .foregroundStyle(.primary)
      .buttonStyle(.plain)

    } label: {
      Image(systemName: "ellipsis")
        .foregroundStyle(Color(.black))
    }
  }
}

func createFakePostCellView(isBookmarkedByCurrentUser: Bool = false, canReply: Bool = false)
  -> PostCellView
{
  return PostCellView(
    showReplyEditSheet: .constant(false),
    reposting: .constant(false),
    postToRepost: .constant(nil),
    showShareSheet: .constant(false),
    urlStrToOpen: .constant(""),
    isBookmarkedByCurrentUser: isBookmarkedByCurrentUser,
    postModel: createFakePostModel(),
    canReply: canReply
  )
}

#Preview {
  VStack(spacing: 0) {
    createFakePostCellView(
      canReply: true
    )
    createFakePostCellView(isBookmarkedByCurrentUser: true)
  }
}
