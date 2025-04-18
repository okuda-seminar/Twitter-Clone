import SwiftUI

struct RepostOptionsBottomSheet: View {

  @Binding public var postModel: PostModel?

  @Environment(\.dismiss) private var dismiss

  private enum LocalizedString {
    static let repost = String(localized: "Repost")
    static let quote = String(localized: "Quote")
    static let dismissalButtonText = String(localized: "Cancel")
  }

  var body: some View {
    VStack(alignment: .leading) {
      Button(
        action: {
          repost(of: postModel)
        },
        label: {
          HStack {
            Image(systemName: "arrow.rectanglepath")
            Text(LocalizedString.repost)
          }
          .padding(EdgeInsets(top: 6, leading: 0, bottom: 6, trailing: 0))
        }
      )
      .buttonStyle(.plain)

      Button(
        action: {

        },
        label: {
          HStack {
            Image(systemName: "pencil.line")
            Text(LocalizedString.quote)
          }
          .padding(EdgeInsets(top: 6, leading: 0, bottom: 32, trailing: 0))
        }
      )
      .buttonStyle(.plain)

      Button(
        action: {
          dismiss()
        },
        label: {
          HStack {
            Spacer()
            Text(LocalizedString.dismissalButtonText)
              .underline()
            Spacer()
          }
          .padding()
        }
      )
      .buttonStyle(.plain)
      .overlay(
        RoundedRectangle(cornerRadius: 24)
          .stroke(Color(uiColor: .brandedLightGrayBackground), lineWidth: 2)
      )
    }
    .padding()
  }

  // MARK: - Action Handler

  /// Create a repost and dismiss the sheet.
  private func repost(of post: PostModel?) {
    guard let postModel else {
      dismiss()
      return
    }
    Task { @MainActor in
      let postService = injectPostService()
      await postService.repost(of: postModel)
      dismiss()
    }
  }
}

#Preview {
  RepostOptionsBottomSheet(
    postModel: .constant(createFakePostModel())
  )
}
