import PhotosUI
import SwiftUI
import UIKit

final class NewPostEditViewController: UIViewController {

  // MARK: - Private Props

  private enum LayoutConstant {
    static let edgePadding: CGFloat = 16.0
    static let permissionRequestButtonSize: CGFloat = 28.0
    static let dimmingViewAlpha: CGFloat = 0.4
  }

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
    dimmingView.backgroundColor = UIColor.black.withAlphaComponent(
      LayoutConstant.dimmingViewAlpha)
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

    NSLayoutConstraint.activate([
      newPostEditHostingController.view.topAnchor.constraint(
        equalTo: layoutGuide.topAnchor, constant: LayoutConstant.edgePadding),
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
        equalToConstant: LayoutConstant.permissionRequestButtonSize),
      photoLibraryAccessHostingController.view.heightAnchor.constraint(
        equalToConstant: LayoutConstant.permissionRequestButtonSize),
    ])
  }

  private func setUpViewObserver() {
    viewObserver.didTapNewPostEditCancelButtonCompletion = { [weak self] in
      self?.makeTransparentAndDismiss()
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
  }

  // MARK: - Methods for ViewObserver Completion

  private func makeTransparentAndDismiss() {
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

// MARK: - View

struct NewPostEditView: View {

  // MARK: - Private Props

  private enum LayoutConstant {
    static let userIconSize: CGFloat = 32.0
    static let postButtonSize: CGFloat = 40.0
    static let postButtonRadius: CGFloat = 20.0
    static let textFieldTopPadding: CGFloat = 5.0
    static let singleImageHeight: CGFloat = 450.0
    static let singleImageLeadingPadding: CGFloat = 40.0
    static let multipleImagesWidth: CGFloat = 130.0
    static let multipleImagesHeight: CGFloat = 190.0
    static let firstImageLeadingPadding: CGFloat = 40.0
    static let imageCornerRadius: CGFloat = 10.0
    static let imageEditButtonsOpacity: CGFloat = 0.7
    static let deleteButtonSize: CGFloat = 30.0
    static let brushButtonSize: CGFloat = 30.0
    static let altButtonWidth: CGFloat = 45.0
    static let altButtonHeight: CGFloat = 30.0
    static let altButtonCornerRadius: CGFloat = 15.0
  }

  private enum LocalizedString {
    static let cancelButtonText = String(localized: "Cancel")
    static let draftsButtonText = String(localized: "Drafts")
    static let postButtonText = String(localized: "Post")
    static let textFieldPlaceHolderText = String(localized: "What's happening?")
    static let altButtonText = String(localized: "+Alt")
    static let tagEditButtonText = String(localized: "Tag people")
    static let locationEditButtonText = String(localized: "Add location")
  }

  private enum imageSelectionState: Int {
    case none
    case single
    case multiple
  }

  private var currentImageSelectionState: imageSelectionState {
    switch dataSource.selectedImages.count {
    case 0:
      return .none
    case 1:
      return .single
    default:
      return .multiple
    }
  }

  @ObservedObject private(set) var dataSource: NewPostEditDataSource
  @ObservedObject private(set) var viewObserver: NewPostEditViewObserver

  private var isPostButtonDisabled: Bool {
    dataSource.postText.isEmpty
  }

  var body: some View {
    VStack {
      Header()
      InputField()
    }
    Spacer()
  }

  @ViewBuilder
  private func Header() -> some View {
    HStack {
      Button(
        action: {
          viewObserver.didTapNewPostEditCancelButtonCompletion?()
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
          let draftService = injectDraftService()
          draftService.save(draft: DraftModel(text: $dataSource.postText.wrappedValue))
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
  private func InputField() -> some View {
    VStack(alignment: .leading) {
      HStack(alignment: .top) {
        Image(systemName: "person.circle.fill")
          .resizable()
          .scaledToFit()
          .frame(width: LayoutConstant.userIconSize, height: LayoutConstant.userIconSize)

        TextField(
          LocalizedString.textFieldPlaceHolderText,
          text: $dataSource.postText,
          axis: .vertical
        )
        .padding(.top, LayoutConstant.textFieldTopPadding)
      }
      .padding(.horizontal)

      SelectedImagesCatalog()
        .padding(.horizontal)
    }
  }

  @ViewBuilder
  private func SelectedImagesCatalog() -> some View {
    switch currentImageSelectionState {
    case .none:
      EmptyView()
    case .single:
      VStack(alignment: .leading) {
        Image(uiImage: dataSource.selectedImages[0])
          .resizable()
          .frame(minWidth: 0.0, maxWidth: .infinity)
          .frame(height: LayoutConstant.singleImageHeight)
          .clipShape(RoundedRectangle(cornerRadius: LayoutConstant.imageCornerRadius))
          .padding(.leading, LayoutConstant.singleImageLeadingPadding)
          .overlay(alignment: .trailing) {
            imageEditButtons(selectedImageIndex: 0)
          }

        TagAndLocationEditButtons()
          .padding(.leading, LayoutConstant.singleImageLeadingPadding)
      }
    case .multiple:
      VStack(alignment: .leading) {
        ScrollView(.horizontal) {
          HStack {
            ForEach(dataSource.selectedImages.indices, id: \.self) { index in
              Image(uiImage: dataSource.selectedImages[index])
                .resizable()
                .frame(
                  width: LayoutConstant.multipleImagesWidth,
                  height: LayoutConstant.multipleImagesHeight
                )
                .clipShape(RoundedRectangle(cornerRadius: LayoutConstant.imageCornerRadius))
                .overlay(alignment: .trailing) {
                  imageEditButtons(selectedImageIndex: index)
                }
                .padding(.leading, index == 0 ? LayoutConstant.firstImageLeadingPadding : 0.0)
            }
          }
        }

        TagAndLocationEditButtons()
          .padding(.leading, LayoutConstant.firstImageLeadingPadding)
      }
    }
  }

  @ViewBuilder
  private func imageEditButtons(selectedImageIndex: Int) -> some View {
    VStack(alignment: .trailing) {
      Button {
        // TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/402
        // - Add Delete Image Functionality to Cancel Button in NewPostEditViewController.swift.
      } label: {
        Image(systemName: "xmark")
          .foregroundStyle(.white)
          .background(
            Circle()
              .fill(Color.black)
              .frame(
                width: LayoutConstant.deleteButtonSize, height: LayoutConstant.deleteButtonSize
              )
              .opacity(LayoutConstant.imageEditButtonsOpacity)
          )
      }

      Spacer()

      HStack {
        Button {
          viewObserver.didTapImageAltButtonCompletion?(selectedImageIndex)
        } label: {
          Text(LocalizedString.altButtonText)
            .font(.headline)
            .foregroundStyle(.white)
            .background(
              RoundedRectangle(cornerRadius: LayoutConstant.altButtonCornerRadius)
                .fill(Color.black)
                .frame(width: LayoutConstant.altButtonWidth, height: LayoutConstant.altButtonHeight)
                .opacity(LayoutConstant.imageEditButtonsOpacity)
            )
        }
        .padding(.horizontal)

        Button {
          viewObserver.didTapImageEditButtonCompletion?()
        } label: {
          Image(systemName: "paintbrush.pointed")
            .foregroundStyle(.white)
            .background(
              Circle()
                .fill(Color.black)
                .frame(
                  width: LayoutConstant.brushButtonSize, height: LayoutConstant.brushButtonSize
                )
                .opacity(LayoutConstant.imageEditButtonsOpacity)
            )
        }
      }
    }
    .padding()
  }

  @ViewBuilder
  private func TagAndLocationEditButtons() -> some View {
    VStack {
      Button {
        viewObserver.didTapTagEditEntryButtonCompletion?()
      } label: {
        HStack {
          Image(systemName: "person")
            .foregroundStyle(.blue)

          Text(LocalizedString.tagEditButtonText)
            .foregroundStyle(.blue)
        }
      }

      Button {
        viewObserver.didTapLocationEditButtonCompletion?()
      } label: {
        HStack {
          Image(systemName: "mappin")
            .foregroundStyle(.gray)

          Text(LocalizedString.locationEditButtonText)
            .foregroundStyle(.gray)
        }
      }
    }
  }
}

struct PhotosSelector: View {
  @ObservedObject var dataSource: NewPostEditDataSource

  var body: some View {
    // TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/393
    // - Enable Video Selection from Library Using PhotosPicker.
    PhotosPicker(
      selection: $dataSource.selectedItems,
      matching: .images
    ) {
      Image(systemName: "photo")
    }
    .onChange(of: dataSource.selectedItems) {
      setImages(from: dataSource.selectedItems)
    }
  }

  private func setImages(from selectedItems: [PhotosPickerItem]) {
    Task {
      var images: [UIImage] = []
      for selectedItem in selectedItems {
        guard let data = try? await selectedItem.loadTransferable(type: Data.self) else { return }
        guard let uiImage = UIImage(data: data) else { return }
        images.append(uiImage)
        dataSource.altTexts.append("")
      }

      dataSource.selectedImages = images
    }
  }
}

#Preview {
  NewPostEditViewController()
}
