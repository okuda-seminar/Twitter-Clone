import Foundation

typealias didTapCancelButtonCompletion = () -> Void

class NewPostEditViewObserver: ObservableObject {
  var didTapCancelButtonCompletion: didTapCancelButtonCompletion?
}
