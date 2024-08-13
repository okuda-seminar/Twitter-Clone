import PhotosUI
import SwiftUI
import UIKit

final class NewPostEditViewController: UIViewController {

  // MARK: Private Props

  private enum LayoutConstant {
    static let edgePadding: CGFloat = 16.0
    static let permissionRequestButtonSize: CGFloat = 28.0
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

  private let photoLibraryPermissionController = PhotoLibraryPermissionController()

  override func viewDidLoad() {
    super.viewDidLoad()
    setUpSubviews()
    setUpViewObserver()
  }

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
    viewObserver.didTapCancelButtonCompletion = { [weak self] in
      self?.newPostEditHostingController.view.layer.opacity = 0.0
      self?.photoLibraryAccessHostingController.view.layer.opacity = 0.0

      self?.dismiss(animated: true, completion: nil)
    }
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
}

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
  }

  private enum LocalizedString {
    static let cancelButtonText = String(localized: "Cancel")
    static let draftsButtonText = String(localized: "Drafts")
    static let postButtonText = String(localized: "Post")
    static let textFieldPlaceHolderText = String(localized: "What's happening?")
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
          viewObserver.didTapCancelButtonCompletion?()
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

      // TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/395
      // - Create Tag and Location Button in NewPostEditViewController.swift.
    }
  }

  @ViewBuilder
  private func SelectedImagesCatalog() -> some View {
    switch currentImageSelectionState {
    // TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/394
    // - Add Cancel, Alt, and Edit Button to Image in NewPostEditViewController.swift.
    case .none:
      EmptyView()
    case .single:
      Image(uiImage: dataSource.selectedImages[0])
        .resizable()
        .frame(minWidth: 0.0, maxWidth: .infinity)
        .frame(height: LayoutConstant.singleImageHeight)
        .clipShape(RoundedRectangle(cornerRadius: LayoutConstant.imageCornerRadius))
        .padding(.leading, LayoutConstant.singleImageLeadingPadding)
    case .multiple:
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
              .padding(.leading, index == 0 ? LayoutConstant.firstImageLeadingPadding : 0.0)
          }
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
      }

      dataSource.selectedImages = images
    }
  }
}

#Preview {
  NewPostEditView(dataSource: NewPostEditDataSource(), viewObserver: NewPostEditViewObserver())
}
