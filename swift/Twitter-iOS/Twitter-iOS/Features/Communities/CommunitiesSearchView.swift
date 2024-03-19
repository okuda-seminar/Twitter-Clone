//
//  CommunitiesSearchView.swift
//  Twitter-iOS
//

import SwiftUI

struct CommunitiesSearchView: View {
  @Environment(\.presentationMode) var presentationMode

  private enum LayoutConstant {
    static let horizontalPadding = 18.0
    static let maxNumOfCommunitiesToShow = 30
  }

  private let fakeCommunities: [CommunityModel] = {
    var comminities: [CommunityModel] = []
    for _ in 0..<LayoutConstant.maxNumOfCommunitiesToShow {
      comminities.append(createFakeCommunityModel())
    }
    return comminities
  }()

  var body: some View {
    ScrollView {
      VStack {
        HStack {
          Button(action: {
            presentationMode.wrappedValue.dismiss()
          }) {
            Image(systemName: "arrow.backward")
              .foregroundStyle(.foreground)
          }
          Spacer()
          HStack {
            Image(systemName: "magnifyingglass")
            Text("Search for a Community")
          }
          Spacer()
        }
        Spacer()
        HStack {
          Text("Discover Communities")
            .font(.headline)
          Spacer()
        }
        ForEach(fakeCommunities) { community in
          HStack {
            CommunityCellView(community: community)
            Spacer()
          }
        }
      }
      .padding(EdgeInsets(top: 0, leading: LayoutConstant.horizontalPadding, bottom: 0, trailing: LayoutConstant.horizontalPadding))
      .navigationBarBackButtonHidden()
    }
  }
}

#Preview {
  CommunitiesSearchView()
}
