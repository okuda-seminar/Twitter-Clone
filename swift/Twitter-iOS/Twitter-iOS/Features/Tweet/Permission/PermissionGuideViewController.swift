import SwiftUI
import UIKit

class PermissionGuideViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    setUpSubviews()
  }

  public func popUp(in parent: UIViewController) {
    parent.addChild(self)
    didMove(toParent: parent)
    parent.view.addSubview(view)

    NSLayoutConstraint.activate([
      view.leadingAnchor.constraint(equalTo: parent.view.leadingAnchor),
      view.trailingAnchor.constraint(equalTo: parent.view.trailingAnchor),
      view.topAnchor.constraint(equalTo: parent.view.topAnchor),
      view.bottomAnchor.constraint(equalTo: parent.view.bottomAnchor),
    ])
  }

  private func setUpSubviews() {
    var sheet = PermissionGuideSheet()
    sheet.delegate = self
    let sheetHostingViewController = UIHostingController(rootView: sheet)
    sheetHostingViewController.view.backgroundColor = .clear

    addChild(sheetHostingViewController)
    sheetHostingViewController.didMove(toParent: self)

    view.translatesAutoresizingMaskIntoConstraints = false
    view.backgroundColor = .clear
    view.addSubview(sheetHostingViewController.view)
    sheetHostingViewController.view.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      sheetHostingViewController.view.topAnchor.constraint(equalTo: view.topAnchor),
      sheetHostingViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      sheetHostingViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      sheetHostingViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
    ])
  }
}

extension PermissionGuideViewController: PermissionGuideSheetDelegate {
  func didTapDismissArea() {
    willMove(toParent: parent)
    view.removeFromSuperview()
    removeFromParent()
  }
}

struct PermissionGuideSheet: View {
  private enum LocalizedString {
    static let headerText = String(localized: "Allow X access to your photos")
    static let headerCaptionText = String(
      localized: "Access was previously denied, please grant access from Settings.")
    static let settingsGuideText = String(localized: "Open iPhone settings")
    static let privacyGuideText = String(localized: "Tap Privacy")
    static let photosGuideText = String(localized: "Tap Photos")
    static let toggleGuideText = String(localized: "Set X to ON")
    static let dismissButtonText = String(localized: "Got it")
  }

  public weak var delegate: PermissionGuideSheetDelegate?

  var body: some View {
    ZStack {
      Rectangle()
        .foregroundStyle(.gray.opacity(0.2))
        .background(.gray.opacity(0.2))
        .onTapGesture {
          delegate?.didTapDismissArea()
        }
      VStack(alignment: .leading) {
        VStack(alignment: .leading) {
          Text(LocalizedString.headerText)
          Text(LocalizedString.headerCaptionText)
            .font(.caption)
        }
        .padding()

        VStack(alignment: .leading) {
          HStack {
            Image(systemName: "gearshape")
            Text(LocalizedString.settingsGuideText)
          }
          HStack {
            Image(systemName: "hand.raised")
            Text(LocalizedString.privacyGuideText)
          }
          HStack {
            Image(systemName: "photo")
            Text(LocalizedString.photosGuideText)
          }
          HStack {
            Image(systemName: "power")
            Text(LocalizedString.toggleGuideText)
          }
        }
        .padding()

        Button(
          LocalizedString.dismissButtonText,
          action: {
            delegate?.didTapDismissArea()
          }
        )
        .padding()
      }
      .background(
        RoundedRectangle(cornerRadius: 20)
          .fill(.white)
      )
    }
  }
}

protocol PermissionGuideSheetDelegate: AnyObject {
  func didTapDismissArea()
}

#Preview{
  PermissionGuideSheet()
}
