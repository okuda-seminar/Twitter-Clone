import Foundation
import PhotosUI
import SwiftUI

final class NewPostEditDataSource: ObservableObject {
  @Published var postText: String = ""
  @Published var selectedItems: [PhotosPickerItem] = []
  @Published var selectedImages: [UIImage] = []
  @Published var altTexts: [String] = []
}

func createFakeNewPostEditDataSource() -> NewPostEditDataSource {
  let fakeDataSource = NewPostEditDataSource()
  fakeDataSource.postText = "postText"
  fakeDataSource.selectedImages = []
  fakeDataSource.selectedImages = [UIImage(systemName: "apple.logo")!]
  fakeDataSource.altTexts = ["altTexts"]
  return fakeDataSource
}
