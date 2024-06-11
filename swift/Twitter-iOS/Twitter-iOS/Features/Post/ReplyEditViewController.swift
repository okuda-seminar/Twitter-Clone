import SwiftUI
import UIKit

class ReplyEditViewController: UIViewController {
  private lazy var hostingController: UIHostingController = {
    let controller = UIHostingController(
      rootView: ReplyEditView(originalPostModel: createFakePostModel()))
    controller.view.translatesAutoresizingMaskIntoConstraints = false
    addChild(controller)
    controller.didMove(toParent: self)
    return controller
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    setUpSubviews()
  }

  private func setUpSubviews() {
    view.addSubview(hostingController.view)
    view.backgroundColor = .systemBackground

    let layoutGuide = view.safeAreaLayoutGuide
    NSLayoutConstraint.activate([
      hostingController.view.topAnchor.constraint(equalTo: layoutGuide.topAnchor),
      hostingController.view.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor),
      hostingController.view.bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor),
      hostingController.view.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor),
    ])
  }
}

struct ReplyEditView: View {
  public var originalPostModel: PostModel

  private enum LayoutConstant {
    static let iconSize: CGFloat = 48.0
  }

  private enum LocalizedString {
    static let dismissalButtonText = String(localized: "Cancel")
    static let postButtonText = String(localized: "Post")
    static let inputPlaceholder = String(localized: "Post your reply")
  }

  @Environment(\.dismiss) private var dismiss
  @State private var inputText = ""
  private let currentUser = injectCurrentUser()

  var body: some View {
    VStack {
      Header()
      Divider()
      Content()
    }
    .padding()
  }

  @ViewBuilder
  private func Header() -> some View {
    HStack {
      Button(
        action: {
          dismiss()
        },
        label: {
          Text(LocalizedString.dismissalButtonText)
            .underline()
        }
      )
      .foregroundStyle(.primary)

      Spacer()

      Button(
        action: {
        },
        label: {
          Text(LocalizedString.postButtonText)
            .underline()
            .padding(EdgeInsets(top: 8, leading: 24, bottom: 8, trailing: 24))
            .foregroundStyle(Color.white)
            .background(Color(uiColor: .brandedBlue))
            .clipShape(Capsule())
        })
    }
  }

  @ViewBuilder
  private func Content() -> some View {
    ScrollView(.vertical) {
      VStack {
        HStack(alignment: .top) {
          LeftSideContent()
          MainContent()
          Spacer()
        }
      }
    }
  }

  @ViewBuilder
  private func LeftSideContent() -> some View {
    VStack {
      originalPostModel.userIcon
        .resizable()
        .scaledToFit()
        .frame(width: LayoutConstant.iconSize, height: LayoutConstant.iconSize)

      HStack {
        // Need to place dummy Text to draw vertical Divider.
        Text("")
        Divider()
          .background(.gray)
        Text("")
      }
      // Change height dynamically later.
      .frame(height: 100)

      Image(uiImage: currentUser.icon)
        .resizable()
        .scaledToFit()
        .frame(width: LayoutConstant.iconSize, height: LayoutConstant.iconSize)
    }
  }

  @ViewBuilder
  private func MainContent() -> some View {
    VStack(alignment: .leading) {
      HStack {
        Text(originalPostModel.userName)
      }
      Text(originalPostModel.bodyText)

      TextEditor(text: $inputText)
        .overlay(alignment: .topLeading) {
          if inputText.isEmpty {
            Text(LocalizedString.inputPlaceholder)
              .allowsHitTesting(false)
              .foregroundStyle(Color(uiColor: .brandedLightGrayText))
              .padding(8)
          }
        }
    }
  }
}

#Preview {
  ReplyEditView(originalPostModel: createFakePostModel())
}
