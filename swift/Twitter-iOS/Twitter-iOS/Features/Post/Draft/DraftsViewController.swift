import SwiftUI
import UIKit

public final class DraftsViewController: UIViewController {

  private var dataSource = DraftsViewDataSource()
  private var viewObserver = DraftsViewObserver()

  private lazy var hostingController: UIHostingController = {
    let controller = UIHostingController(
      rootView: DraftsView(dataSource: dataSource, viewObserver: viewObserver))
    controller.view.translatesAutoresizingMaskIntoConstraints = false
    addChild(controller)
    controller.didMove(toParent: self)
    return controller
  }()

  public override func viewDidLoad() {
    super.viewDidLoad()

    guard let hostingView = hostingController.view else { return }
    view.backgroundColor = .systemBackground
    view.addSubview(hostingView)
    NSLayoutConstraint.activate([
      hostingView.topAnchor.constraint(equalTo: view.topAnchor),
      hostingView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      hostingView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      hostingView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
    ])

    viewObserver.didTapDismissalButton = { [weak self] in
      self?.dismiss(animated: true)
    }
    dataSource.savedDrafts = injectDraftService().drafts
  }
}
