import PhotosUI
import SwiftUI

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
