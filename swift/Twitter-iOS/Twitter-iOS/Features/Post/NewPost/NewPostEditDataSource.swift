import Foundation
import PhotosUI
import SwiftUI

final class NewPostEditDataSource: ObservableObject {
  @Published var postText: String = ""
  @Published var selectedItems: [PhotosPickerItem] = []
  @Published var selectedImages: [UIImage] = []
  @Published var altText: String = ""
}
