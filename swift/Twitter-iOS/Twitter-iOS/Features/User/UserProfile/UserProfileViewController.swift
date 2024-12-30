import SwiftUI
import UIKit

class UserProfileViewController: UIViewController {

  // MARK: Public Props

  public var userModel: UserModel? {
    didSet {
      guard let userModel else { return }
      profileIconView.image = userModel.icon
    }
  }

  public let profileIconView: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.contentMode = .scaleAspectFit
    imageView.isUserInteractionEnabled = true
    return imageView
  }()

  // MARK: Private Props

  private enum LayoutConstant {
    static let edgeHorizontalPadding = 16.0

    static let backButtonTopPadding = 24.0
    static let backButtonSize = 28.0

    static let profileIconViewTopPadding = 8.0
    static let profileIconViewSize = 48.0
  }

  private var viewObserver = UserProfileViewObserver()

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

  private lazy var hostingController: UIHostingController = {
    let controller = UIHostingController(rootView: UserProfileView(viewObserver: viewObserver))
    controller.view.translatesAutoresizingMaskIntoConstraints = false
    addChild(controller)
    controller.didMove(toParent: self)
    return controller
  }()

  private var timeWhenViewWillAppear = Date()
  private var timeWhenViewIsAppearing = Date()
  private var timeWhenViewDidAppear = Date()

  // MARK: - Public API

  public init(userModel: UserModel? = nil) {
    self.userModel = userModel
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Overridden API

  override func viewDidLoad() {
    super.viewDidLoad()
    setUpSubviews()
    setUpViewObserver()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    timeWhenViewWillAppear = Date()
    print("\(className) viewWillAppear: 0s")
  }

  override func viewIsAppearing(_ animated: Bool) {
    super.viewIsAppearing(animated)
    timeWhenViewIsAppearing = Date()
    print(
      "\(className) viewIsAppearing: \(timeWhenViewIsAppearing.timeIntervalSince(timeWhenViewWillAppear))s"
    )
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    timeWhenViewDidAppear = Date()
    print(
      "\(className) viewDidAppear: \(timeWhenViewDidAppear.timeIntervalSince(timeWhenViewWillAppear))"
    )
  }

  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    print("\(className) viewWillDisappear")
  }

  override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
    print("\(className) viewDidDisappear")
  }

  // MARK: Private API

  private func setUpSubviews() {
    view.backgroundColor = .systemBackground
    view.addSubview(hostingController.view)

    let layoutGuide = view.safeAreaLayoutGuide
    NSLayoutConstraint.activate([
      hostingController.view.topAnchor.constraint(equalTo: view.topAnchor),
      hostingController.view.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor),
      hostingController.view.bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor),
      hostingController.view.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor),
    ])

    // Hide navigation bar
    navigationController?.setNavigationBarHidden(true, animated: false)
  }

  private func setUpViewObserver() {
    viewObserver.didTapBackButtonCompletion = { [weak self] in
      self?.navigationController?.popViewController(animated: true)
    }
  }

  @objc
  private func presentUserProfileIconDetailViewController() {
    let userProfileIconDetailViewController = UserProfileIconDetailViewController(
      currentUser: injectCurrentUser())
    userProfileIconDetailViewController.modalPresentationStyle = .fullScreen
    navigationController?.delegate = self
    navigationController?.pushViewController(
      userProfileIconDetailViewController, animated: true)
  }

  private func clearNavigationControllerSettings() {
    self.navigationController?.delegate = nil
    self.navigationController?.popViewController(animated: true)
    self.navigationController?.setNavigationBarHidden(false, animated: false)
  }
}

// TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/219
// - Replace custom push transition with custom present one when tapping user icon.
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
struct UserProfileView: View {
  @ObservedObject var viewObserver: UserProfileViewObserver

  @State private var tabs: [UserProfileTabModel] = [
    .init(id: .posts),
    .init(id: .replies),
    .init(id: .highlights),
    .init(id: .media),
    .init(id: .likes),
  ]
  @State private var scrollOffset: CGFloat = 0.0
  @State private var titleOffset: CGFloat = 0.0
  @State private var activeTab: UserProfileTabModel.Tab = .posts
  @State private var tabToScroll: UserProfileTabModel.Tab?
  @State private var isUserProfileTabsViewScrollEnabled: Bool = false

  private enum LayoutConstant {
    static let borderOffsetToSwitch: CGFloat = 80.0
    static let bannerViewHeight = 140.0
  }

  private enum ZIndex {
    static let banner = 1.0
  }

  private var currentProfileIconScale: CGFloat {
    let progress = -scrollOffset / LayoutConstant.borderOffsetToSwitch
    let scale = 1.8 - min(progress, 1.0)
    return min(scale, 1)
  }

  var body: some View {
    ScrollView(.vertical) {
      VStack(spacing: 0) {
        UserProfileBannerView(
          scrollOffset: $scrollOffset,
          titleOffset: $titleOffset,
          borderOffsetToSwitch: LayoutConstant.borderOffsetToSwitch,
          viewObserver: viewObserver
        )
        .frame(height: LayoutConstant.bannerViewHeight)
        .zIndex(ZIndex.banner)
        Header()
          .zIndex(-scrollOffset > LayoutConstant.borderOffsetToSwitch ? 0 : 1)
        TabBar()
        Tabs()
      }
    }
    .onChange(of: scrollOffset) { oldValue, newValue in
      if -newValue > LayoutConstant.borderOffsetToSwitch {
        isUserProfileTabsViewScrollEnabled = true
      }
    }
  }

  @ViewBuilder
  private func Header() -> some View {
    VStack {
      HStack {
        Image(systemName: "apple.logo")
          .resizable()
          .scaledToFit()
          .frame(width: 75, height: 75)
          .background(.white)
          .clipShape(Circle())
          .padding(.leading)
          .scaleEffect(currentProfileIconScale)

        Spacer()
      }
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
          }
        )
        .buttonStyle(.plain)
        Spacer()
      }
    }
    .padding(.top)
    .padding(.bottom)
    .overlay(alignment: .bottom) {
      ZStack(alignment: .leading) {
        Divider()
      }
    }
  }

  @ViewBuilder
  private func Tabs() -> some View {
    ScrollView(.horizontal) {
      LazyHStack(spacing: 0) {
        ForEach(tabs) { tab in
          UserPostsTabViewRepresentable(isScrollEnabled: $isUserProfileTabsViewScrollEnabled)
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
          //          UserPostsTabView()
          //            .frame(width: UIScreen.main.bounds.width)
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
  UserProfileView(viewObserver: UserProfileViewObserver())
}
