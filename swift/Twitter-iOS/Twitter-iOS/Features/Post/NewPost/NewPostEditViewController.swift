import SwiftUI
import UIKit

final class NewPostEditViewController: UIViewController {

  // MARK: - Private Props

  @ObservedObject private var dataSource = NewPostEditDataSource()
  @ObservedObject private var viewObserver = NewPostEditViewObserver()

  private lazy var newPostEditHostingController: UIHostingController = {
    let controller = UIHostingController(
      rootView: NewPostEditView(dataSource: dataSource, viewObserver: viewObserver))
    controller.view.translatesAutoresizingMaskIntoConstraints = false
    addChild(controller)
    controller.didMove(toParent: self)
    return controller
  }()

  private lazy var photoLibraryAccessHostingController: UIHostingController = {
    let controller = UIHostingController(rootView: PhotosSelector(dataSource: dataSource))
    controller.view.translatesAutoresizingMaskIntoConstraints = false
    addChild(controller)
    controller.didMove(toParent: self)
    return controller
  }()

  private let dimmingView: UIView = {
    let dimmingView = UIView()
    dimmingView.translatesAutoresizingMaskIntoConstraints = false
    dimmingView.backgroundColor = UIColor.black.withAlphaComponent(0.4)
    return dimmingView
  }()

  private let photoLibraryPermissionController = PhotoLibraryPermissionController()
  private let locationPermissionController = LocationPermissionController()

  // MARK: - View Lifecycle

  override func viewDidLoad() {
    super.viewDidLoad()
    setUpSubviews()
    setUpViewObserver()
  }

  // MARK: - Private API

  private func setUpSubviews() {
    view.backgroundColor = .systemBackground

    view.addSubview(newPostEditHostingController.view)
    view.addSubview(photoLibraryAccessHostingController.view)

    let layoutGuide = view.safeAreaLayoutGuide
    let keyboardLayoutGuide = view.keyboardLayoutGuide

    let permissionRequestButtonSize: CGFloat = 28.0

    NSLayoutConstraint.activate([
      newPostEditHostingController.view.topAnchor.constraint(
        equalTo: layoutGuide.topAnchor, constant: 16),
      newPostEditHostingController.view.leadingAnchor.constraint(
        equalTo: layoutGuide.leadingAnchor),
      newPostEditHostingController.view.trailingAnchor.constraint(
        equalTo: layoutGuide.trailingAnchor),
      newPostEditHostingController.view.bottomAnchor.constraint(
        equalTo: keyboardLayoutGuide.bottomAnchor),

      photoLibraryAccessHostingController.view.bottomAnchor.constraint(
        equalTo: keyboardLayoutGuide.topAnchor),
      photoLibraryAccessHostingController.view.leadingAnchor.constraint(
        equalTo: layoutGuide.leadingAnchor),
      photoLibraryAccessHostingController.view.widthAnchor.constraint(
        equalToConstant: permissionRequestButtonSize),
      photoLibraryAccessHostingController.view.heightAnchor.constraint(
        equalToConstant: permissionRequestButtonSize),
    ])
  }

  private func setUpViewObserver() {
    viewObserver.didTapNewPostEditCancelButtonCompletion = { [weak self] in
      self?.askToSaveDraftIfNeeded()
    }

    viewObserver.didTapImageEditButtonCompletion = { [weak self] in
      let selectedImageEditViewController = SelectedImageEditViewController()
      selectedImageEditViewController.modalPresentationStyle = .fullScreen
      self?.present(selectedImageEditViewController, animated: true)
    }

    viewObserver.didTapImageAltButtonCompletion = { [weak self] selectedImageIndex in
      self?.presentAltTextEditViewController(selectedImageIndex)
    }

    viewObserver.didTapTagEditEntryButtonCompletion = { [weak self] in
      self?.presentNewPostTagEditViewController()
    }

    viewObserver.didTapTagEditDoneButtonCompletion = { [weak self] in
      self?.removeTagCandUsersAndDismissTagEditView()
    }

    viewObserver.didInputTextFieldCompletion = { [weak self] in
      let postService = injectPostService()

      DispatchQueue.global(qos: .userInitiated).async {
        postService.fetchSearchedTagCandidateUsers { searchedUsers in
          Task { @MainActor in
            self?.dataSource.tagCandidateUsers = searchedUsers
          }
        }
      }
    }

    viewObserver.didEmptyTextFieldCompletion = { [weak self] in
      Task { @MainActor [weak self] in
        self?.dataSource.tagCandidateUsers.removeAll()
      }
    }

    viewObserver.didTapLocationEditButtonCompletion = { [weak self] in
      self?.requestLocationPermission()
    }

    viewObserver.didTapLocationSettingsTransitionButtonCompletion = { [weak self] in
      self?.presentLocationSettingsNavigationViewController()
    }

    viewObserver.didTapDraftsButtonCompletion = { [weak self] in
      let viewController = DraftsViewController()
      viewController.delegate = self
      self?.present(viewController, animated: true)
    }
  }

