import Foundation
import PhotosUI
import SwiftUI

typealias didTapNewPostEditCancelButtonCompletion = () -> Void
typealias didTapImageEditButtonCompletion = () -> Void
typealias didTapImageAltButtonCompletion = (Int) -> Void
typealias didTapTagEditEntryButtonCompletion = () -> Void
typealias didTapTagEditDoneButtonCompletion = () -> Void
typealias didInputTextFieldCompletion = () -> Void
typealias didEmptyTextFieldCompletion = () -> Void
typealias didTapLocationEditButtonCompletion = () -> Void
typealias didTapLocationSettingsTransitionButtonCompletion = () -> Void
typealias didTapDraftsButtonCompletion = () -> Void

class NewPostEditViewObserver: ObservableObject {
  var didTapNewPostEditCancelButtonCompletion: didTapNewPostEditCancelButtonCompletion?
  var didTapImageEditButtonCompletion: didTapImageEditButtonCompletion?
  var didTapImageAltButtonCompletion: didTapImageAltButtonCompletion?
  var didTapTagEditEntryButtonCompletion: didTapTagEditEntryButtonCompletion?
  var didTapTagEditDoneButtonCompletion: didTapTagEditDoneButtonCompletion?
  var didInputTextFieldCompletion: didInputTextFieldCompletion?
  var didEmptyTextFieldCompletion: didEmptyTextFieldCompletion?
  var didTapLocationEditButtonCompletion: didTapLocationEditButtonCompletion?
  var didTapLocationSettingsTransitionButtonCompletion:
    didTapLocationSettingsTransitionButtonCompletion?
  var didTapDraftsButtonCompletion: didTapDraftsButtonCompletion?
}

// MARK: - View

struct NewPostEditView: View {

  // MARK: - Private Props

  private enum LayoutConstant {
    static let singleImageLeadingPadding: CGFloat = 40.0
    static let firstImageLeadingPadding: CGFloat = 40.0
    static let imageCornerRadius: CGFloat = 10.0
    static let imageEditButtonsOpacity: CGFloat = 0.7
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
  @Environment(\.dismiss) private var dismiss

  @ObservedObject private(set) var dataSource: NewPostEditDataSource
  @ObservedObject private(set) var viewObserver: NewPostEditViewObserver

  @State private var showsDraftBottomSheet: Bool = false
  @State private var dismissesEditView: Bool = false

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
          if $dataSource.postText.wrappedValue.isEmpty {
            viewObserver.didTapNewPostEditCancelButtonCompletion?()
          } else {
            showsDraftBottomSheet.toggle()
          }
        },
        label: {
          Text(LocalizedString.cancelButtonText)
            .underline()
            .foregroundStyle(.black)
        }
      )
      .sheet(isPresented: $showsDraftBottomSheet) {
        DraftBottomSheetView(
          isPresented: $showsDraftBottomSheet,
          shouldDismissParentView: $dismissesEditView,
          draft: .init(text: $dataSource.postText.wrappedValue)
        )
        .presentationDetents([.height(200)])
      }
      .onChange(of: dismissesEditView) {
        dismiss()
      }

      Spacer()

      Button(
        action: {
          // TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/337
          // - Add Post Functionality to POST Button in NewPostEditViewController.swift.
          viewObserver.didTapDraftsButtonCompletion?()
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
      .frame(height: 40)
      .clipShape(RoundedRectangle(cornerRadius: 20))
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
          .frame(width: 32, height: 32)

        TextField(
          LocalizedString.textFieldPlaceHolderText,
          text: $dataSource.postText,
          axis: .vertical
        )
        .padding(.top, 5)
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
          .frame(height: 450)
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
                  width: 130,
                  height: 190
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
                width: 30, height: 30
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
              RoundedRectangle(cornerRadius: 15)
                .fill(Color.black)
                .frame(width: 45, height: 30)
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
                  width: 30, height: 30
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
