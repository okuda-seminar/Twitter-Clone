//
//  CommunitiesHomeView.swift
//  Twitter-iOS
//

import SwiftUI

struct CommunitiesHomeView: View {
  @Binding var enableSideMenu: Bool

  private enum LayoutConstant {
    static let horizontalPadding = 18.0
    static let maxNumOfCommunitiesToShow = 3
  }

  private let fakeCommunities: [CommunityModel] = {
    var comminities: [CommunityModel] = []
    for _ in 0..<LayoutConstant.maxNumOfCommunitiesToShow {
      comminities.append(createFakeCommunityModel())
    }
    return comminities
  }()

  var body: some View {
    NavigationStack {
      VStack(alignment: .leading) {
        HStack {
          Text("Discover new Communities")
            .font(.headline)
          Spacer()
          Image(systemName: "ellipsis")
        }
        ForEach(fakeCommunities) { community in
          CommunityCellView(community: community)
        }
        NavigationLink(
          destination:
            CommunitiesSearchView()
            .onAppear {
              enableSideMenu = false
            }
            .onDisappear {
              enableSideMenu = true
            }
        ) {
          Text("Show more")
        }
        .navigationBarTitle("")

      }
      .padding(
        EdgeInsets(
          top: -350, leading: LayoutConstant.horizontalPadding, bottom: 0,
          trailing: LayoutConstant.horizontalPadding)
      )
      .onAppear {
        enableSideMenu = true
      }
      // If we place Spacer() here, then another is added to tab bar. Probably App;e's bug.
    }
  }
}

#Preview {
  CommunitiesHomeView(enableSideMenu: .constant(true))
}
