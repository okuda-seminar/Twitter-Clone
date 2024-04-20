//
//  CommunityCellView.swift
//  Twitter-iOS
//
//  Created by 奥田遼 on 2024/03/17.
//

import SwiftUI

struct CommunityCellView: View {
  private enum LayoutConstant {
    static let communityIconSize = 56.0
    static let maxNumOfTopIconsToShow = 5
  }
  var community: CommunityModel

  var body: some View {
    // TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/34 - Polish CommunityCellView UI.
    HStack(alignment: .center) {
      community.image
        .resizable()
        .scaledToFit()
        .frame(width: LayoutConstant.communityIconSize, height: LayoutConstant.communityIconSize)
      VStack(alignment: .leading) {
        Text(community.name)
        Text("\(community.roughNumOfMembers) members")
        Text(community.topic)
        HStack {
          ForEach(
            0..<min(LayoutConstant.maxNumOfTopIconsToShow, community.topIcons.count), id: \.self
          ) { iconIndex in
            community.topIcons[iconIndex]
          }
        }
      }
    }
  }
}

#Preview{
  CommunityCellView(community: createFakeCommunityModel())
}
