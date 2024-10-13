import Foundation
import PhotosUI
import SwiftUI

final class NewPostEditDataSource: ObservableObject {
  @Published var postText: String = ""
  @Published var selectedItems: [PhotosPickerItem] = []
  @Published var selectedImages: [UIImage] = []
  @Published var altTexts: [String] = []
  @Published var tagCandidateUsers: [SearchedUserModel] = []
}

func createFakeNewPostEditDataSource() -> NewPostEditDataSource {
  let fakeDataSource = NewPostEditDataSource()
  fakeDataSource.postText = "postText"
  fakeDataSource.selectedImages = []
  fakeDataSource.selectedImages = [UIImage(systemName: "apple.logo")!]
  fakeDataSource.altTexts = ["altTexts"]
  fakeDataSource.tagCandidateUsers = Array(repeating: createFakeSearchedUserModel(), count: 30)
  return fakeDataSource
}
