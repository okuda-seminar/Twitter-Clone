import Photos

class PhotoLibraryPermissionController {
  public var currentPermission: PHAuthorizationStatus {
    return PHPhotoLibrary.authorizationStatus(for: .readWrite)
  }

  public func requestPermission(completion: @escaping (PHAuthorizationStatus) -> Void) {
    Task {
      await PHPhotoLibrary.requestAuthorization(for: .readWrite)
      completion(self.currentPermission)
    }
  }
}
