import Foundation

typealias didTapDismissalButtonCompletion = () -> Void

class BlockedNewCommunityCreationBottomSheetViewObserver: ObservableObject {
  var didTapDismissalButton: didTapDismissalButtonCompletion?
}
