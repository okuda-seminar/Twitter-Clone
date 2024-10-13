import Foundation

typealias didTapNewPostEditCancelButtonCompletion = () -> Void
typealias didTapImageEditButtonCompletion = () -> Void
typealias didTapImageAltButtonCompletion = (Int) -> Void
typealias didTapTagEditEntryButtonCompletion = () -> Void
typealias didTapTagEditDoneButtonCompletion = () -> Void
typealias didInputTextFieldCompletion = () -> Void
typealias didEmptyTextFieldCompletion = () -> Void
typealias didTapLocationEditButtonCompletion = () -> Void
typealias didTapLocationSettingsTransitionButtonCompletion = () -> Void

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
}
