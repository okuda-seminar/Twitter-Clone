import SwiftUI
import UIKit

class UserProfileViewController: UIViewController {

  public var userName: String = ""
  public var profileIcon: UIImage? {
    didSet {
      profileIconView.image = profileIcon
    }
  }

  public let profileIconView: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.contentMode = .scaleAspectFit
    imageView.isUserInteractionEnabled = true
    return imageView
  }()

  private enum LayoutConstant {
    static let edgeHorizontalPadding = 16.0

    static let backButtonTopPadding = 24.0
    static let backButtonSize = 28.0

    static let profileIconViewTopPadding = 8.0
    static let profileIconViewSize = 48.0
  }

  private let userNameLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.tintColor = .black
    return label
  }()

  private let backButton: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setImage(UIImage(systemName: "arrow.left"), for: .normal)
    button.contentMode = .scaleAspectFit
    button.tintColor = .white
    button.backgroundColor = .gray
    button.layer.cornerRadius = LayoutConstant.backButtonSize / 2
    return button
  }()

  private lazy var tabViewHostingController: UIHostingController = {
    let controller = UIHostingController(rootView: UserProfileTabView())
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
    view.addSubview(backButton)
    view.addSubview(profileIconView)
    view.addSubview(tabViewHostingController.view)

    backButton.addAction(
      .init { _ in
        self.navigationController?.delegate = nil
        self.navigationController?.popViewController(animated: true)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
      }, for: .touchUpInside)

    let tapGestureRecognizer = UITapGestureRecognizer(
      target: self, action: #selector(presentUserProfileIconDetailViewController))
    profileIconView.addGestureRecognizer(tapGestureRecognizer)

    let layoutGuide = view.safeAreaLayoutGuide
    NSLayoutConstraint.activate([
      backButton.topAnchor.constraint(
        equalTo: layoutGuide.topAnchor, constant: LayoutConstant.backButtonTopPadding),
      backButton.leadingAnchor.constraint(
        equalTo: layoutGuide.leadingAnchor, constant: LayoutConstant.edgeHorizontalPadding),
      backButton.widthAnchor.constraint(equalToConstant: LayoutConstant.backButtonSize),
      backButton.heightAnchor.constraint(equalToConstant: LayoutConstant.backButtonSize),

      profileIconView.leadingAnchor.constraint(equalTo: backButton.leadingAnchor),
      profileIconView.topAnchor.constraint(
        equalTo: backButton.bottomAnchor, constant: LayoutConstant.profileIconViewTopPadding),
      profileIconView.widthAnchor.constraint(equalToConstant: LayoutConstant.profileIconViewSize),
      profileIconView.heightAnchor.constraint(equalToConstant: LayoutConstant.profileIconViewSize),

      tabViewHostingController.view.topAnchor.constraint(equalTo: layoutGuide.centerYAnchor),
      tabViewHostingController.view.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor),
      tabViewHostingController.view.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor),
    ])

    // Hide navigation bar
    navigationController?.setNavigationBarHidden(true, animated: false)
  }

  @objc
  private func presentUserProfileIconDetailViewController() {
    let userProfileIconDetailViewController = UserProfileIconDetailViewController()
    userProfileIconDetailViewController.modalPresentationStyle = .fullScreen
    userProfileIconDetailViewController.profileIcon = profileIcon
    navigationController?.delegate = self
    navigationController?.pushViewController(
      userProfileIconDetailViewController, animated: true)
  }
}

extension UserProfileViewController: UINavigationControllerDelegate {
  func navigationController(
    _ navigationController: UINavigationController,
    animationControllerFor operation: UINavigationController.Operation,
    from fromVC: UIViewController, to toVC: UIViewController
  ) -> UIViewControllerAnimatedTransitioning? {
    switch operation {
    case .push:
      let animator = UserProfileIconTransition()
      animator.presenting = true
      return animator
    case .pop:
      return nil
    default:
      return nil
    }
  }
}

/// Currently only tab bar is implemented. but tab views will be added.
struct UserProfileTabView: View {
  @State private var tabs: [UserProfileTabModel] = [
    .init(id: .posts),
    .init(id: .replies),
    .init(id: .highlights),
    .init(id: .media),
    .init(id: .likes),
  ]
  @State private var activeTab: UserProfileTabModel.Tab = .posts
  @State private var tabToScroll: UserProfileTabModel.Tab?

  var body: some View {
    VStack(spacing: 0) {
      TabBar()
      Tabs()
    }
  }

  @ViewBuilder
  private func TabBar() -> some View {
    // Need to make spacing compatible with iPad.
    HStack {
      ForEach(tabs) { tab in
        Spacer()
        Button(
          action: {
            withAnimation(.snappy) {
              activeTab = tab.id
              tabToScroll = tab.id
            }
          },
          label: {
            // Need to associate tab id with localized strings and use them here.
            Text(tab.id.rawValue)
              .foregroundStyle(activeTab == tab.id ? Color.primary : .gray)
          })
        Spacer()
      }
    }
    .overlay(alignment: .bottom) {
      ZStack(alignment: .leading) {
        Rectangle()
          .fill(.gray.opacity(0.3))
          .frame(height: 1)
      }
    }
  }

  @ViewBuilder
  private func Tabs() -> some View {
    ScrollView(.horizontal) {
      LazyHStack(spacing: 0) {
        ForEach(tabs) { tab in
          Text("dummy tab")
            .frame(width: UIScreen.main.bounds.width, height: 100, alignment: .center)
        }
      }
      .scrollTargetLayout()
    }
    .scrollIndicators(.hidden)
    .scrollTargetBehavior(.paging)
    .scrollPosition(id: $tabToScroll)
    .onChange(of: tabToScroll) { _, newValue in
      if let newValue {
        withAnimation {
          tabToScroll = newValue
          activeTab = newValue
        }
      }
    }
  }
}

#Preview {
  UserProfileTabView()
}
