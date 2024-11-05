import SwiftUI

struct PostCellView: View {

  // MARK: - Public Props

  @Binding public var showReplyEditSheet: Bool
  @Binding public var reposting: Bool
  @Binding public var postToRepost: PostModel?
  @Binding public var showShareSheet: Bool
  @Binding public var urlStrToOpen: String

  @State public var isBookmarkedByCurrentUser: Bool = false
  @State public var isRepostedByCurrentUser: Bool = false

  public var postModel: PostModel
  public var canReply: Bool = true

  // MARK: - Priavte Props

  @Environment(\.openURL) private var openURL
  // We need to wait for dismissal completion. pendingShowShareSheet
  // will be propageted to showShareSheet after the completion.
  @State private var pendingShowShareSheet: Bool = false
  @State private var showSheet: Bool = false

  @State private var isCannotReplyBottomSheetPresented: Bool = false
  @State private var isPostShareBottomSheetPresented: Bool = false

  private enum LayoutConstant {
    static let userIconSize: CGFloat = 32.0
    static let initialBottomSheetHeight: CGFloat = 250.0
  }

  private enum LocalizedString {
    static let unfollowButtonText = String(localized: "Unfollow")
    static let listButtonText = String(localized: "Add/remove from Lists")
    static let muteButtonText = String(localized: "Mute")
    static let blockButtonText = String(localized: "Block")
    static let reportButtonText = String(localized: "Report post")
  }

  // MARK: - View

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
        isCannotReplyBottomSheetPresented.toggle()
      }
      .sheet(
        isPresented: $isCannotReplyBottomSheetPresented,
        content: {
          CannotReplyBottomSheet(
            isCannotReplyBottomSheetPresented: $isCannotReplyBottomSheetPresented
          )
          .presentationDetents([.height(LayoutConstant.initialBottomSheetHeight)])
        })
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
        isPostShareBottomSheetPresented.toggle()
      },
      label: {
        Image(systemName: "square.and.arrow.up")
      }
    )
    .foregroundStyle(.primary)
    .buttonStyle(.plain)
    .sheet(
      isPresented: $isPostShareBottomSheetPresented,
      onDismiss: {
        Task { @MainActor in
          showShareSheet = pendingShowShareSheet
        }
      },
      content: {
        PostShareBottomSheet(
          showShareSheet: $pendingShowShareSheet,
          isPostShareBottomSheetPresented: $isPostShareBottomSheetPresented
        )
        .presentationDetents([.height(LayoutConstant.initialBottomSheetHeight)])
      })
  }

  @ViewBuilder
  private func PostCellMenu() -> some View {
    Menu {
      // TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/383
      // - Implement Appropriate Functionality for Each Menu Item in PostCellView.swift.
      UnfollowButton()
      ListButton()
      MuteButton()
      BlockButton()
      ReportButton()
    } label: {
      Image(systemName: "ellipsis")
        .foregroundStyle(Color(.black))
    }
  }

  @ViewBuilder
  private func UnfollowButton() -> some View {
    Button {

    } label: {
      HStack {
        Text(LocalizedString.unfollowButtonText + " @" + postModel.userName)
        Image(systemName: "person.fill.xmark")
      }
    }
    .foregroundStyle(.primary)
    .buttonStyle(.plain)
  }

  @ViewBuilder
  private func ListButton() -> some View {
    Button {

    } label: {
      HStack {
        Text(LocalizedString.listButtonText)
        Image(systemName: "note.text.badge.plus")
      }
    }
    .foregroundStyle(.primary)
    .buttonStyle(.plain)
  }

  @ViewBuilder
  private func MuteButton() -> some View {
    Button {

    } label: {
      HStack {
        Text(LocalizedString.muteButtonText + " @" + postModel.userName)
        Image(systemName: "speaker.slash")
      }
    }
    .foregroundStyle(.primary)
    .buttonStyle(.plain)
  }

  @ViewBuilder
  private func BlockButton() -> some View {
    Button {

    } label: {
      HStack {
        Text(LocalizedString.blockButtonText + " @" + postModel.userName)
        Image(systemName: "circle.slash")
      }
    }
    .foregroundStyle(.primary)
    .buttonStyle(.plain)
  }

  @ViewBuilder
  private func ReportButton() -> some View {
    Button {

    } label: {
      HStack {
        Text(LocalizedString.reportButtonText)
        Image(systemName: "flag")
      }
    }
    .foregroundStyle(.primary)
    .buttonStyle(.plain)
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
