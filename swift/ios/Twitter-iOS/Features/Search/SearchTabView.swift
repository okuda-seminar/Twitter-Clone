//
//  SearchTabView.swift
//  Twitter-iOS
//
//  Created by 奥田遼 on 2024/03/16.
//

import SwiftUI

struct SearchTabView: View {
  private let fakeTopics: [TopicModel] = {
    var topics: [TopicModel] = []
    for _ in 0..<30 {
      topics.append(createFakeTopicModel())
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

#Preview{
  SearchTabView()
}
