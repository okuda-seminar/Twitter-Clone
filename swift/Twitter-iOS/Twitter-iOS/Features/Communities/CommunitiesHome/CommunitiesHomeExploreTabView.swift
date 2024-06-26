import SwiftUI

struct CommunitiesHomeExploreTabView: View {

  private var communityFilterModels: [CommunityFilterModel] {
    var communityFilters = [CommunityFilterModel]()
    for _ in 0..<10 {
      communityFilters.append(createFakeCommunityFilterModel())
    }
    return communityFilters
  }

  private var filteredPosts: [PostModel] {
    var posts = [PostModel]()
    for _ in 0..<30 {
      posts.append(createFakePostModel())
    }
    return posts
  }

  var body: some View {
    ScrollView(.vertical) {
      VStack {
        FilterTabBar()
        FilteredPostsStack()
      }
    }
  }

  @ViewBuilder
  private func FilterTabBar() -> some View {
    ScrollView(.horizontal, showsIndicators: false) {
      HStack {
        ForEach(communityFilterModels) { communityFilter in
          Button(
            action: {
            },
            label: {
              Text(communityFilter.name)
                .underline()
                .padding(EdgeInsets(top: 8, leading: 12, bottom: 8, trailing: 12))
            }
          )
          .buttonStyle(.plain)
          .foregroundStyle(.primary)
          .overlay(
            RoundedRectangle(cornerRadius: 24)
              .stroke(Color(uiColor: .brandedLightGrayBackground), lineWidth: 2)
          )
        }
      }
    }
  }

  @ViewBuilder
  private func FilteredPostsStack() -> some View {
    VStack(spacing: 0) {
      ForEach(filteredPosts) { postModel in
        PostCellView(
          showReplyEditSheet: .constant(false),
          reposting: .constant(false),
          postToRepost: .constant(nil),
          showShareSheet: .constant(false),
          urlStrToOpen: .constant(""),
          postModel: postModel,
          canReply: false
        )
      }
    }
  }
}

#Preview {
  CommunitiesHomeExploreTabView()
}
