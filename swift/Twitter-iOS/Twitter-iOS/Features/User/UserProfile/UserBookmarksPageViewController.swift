import SwiftUI
import UIKit

class UserBookmarksPageViewController: UIViewController {

  private enum LocalizedString {
    static let title = String(localized: "Bookmarks")
    static let menuActionOneTitle = String(localized: "Clear all Bookmarks")
  }

  private lazy var bookmarkHostingController: UIHostingController = {
    let controller = UIHostingController(rootView: BookmarkView())
    controller.view.translatesAutoresizingMaskIntoConstraints = false
    addChild(controller)
    controller.didMove(toParent: self)
    return controller
  }()

  private let menuButton: UIBarButtonItem = {
    let button = UIBarButtonItem()
    button.tintColor = .black
    button.image = UIImage(systemName: "ellipsis")

    let action1 = UIAction(title: LocalizedString.menuActionOneTitle) { action in
      // TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/309
      // - Add Clear All Bookmarks Action to Menu Button in UserBookmarksPageViewController.swift
    }

    button.menu = UIMenu(children: [action1])
    return button
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    setSubviews()
  }

  private func setSubviews() {
    view.backgroundColor = .systemBackground

    view.addSubview(bookmarkHostingController.view)

    let layoutGuide = view.safeAreaLayoutGuide
    NSLayoutConstraint.activate([
      bookmarkHostingController.view.topAnchor.constraint(equalTo: layoutGuide.topAnchor),
      bookmarkHostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      bookmarkHostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      bookmarkHostingController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
    ])

    // set up navigation
    navigationItem.backButtonDisplayMode = .minimal
    navigationItem.title = LocalizedString.title
    navigationItem.rightBarButtonItems = [menuButton]
    navigationController?.navigationBar.backgroundColor = .systemBackground
  }
}

struct BookmarkView: View {
  private enum LayoutConstant {
    static let headlineFontSize: CGFloat = 29.0
    static let headlineViewSpacing: CGFloat = 10.0
    static let headlineViewVerticalPadding: CGFloat = 50.0
    static let subHeadlineFontSize: CGFloat = 15.0
  }

  private enum LocalizedString {
    static let headlineText = String(localized: "Save Posts for later")

    // The backslash (\) at the end of the first line is used for line continuation.
    static let subHeadlineText = String(
      localized:
        """
        Don't let the good ones fly away! \
        Bookmarks posts to easily find them again in the future.
        """
    )
  }

  var body: some View {
    VStack(
      alignment: .leading, spacing: LayoutConstant.headlineViewSpacing,
      content: {
        Text(LocalizedString.headlineText)
          .font(.system(size: LayoutConstant.headlineFontSize, weight: .heavy))

        Text(LocalizedString.subHeadlineText)
          .font(.system(size: LayoutConstant.subHeadlineFontSize))
          .foregroundStyle(.gray)

        Spacer()
      }
    )
    .padding(.vertical, LayoutConstant.headlineViewVerticalPadding)
  }
}

#Preview {
  BookmarkView()
}
