import Foundation

typealias didTapImageEditCancelButtonCompletion = () -> Void

class SelectedImageEditViewObserver: ObservableObject {
  var didTapImageEditCancelButtonCompletion: didTapImageEditCancelButtonCompletion?
}
