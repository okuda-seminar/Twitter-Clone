//
//  SearchTabView.swift
//  Twitter-iOS
//
//  Created by 奥田遼 on 2024/03/16.
//

import SwiftUI

struct SearchTabView: View {
  // TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/26 - Fetch tweet data from backend.
  private let fakeTopics: [Topic] = {
    var topics: [Topic] = []
    for _ in 0..<30 {
      topics.append(createFakeTopic())
    }
    return topics
  }()

  var body: some View {
    ScrollView {
      VStack {
        ForEach(fakeTopics) { topic in
          SearchTopicCellView(topic: topic)
        }
      }
    }
  }
}

#Preview {
  SearchTabView()
}
