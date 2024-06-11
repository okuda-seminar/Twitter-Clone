import SwiftUI

struct HomeTabView: View {
  @Binding public var showReplyEditSheet: Bool
  @Binding public var showShareSheet: Bool

  @State private var postModels: [PostModel] = {
    var models: [PostModel] = []
    for _ in 0..<20 {
      models.append(createFakePostModel())
    }
    return models
  }()

  @State private var isMuteAlertPresented = false

  private let userName = "@mockUserName"

  private enum LocalizedString {
    static let alertDismissalText = String(localized: "Cancel")
    static let alertAcceptanceText = String(localized: "Yes, I'm sure")

    static let unfollow = String(localized: "Unfollow")
    static let addOrRemoveFromLists = String(localized: "Add/remove from Lists")
    static let block = String(localized: "Block")

    static let mute = String(localized: "Mute")
    static let muteAlertTitle = String(localized: "Mute %@")
    static let muteAlertMessage = String(
      localized: """
            You won't see posts from %@ or get notifications about them. They won't know
            they've been muted.
        """)
    static let muteBannerTitle = String(localized: "%@ has benn muted.")

    static let reportPost = String(localized: "Report post")
  }

  var body: some View {
    ScrollView(.vertical) {
      LazyVStack(spacing: 0) {
        ForEach(postModels) { postModel in
          PostCellView(
            showReplyEditSheet: $showReplyEditSheet,
            showShareSheet: $showShareSheet,
            userIcon: postModel.userIcon, userName: postModel.userName,
            postBody: postModel.bodyText
          )
          .contextMenu(
            ContextMenu(menuItems: {
              Button(
                action: {
                },
                label: {
                  Text(LocalizedString.unfollow)
                  Image(systemName: "person.fill.xmark")
                })
              Button(
                action: {

                },
                label: {
                  Text(LocalizedString.addOrRemoveFromLists)
                  Image(systemName: "list.clipboard")
                })
              Button(
                action: {
                  isMuteAlertPresented.toggle()
                },
                label: {
                  Text(LocalizedString.mute)
                  Image(systemName: "speaker.slash")
                })
              Button(
                action: {

                },
                label: {
                  Text(LocalizedString.block)
                  Image(systemName: "xmark.circle")
                })
              Button(
                action: {

                },
                label: {
                  Text(LocalizedString.reportPost)
                  Image(systemName: "flag")
                })
            }))
        }
      }
      .alert(
        String(format: LocalizedString.muteAlertTitle, userName), isPresented: $isMuteAlertPresented
      ) {
        Button(
          role: .cancel, action: {},
          label: {
            Text(String(format: LocalizedString.alertDismissalText))
          })

        Button(
          role: .destructive,
          action: {
            UserService.sharedInstance.muteUser(userName) { success in
              if success {
                let bannerController = BannerController(
                  message: String(format: LocalizedString.muteBannerTitle, userName))
                bannerController.show(on: MainRootViewController.sharedInstance)
              }
            }
          },
          label: {
            Text(String(format: LocalizedString.alertAcceptanceText))
          })
      } message: {
        Text(String(format: LocalizedString.muteAlertMessage, userName))
      }
    }
  }
}

#Preview {
  HomeTabView(showReplyEditSheet: .constant(false), showShareSheet: .constant(false))
}
