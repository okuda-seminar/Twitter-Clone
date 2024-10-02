import Foundation

typealias didTapNewPostEditCancelButtonCompletion = () -> Void
typealias didTapImageEditButtonCompletion = () -> Void
typealias didTapImageAltButtonCompletion = (Int) -> Void
typealias didTapTagEditEntryButtonCompletion = () -> Void
typealias didTapTagEditDoneButtonCompletion = () -> Void
typealias didTapLocationEditButtonCompletion = () -> Void

class NewPostEditViewObserver: ObservableObject {
  var didTapNewPostEditCancelButtonCompletion: didTapNewPostEditCancelButtonCompletion?
  var didTapImageEditButtonCompletion: didTapImageEditButtonCompletion?
  var didTapImageAltButtonCompletion: didTapImageAltButtonCompletion?
  var didTapTagEditEntryButtonCompletion: didTapTagEditEntryButtonCompletion?
  var didTapTagEditDoneButtonCompletion: didTapTagEditDoneButtonCompletion?
  var didTapLocationEditButtonCompletion: didTapLocationEditButtonCompletion?
}
