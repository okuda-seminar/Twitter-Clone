//
//  SearchCellView.swift
//  Twitter-iOS
//

import SwiftUI

struct SearchTopicCellView: View {

  private enum LayoutConstant {
    static let cellHorizontalPadding = 18.0
  }

  var topic: TopicModel

  var body: some View {
    VStack(alignment: .leading) {
      HStack {
        Text("Trending in \(topic.category)")
          .foregroundStyle(.secondary)
        Spacer()
        Image(systemName: "ellipsis")
          .foregroundStyle(.secondary)
      }
      Text(topic.name)
        .foregroundStyle(.primary)
      Text("\(topic.numOfPosts) posts")
        .foregroundStyle(.secondary)
    }
    .padding(
      EdgeInsets(
        top: 0, leading: LayoutConstant.cellHorizontalPadding, bottom: 0,
        trailing: LayoutConstant.cellHorizontalPadding))
    Divider()
  }
}

#Preview {
  SearchTopicCellView(topic: createFakeTopicModel())
}
