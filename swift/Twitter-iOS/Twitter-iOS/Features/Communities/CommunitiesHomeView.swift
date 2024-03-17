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
      Text("Show more")
    }
    .padding(EdgeInsets(top: 0, leading: LayoutConstant.horizontalPadding, bottom: 0, trailing: LayoutConstant.horizontalPadding))
    Spacer()
  }
}

#Preview {
  CommunitiesHomeView()
}
