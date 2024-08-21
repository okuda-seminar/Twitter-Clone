import SwiftUI
import UIKit

class SelectedImageEditViewController: UIViewController {

  private let viewObserver = SelectedImageEditViewObserver()

  private lazy var hostingController: UIHostingController = {
    let controller = UIHostingController(
      rootView: SelectedImageEditView(viewObserver: viewObserver))
    controller.view.translatesAutoresizingMaskIntoConstraints = false
    addChild(controller)
    controller.didMove(toParent: self)
    return controller
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    setUpSubViews()
    setUpViewObserver()
  }

  private func setUpSubViews() {
    view.backgroundColor = .black

    view.addSubview(hostingController.view)

    let layoutGuide = view.safeAreaLayoutGuide

    NSLayoutConstraint.activate([
      hostingController.view.topAnchor.constraint(equalTo: layoutGuide.topAnchor),
      hostingController.view.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor),
      hostingController.view.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor),
      hostingController.view.bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor),
    ])
  }

  private func setUpViewObserver() {
    viewObserver.didTapImageEditCancelButtonCompletion = { [weak self] in
      self?.dismiss(animated: true)
    }
  }
}

struct SelectedImageEditView: View {

  private enum LocalizedString {
    static let titleText = String(localized: "Edit photo")
    static let cancelEditButtonText = String(localized: "Cancel")
    static let saveEditButtonText = String(localized: "Save")
  }

  @ObservedObject private(set) var viewObserver: SelectedImageEditViewObserver

  // TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/403
  // - Create Dummy Selected Image Edit View in SelectedImageEditViewController.swift.
  var body: some View {
    VStack {
      buttonsAndTitle()

      Spacer()
    }
    .background(.black)
  }

  @ViewBuilder
  private func buttonsAndTitle() -> some View {
    HStack {
      Button {
        viewObserver.didTapImageEditCancelButtonCompletion?()
      } label: {
        Text(LocalizedString.cancelEditButtonText)
          .foregroundStyle(.white)
      }

      Spacer()

      Text(LocalizedString.titleText)
        .font(.headline)
        .foregroundStyle(.white)

      Spacer()

      Button {

      } label: {
        Text(LocalizedString.saveEditButtonText)
          .foregroundStyle(.white)
      }
    }
    .padding()
  }
}

#Preview {
  SelectedImageEditViewController()
}
