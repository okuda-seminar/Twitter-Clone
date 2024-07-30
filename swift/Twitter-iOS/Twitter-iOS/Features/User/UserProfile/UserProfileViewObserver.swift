import Foundation

typealias didTapBackButtonCompletion = () -> Void

class UserProfileViewObserver: ObservableObject {
  var didTapBackButtonCompletion: didTapBackButtonCompletion?
}
