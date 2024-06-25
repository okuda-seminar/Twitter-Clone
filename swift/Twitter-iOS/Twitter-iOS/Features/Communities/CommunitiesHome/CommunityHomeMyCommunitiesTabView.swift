import SwiftUI

struct CommunityHomeMyCommunitiesTabView: View {

  @Binding public var showMoreCommunities: Bool

  private enum LayoutConstant {
    static let edgePadding = 16.0
  }

  private enum LocalizedString {
    static let headlineLabelText = String(localized: "Discover new Communities")
    static let seeLessOften = String(localized: "See less often")
    static let showMoreText = String(localized: "Show more")
  }

  private let communities: [CommunityModel] = {
    var communities: [CommunityModel] = []
    for _ in 0..<4 {
      communities.append(createFakeCommunityModel())
    }
    return communities
  }()

  var body: some View {
    VStack {
      HStack {
        Text(LocalizedString.headlineLabelText)
        Spacer()
        Menu {
          Button(
            action: {
            },
            label: {
              Label(LocalizedString.seeLessOften, systemImage: "face.dashed")
            })
        } label: {
          Image(systemName: "ellipsis")
        }
        .foregroundStyle(Color(uiColor: .brandedLightGrayText))
      }

      ForEach(communities) { community in
        CommunityCellView(community: community)
      }

      HStack {
        Button(
          action: {
            showMoreCommunities = true
          },
          label: {
            Text(LocalizedString.showMoreText)
          }
        )
        .buttonStyle(.plain)
        .foregroundStyle(Color(uiColor: .brandedBlue))
        Spacer()
      }

      Spacer()
    }
    .padding(.top, LayoutConstant.edgePadding)
    .padding(.leading, LayoutConstant.edgePadding)
    .padding(.trailing, LayoutConstant.edgePadding)
  }
}

#Preview {
  CommunityHomeMyCommunitiesTabView(showMoreCommunities: .constant(false))
}
