import Photos
import SwiftUI
import UIKit

final class NewPostEditViewController: UIViewController {
  private enum LocalizedString {
    static let cancelButtonTitle = String(localized: "Cancel")
    static let postTextViewPlaceholderText = String(localized: "What's happening?")
  }

  private enum LayoutConstant {
    static let edgePadding = 16.0
    static let postTextViewTopPadding = 12.0
    static let postTextViewMinimumHeight = 48.0
    static let permissionRequestButtonSize = 28.0
  }

  private var postTextViewHightConstraint: NSLayoutConstraint?

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

  private let postTextView: UITextView = {
    let textView = UITextView()
    textView.translatesAutoresizingMaskIntoConstraints = false
    textView.backgroundColor = .clear
    textView.textColor = .black
    textView.isEditable = true
    return textView
  }()

  private let postTextViewPlaceHolder: UITextView = {
    let placeHolder = UITextView()
    placeHolder.translatesAutoresizingMaskIntoConstraints = false
    placeHolder.text = LocalizedString.postTextViewPlaceholderText
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

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    postTextView.becomeFirstResponder()
  }

  private func setUpSubviews() {
    view.backgroundColor = .systemBackground
    view.addSubview(cancelButton)
    view.addSubview(postTextViewPlaceHolder)
    view.addSubview(postTextView)
    view.addSubview(photoLibraryPermissionRequestButton)

    cancelButton.addAction(
      .init { _ in
        self.dismiss(animated: true)
      }, for: .touchUpInside)

    postTextView.delegate = self

    photoLibraryPermissionRequestButton.addAction(
      .init { _ in
        self.requestPhotoLibraryPermission()
      }, for: .touchUpInside)

    let layoutGuide = view.safeAreaLayoutGuide
    let keyboardLayoutGuide = view.keyboardLayoutGuide
    let postTextViewPlaceHolderHeight = postTextViewPlaceHolder.frame.height
    postTextViewHightConstraint = postTextView.heightAnchor.constraint(
      equalToConstant: postTextViewPlaceHolderHeight)
    guard let postTextViewHightConstraint else { return }
    NSLayoutConstraint.activate([
      cancelButton.topAnchor.constraint(
        equalTo: layoutGuide.topAnchor, constant: LayoutConstant.edgePadding),
      cancelButton.leadingAnchor.constraint(
        equalTo: layoutGuide.leadingAnchor, constant: LayoutConstant.edgePadding),

      postTextView.leadingAnchor.constraint(equalTo: cancelButton.leadingAnchor),
      postTextView.trailingAnchor.constraint(
        equalTo: layoutGuide.trailingAnchor, constant: -LayoutConstant.edgePadding),
      postTextView.topAnchor.constraint(
        equalTo: cancelButton.bottomAnchor, constant: LayoutConstant.postTextViewTopPadding),
      postTextViewHightConstraint,

      postTextViewPlaceHolder.topAnchor.constraint(equalTo: postTextView.topAnchor),
      postTextViewPlaceHolder.leadingAnchor.constraint(equalTo: postTextView.leadingAnchor),
      postTextViewPlaceHolder.trailingAnchor.constraint(equalTo: postTextView.trailingAnchor),
      postTextViewPlaceHolder.heightAnchor.constraint(
        equalToConstant: postTextViewPlaceHolderHeight),

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

extension NewPostEditViewController: UITextViewDelegate {
  func textViewDidChange(_ textView: UITextView) {
    postTextViewPlaceHolder.isHidden = !textView.text.isEmpty
    let height = textView.sizeThatFits(
      CGSize(width: textView.frame.width, height: CGFloat.greatestFiniteMagnitude)
    ).height
    postTextViewHightConstraint?.constant = height
  }
}
