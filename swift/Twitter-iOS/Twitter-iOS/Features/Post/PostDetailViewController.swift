import SwiftUI
import UIKit

class PostDetailViewController: UIViewController {
  public var postModel: PostModel

  public init(postModel: PostModel) {
    self.postModel = postModel
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private enum LayoutConstant {
    static let title = String(localized: "Post")
  }

  private lazy var hostingController: UIHostingController = {
    let controller = UIHostingController(rootView: PostDetailView(postModel: postModel))
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
    view.backgroundColor = .systemBackground
    view.addSubview(hostingController.view)
    navigationItem.title = LayoutConstant.title

    let layoutGuide = view.safeAreaLayoutGuide
    NSLayoutConstraint.activate([
      hostingController.view.topAnchor.constraint(equalTo: layoutGuide.topAnchor),
      hostingController.view.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor),
      hostingController.view.bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor),
      hostingController.view.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor),
    ])
  }
}

struct PostDetailView: View {
  var postModel: PostModel

  private enum LayoutConstant {
    static let userIconSize: CGFloat = 28.0
  }

  private enum LocalizedString {
    static let translationSuggestionText = String(localized: "Translate post")
  }

  var body: some View {
    VStack(alignment: .leading) {
      HStack {
        postModel.userIcon
          .resizable()
          .scaledToFit()
          .frame(width: LayoutConstant.userIconSize, height: LayoutConstant.userIconSize)
        Text(postModel.userName)
        Spacer()
        Button(
          action: {

          },
          label: {
            Image(systemName: "ellipsis")
          }
        )
        .foregroundStyle(.primary)
        .buttonStyle(.plain)
      }
      Text(postModel.bodyText)
        .padding(.bottom)

      Button(
        action: {
        },
        label: {
          Text(LocalizedString.translationSuggestionText)
        }
      )
      .foregroundStyle(Color(uiColor: .brandedBlue))
      .buttonStyle(.plain)

      Spacer()
    }
    .padding()
  }
}

#Preview {
  PostDetailView(postModel: createFakePostModel())
}
