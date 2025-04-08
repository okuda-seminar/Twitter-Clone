import SwiftUI

struct CommunityCellView: View {

  var community: CommunityModel

  var body: some View {
    // TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/34 - Polish CommunityCellView UI.
    HStack(alignment: .center) {
      community.image
        .resizable()
        .scaledToFit()
        .frame(width: 56, height: 56)
      VStack(alignment: .leading) {
        Text(community.name)
        Text("\(community.roughNumOfMembers) members")
        Text(community.topic)
        HStack {
          ForEach(
            0..<min(5, community.topIcons.count), id: \.self
          ) { iconIndex in
            community.topIcons[iconIndex]
          }
        }
      }
      Spacer()
    }
    .padding()
  }
}

#Preview {
  CommunityCellView(community: createFakeCommunityModel())
}
