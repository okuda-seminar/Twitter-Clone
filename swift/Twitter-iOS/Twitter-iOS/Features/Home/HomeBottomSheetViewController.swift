import SwiftUI
import UIKit

class HomeBottomSheetViewController: UIViewController {
  private lazy var hostingController: UIHostingController = {
    let controller = UIHostingController(rootView: HomeBottomSheetView())
    controller.view.translatesAutoresizingMaskIntoConstraints = false
    addChild(controller)
    controller.didMove(toParent: self)
    return controller
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    setUpSubviews()
  }

  private func setUpSubviews() {
    view.backgroundColor = .systemBackground
    view.addSubview(hostingController.view)

    NSLayoutConstraint.activate([
      hostingController.view.topAnchor.constraint(equalTo: view.topAnchor),
      hostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      hostingController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      hostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
    ])
  }
}

struct HomeBottomSheetView: View {
  // TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/325
  // - Replace dummy view with the correct one in HomeBottomSheetView.
  var body: some View {
    Text("Dummy bottom sheet text")
  }
}

#Preview {
  HomeBottomSheetView()
}
