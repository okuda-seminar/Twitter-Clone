//
//  CommunitiesHomeView.swift
//  Twitter-iOS
//
//  Created by 奥田遼 on 2024/03/17.
//

import SwiftUI

struct CommunitiesHomeView: View {
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
    NavigationView {
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
        NavigationLink(destination: CommunitiesSearchView()) {
          Text("Show more")
        }
      }
      .padding(EdgeInsets(top: -350, leading: LayoutConstant.horizontalPadding, bottom: 0, trailing: LayoutConstant.horizontalPadding))
      // If we place Spacer() here, then another is added to tab bar. Probably App;e's bug.
    }
  }
}

#Preview {
  CommunitiesHomeView()
}
