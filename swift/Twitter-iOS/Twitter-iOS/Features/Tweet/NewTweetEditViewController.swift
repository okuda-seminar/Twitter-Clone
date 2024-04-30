import Photos
import SwiftUI
import UIKit

final class NewTweetEditViewController: UIViewController {
  private enum LocalizedString {
    static let cancelButtonTitle = String(localized: "Cancel")
    static let tweetTextViewPlaceholderText = String(localized: "What's happening?")
  }

  private enum LayoutConstant {
    static let edgePadding = 16.0
    static let tweetTextViewTopPadding = 12.0
    static let tweetTextViewMinimumHeight = 48.0
    static let permissionRequestButtonSize = 28.0
  }

  private var tweetTextViewHightConstraint: NSLayoutConstraint?

  private let cancelButton: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.tintColor = .black
    let titleWithUnderLine = NSAttributedString(
      string: LocalizedString.cancelButtonTitle,
      attributes: [
        .underlineStyle: NSUnderlineStyle.single.rawValue, .underlineColor: UIColor.black,
      ])
    button.setAttributedTitle(titleWithUnderLine, for: .normal)
    button.sizeToFit()
    return button
  }()

  private let tweetTextView: UITextView = {
    let textView = UITextView()
    textView.translatesAutoresizingMaskIntoConstraints = false
    textView.backgroundColor = .clear
    textView.textColor = .black
    textView.isEditable = true
    return textView
  }()

  private let tweetTextViewPlaceHolder: UITextView = {
    let placeHolder = UITextView()
    placeHolder.translatesAutoresizingMaskIntoConstraints = false
    placeHolder.text = LocalizedString.tweetTextViewPlaceholderText
    placeHolder.textColor = .lightGray
    placeHolder.isEditable = false
    placeHolder.isUserInteractionEnabled = false
    placeHolder.sizeToFit()
    return placeHolder
  }()

  private let photoLibraryPermissionRequestButton: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setImage(UIImage(systemName: "photo"), for: .normal)
    button.contentMode = .scaleAspectFit
    button.contentHorizontalAlignment = .fill
    button.contentVerticalAlignment = .fill
    return button
  }()

  private let photoLibraryPermissionController = PhotoLibraryPermissionController()

  override func viewDidLoad() {
    super.viewDidLoad()
    setUpSubviews()
  }

  private func setUpSubviews() {
    view.backgroundColor = .systemBackground
    view.addSubview(cancelButton)
    view.addSubview(tweetTextViewPlaceHolder)
    view.addSubview(tweetTextView)
    view.addSubview(photoLibraryPermissionRequestButton)

    cancelButton.addAction(
      .init { _ in
        self.dismiss(animated: true)
      }, for: .touchUpInside)

    tweetTextView.becomeFirstResponder()
    tweetTextView.delegate = self

    photoLibraryPermissionRequestButton.addAction(
      .init { _ in
        self.requestPhotoLibraryPermission()
      }, for: .touchUpInside)

    let layoutGuide = view.safeAreaLayoutGuide
    let keyboardLayoutGuide = view.keyboardLayoutGuide
    let tweetTextViewPlaceHolderHeight = tweetTextViewPlaceHolder.frame.height
    tweetTextViewHightConstraint = tweetTextView.heightAnchor.constraint(
      equalToConstant: tweetTextViewPlaceHolderHeight)
    guard let tweetTextViewHightConstraint else { return }
    NSLayoutConstraint.activate([
      cancelButton.topAnchor.constraint(
        equalTo: layoutGuide.topAnchor, constant: LayoutConstant.edgePadding),
      cancelButton.leadingAnchor.constraint(
        equalTo: layoutGuide.leadingAnchor, constant: LayoutConstant.edgePadding),

      tweetTextView.leadingAnchor.constraint(equalTo: cancelButton.leadingAnchor),
      tweetTextView.trailingAnchor.constraint(
        equalTo: layoutGuide.trailingAnchor, constant: -LayoutConstant.edgePadding),
      tweetTextView.topAnchor.constraint(
        equalTo: cancelButton.bottomAnchor, constant: LayoutConstant.tweetTextViewTopPadding),
      tweetTextViewHightConstraint,

      tweetTextViewPlaceHolder.topAnchor.constraint(equalTo: tweetTextView.topAnchor),
      tweetTextViewPlaceHolder.leadingAnchor.constraint(equalTo: tweetTextView.leadingAnchor),
      tweetTextViewPlaceHolder.trailingAnchor.constraint(equalTo: tweetTextView.trailingAnchor),
      tweetTextViewPlaceHolder.heightAnchor.constraint(
        equalToConstant: tweetTextViewPlaceHolderHeight),

      photoLibraryPermissionRequestButton.bottomAnchor.constraint(
        equalTo: keyboardLayoutGuide.topAnchor),
      photoLibraryPermissionRequestButton.leadingAnchor.constraint(
        equalTo: layoutGuide.leadingAnchor),
      photoLibraryPermissionRequestButton.widthAnchor.constraint(
        equalToConstant: LayoutConstant.permissionRequestButtonSize),
      photoLibraryPermissionRequestButton.heightAnchor.constraint(
        equalToConstant: LayoutConstant.permissionRequestButtonSize),
    ])
  }

  // MARK: - Permission Request

  private func requestPhotoLibraryPermission() {
    photoLibraryPermissionController.requestPermission { status in
      switch status {
      case .authorized:
        print("authorized")
      case .denied:
        Task { @MainActor in
          let permissionGuideViewController = PermissionGuideViewController()
          permissionGuideViewController.popUp(in: self)
        }
      case .limited:
        print("limited")
      case .notDetermined:
        print("notDetermined")
      case .restricted:
        print("restricted")
      default:
        print("unknown")
      }
    }
  }
}

extension NewTweetEditViewController: UITextViewDelegate {
  func textViewDidChange(_ textView: UITextView) {
    tweetTextViewPlaceHolder.isHidden = !textView.text.isEmpty
    let height = textView.sizeThatFits(
      CGSize(width: textView.frame.width, height: CGFloat.greatestFiniteMagnitude)
    ).height
    tweetTextViewHightConstraint?.constant = height
  }
}
