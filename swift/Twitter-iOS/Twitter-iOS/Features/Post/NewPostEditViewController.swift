import Photos
import SwiftUI
import UIKit

final class NewPostEditViewController: UIViewController {

  private enum LayoutConstant {
    static let edgePadding: CGFloat = 16.0
    static let permissionRequestButtonSize: CGFloat = 28.0
  }

  private lazy var hostingController: UIHostingController = {
    let controller = UIHostingController(rootView: NewPostEditView(delegate: self))
    controller.view.translatesAutoresizingMaskIntoConstraints = false
    addChild(controller)
    controller.didMove(toParent: self)
    return controller
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

    view.addSubview(hostingController.view)
    view.addSubview(photoLibraryPermissionRequestButton)

    photoLibraryPermissionRequestButton.addAction(
      .init { _ in
        self.requestPhotoLibraryPermission()
      }, for: .touchUpInside)

    let layoutGuide = view.safeAreaLayoutGuide
    let keyboardLayoutGuide = view.keyboardLayoutGuide

    NSLayoutConstraint.activate([
      hostingController.view.topAnchor.constraint(
        equalTo: layoutGuide.topAnchor, constant: LayoutConstant.edgePadding),
      hostingController.view.leadingAnchor.constraint(
        equalTo: layoutGuide.leadingAnchor),
      hostingController.view.trailingAnchor.constraint(
        equalTo: layoutGuide.trailingAnchor),
      hostingController.view.bottomAnchor.constraint(
        equalTo: keyboardLayoutGuide.bottomAnchor),

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

extension NewPostEditViewController: NewPostEditViewDelegate {

  func didTapDismissalButton() {
    hostingController.view.layer.opacity = 0.0
    photoLibraryPermissionRequestButton.layer.opacity = 0.0

    dismiss(animated: true, completion: nil)
  }
}

struct NewPostEditView: View {

  // MARK: - Public Props

  public weak var delegate: NewPostEditViewDelegate?

  // MARK: - Private Props

  private enum LayoutConstant {
    static let userIconSize: CGFloat = 32.0
    static let postButtonSize: CGFloat = 40.0
    static let postButtonRadius: CGFloat = 20.0
    static let textFieldTopPadding: CGFloat = 5.0
  }

  private enum LocalizedString {
    static let cancelButtonText = String(localized: "Cancel")
    static let draftsButtonText = String(localized: "Drafts")
    static let postButtonText = String(localized: "Post")
    static let textFieldPlaceHolderText = String(localized: "What's happening?")
  }

  @State private var postText: String = ""

  private var isPostButtonDisabled: Bool {
    postText.isEmpty
  }

  var body: some View {
    VStack {
      Header()
      InputTextFieldWithUserIcon()
    }
    Spacer()
  }

  @ViewBuilder
  private func Header() -> some View {
    HStack {
      Button(
        action: {
          delegate?.didTapDismissalButton()
        },
        label: {
          Text(LocalizedString.cancelButtonText)
            .underline()
            .foregroundStyle(.black)
        })

      Spacer()

      Button(
        action: {
          // TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/337
          // - Add Post Functionality to POST Button in NewPostEditViewController.swift.
        },
        label: {
          Text(LocalizedString.draftsButtonText)
            .underline()
        })

      Button(
        action: {
          // TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/338
          // - Add Making Post Drafts Functionality to Drafts Button in NewPostEditViewController.swift.
        },
        label: {
          Text(LocalizedString.postButtonText)
            .foregroundStyle(.white)
            .underline()
            .padding()
        }
      )
      .background(Color(.blue))
      .frame(height: LayoutConstant.postButtonSize)
      .clipShape(RoundedRectangle(cornerRadius: LayoutConstant.postButtonRadius))
      .opacity(isPostButtonDisabled ? 0.5 : 1.0)
      .disabled(isPostButtonDisabled)
    }
    .padding(.horizontal)
  }

  @ViewBuilder
  private func InputTextFieldWithUserIcon() -> some View {
    HStack(alignment: .top) {
      Image(systemName: "person.circle.fill")
        .resizable()
        .scaledToFit()
        .frame(width: LayoutConstant.userIconSize, height: LayoutConstant.userIconSize)

      TextField(
        LocalizedString.textFieldPlaceHolderText,
        text: $postText,
        axis: .vertical
      )
      .padding(.top, LayoutConstant.textFieldTopPadding)
    }
    .padding()
  }
}

protocol NewPostEditViewDelegate: AnyObject {
  func didTapDismissalButton()
}

#Preview {
  NewPostEditView()
}
