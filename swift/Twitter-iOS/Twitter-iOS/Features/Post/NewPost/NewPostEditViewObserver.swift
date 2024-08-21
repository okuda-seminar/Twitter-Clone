import Foundation

typealias didTapNewPostEditCancelButtonCompletion = () -> Void
typealias didTapImageEditButtonCompletion = () -> Void
typealias didTapImageAltButtonCompletion = () -> Void

class NewPostEditViewObserver: ObservableObject {
  var didTapNewPostEditCancelButtonCompletion: didTapNewPostEditCancelButtonCompletion?
  var didTapImageEditButtonCompletion: didTapImageEditButtonCompletion?
  var didTapImageAltButtonCompletion: didTapImageAltButtonCompletion?
}