  // MARK: - Methods for ViewObserver Completion

  private func askToSaveDraftIfNeeded() {
    guard !dataSource.postText.isEmpty else {
      dismissAfterCleaningUp()
      return
    }
  }

  private func dismissAfterCleaningUp() {
    newPostEditHostingController.view.layer.opacity = 0.0
    photoLibraryAccessHostingController.view.layer.opacity = 0.0

    dismiss(animated: true, completion: nil)
  }

  private func presentAltTextEditViewController(_ selectedImageIndex: Int) {
    let altTextEditViewController = AltTextEditViewController(
      selectedImageIndex: selectedImageIndex, dataSource: dataSource)
    altTextEditViewController.modalPresentationStyle = .pageSheet
    present(altTextEditViewController, animated: true)
  }

  private func presentNewPostTagEditViewController() {
    let newPostTagEditViewController = UIHostingController(
      rootView: NewPostTagEditView(viewObserver: viewObserver, dataSource: dataSource))
    newPostTagEditViewController.modalPresentationStyle = .overFullScreen
    present(newPostTagEditViewController, animated: true)
  }

  private func removeTagCandUsersAndDismissTagEditView() {
    dataSource.tagCandidateUsers.removeAll()
    dismiss(animated: true)
  }

  private func presentLocationAccessExplanationPopUpViewController() {
    let locationAccessExplanationPopUpViewController = UIHostingController(
      rootView: LocationAccessExplanationPopUpView(viewObserver: viewObserver))
    locationAccessExplanationPopUpViewController.modalPresentationStyle = .overFullScreen
    locationAccessExplanationPopUpViewController.view.backgroundColor = UIColor.clear
    addDimmingView()
    present(locationAccessExplanationPopUpViewController, animated: true)
  }

  private func addDimmingView() {
    view.addSubview(dimmingView)

    NSLayoutConstraint.activate([
      dimmingView.topAnchor.constraint(equalTo: view.topAnchor),
      dimmingView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      dimmingView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      dimmingView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
    ])
  }

  private func presentLocationSettingsNavigationViewController() {
    // TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/454
    // - Fix Unintended Dimming View Animation in NewPostEditViewController.

    // Dismiss dimmingView and LocationAccessExplanationPopUpViewController first.
    dimmingView.removeFromSuperview()
    dismiss(animated: true)

    // TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/446
    // - Implement View Controller for Navigating to Device Location Settings.
  }

  // MARK: - Permission Request

  // TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/396
  // - Combine Photo Selection View with PhotoLibraryPermission Functionality.
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

  private func requestLocationPermission() {
    // TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/445
    // - Enable Different View Transitions based on Device Location Settings.
    locationPermissionController.requestPermission { [weak self] status in
      switch status {
      case .authorizedWhenInUse:
        print("authorizedWhenInUse")
      case .denied:
        self?.presentLocationAccessExplanationPopUpViewController()
      case .notDetermined:
        // In the future, requestWhenInUseAuthorization() must be called
        // after dismissing the pop-up view controller in this state.
        // This is planned to be addressed in issue #445.
        self?.presentLocationAccessExplanationPopUpViewController()
      case .restricted:
        print("restricted")
      default:
        print("unknown")
      }
    }
  }
}

extension NewPostEditViewController: DraftsViewControllerDelegate {
  func draftsViewController(_ controller: DraftsViewController, didSelectDraft draft: DraftModel) {
    dataSource.postText = draft.text
  }
}
