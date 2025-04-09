import SwiftUI
import UIKit

public protocol DraftsViewControllerDelegate: AnyObject {
  func draftsViewController(_ controller: DraftsViewController, didSelectDraft draft: DraftModel)
}

public final class DraftsViewController: UIViewController {

  // MARK: - Public Props

  public weak var delegate: DraftsViewControllerDelegate?

  // MARK: - Private Props

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

    viewObserver.didSelectDraft = { [weak self] draft in
      self?.didSelectDraft(draft)
    }
    dataSource.savedDrafts = injectDraftService().drafts
  }

  private func didSelectDraft(_ draft: DraftModel) {
    injectDraftService().remove(draft: draft)
    delegate?.draftsViewController(self, didSelectDraft: draft)
    dismiss(animated: true)
  }
}
