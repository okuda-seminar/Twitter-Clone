import SwiftUI

struct SearchTabView: View {
  public var showGIF: Bool = false

  @State private var topicModels: [TopicModel] = {
    // TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/94
    // - Fetch Search tab data from server.
    var models: [TopicModel] = []
    for _ in 0..<30 {
      let topicModel = createFakeTopicModel()
      models.append(topicModel)
    }
    return models
  }()

  var body: some View {
    ScrollView(.vertical) {
      if showGIF {
        GIFImagePlayer(resourceName: "cute_bard")
      }
      ForEach(topicModels) { topicModel in
        SearchTopicCellView(topic: topicModel)
      }
    }
  }
}

#Preview {
  SearchTabView(showGIF: true)
}
