//
//  CommunitiesSearchView.swift
//  Twitter-iOS
//

import SwiftUI

struct CommunitiesSearchView: View {
  @Environment(\.presentationMode) var presentationMode
  @State private var searchQuery = ""

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
          CommunitySearchBar(searchQuery: $searchQuery)
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

struct CommunitySearchBar: View {
  @Binding var searchQuery: String
  @State var editing: Bool = false

  var body: some View {
    HStack {
      Spacer()
      Image(systemName: "magnifyingglass")
        .foregroundStyle(Color.gray)
        .padding(.leading, editing ? 0 : 40)
        .animation(.default, value: editing)
      TextField(String(localized: "Search for a Community"), text: $searchQuery, onEditingChanged: { editing in
        self.editing = editing
      })
        .foregroundStyle(Color.primary)
        .animation(.default, value: editing)
      Spacer()
    }
    .background(Color(UIColor.secondarySystemBackground))
    .clipShape(Capsule())
  }
}

#Preview {
  CommunitiesSearchView()
}
