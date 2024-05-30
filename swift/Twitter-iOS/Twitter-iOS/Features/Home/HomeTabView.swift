import SwiftUI

struct HomeTabView: View {
  @State private var tweetModels: [TweetModel] = {
    var models: [TweetModel] = []
    for _ in 0..<20 {
      models.append(createFakeTweetModel())
    }
    return models
  }()

  private enum LocalizedLongTapActionString {
    static let unfollow = String(localized: "Unfollow")
    static let addOrRemoveFromLists = String(localized: "Add/remove from Lists")
    static let block = String(localized: "Block")
    static let mute = String(localized: "Mute")
    static let reportPost = String(localized: "Report post")
  }

  var body: some View {
    ScrollView(.vertical) {
      LazyVStack(spacing: 0) {
        ForEach(tweetModels) { tweetModel in
          TweetCellView(
            userIcon: tweetModel.userIcon, userName: tweetModel.userName,
            tweetBody: tweetModel.bodyText
          )
          .contextMenu(
            ContextMenu(menuItems: {
              Button(
                action: {
                  let userName = "@mockUserName"
                  UserService.sharedInstance.unfollowUser(userName) { success in
                    if success {
                      let bannerController = BannerController(
                        message: "\(userName) has been unfollowed")
                      bannerController.show(on: MainRootViewController.sharedInstance)
                    }
                  }
                },
                label: {
                  Text(LocalizedLongTapActionString.unfollow)
                  Image(systemName: "person.fill.xmark")
                })
              Button(
                action: {

                },
                label: {
                  Text(LocalizedLongTapActionString.addOrRemoveFromLists)
                  Image(systemName: "list.clipboard")
                })
              Button(
                action: {

                },
                label: {
                  Text(LocalizedLongTapActionString.mute)
                  Image(systemName: "speaker.slash")
                })
              Button(
                action: {

                },
                label: {
                  Text(LocalizedLongTapActionString.block)
                  Image(systemName: "xmark.circle")
                })
              Button(
                action: {

                },
                label: {
                  Text(LocalizedLongTapActionString.reportPost)
                  Image(systemName: "flag")
                })
            }))
        }
      }
    }
  }
}

#Preview {
  HomeTabView()
}
