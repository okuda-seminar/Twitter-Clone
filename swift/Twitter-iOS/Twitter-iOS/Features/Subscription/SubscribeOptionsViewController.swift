import SwiftUI
import UIKit

class SubscribeOptionsViewController: UIViewController {

  private enum LocalizedString {
    static let title = String(localized: "Subscribe")
  }

  private lazy var hostingController: UIHostingController = {
    let prices = injectSubscriptionService().fetchPrices()
    let controller = UIHostingController(rootView: SubscribeOptionsView(prices: prices))
    controller.view.translatesAutoresizingMaskIntoConstraints = false
    addChild(controller)
    controller.didMove(toParent: self)
    return controller
  }()

  // MARK: - View Lifecycle

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    setUpNavigation()
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    setUpSubviews()
  }

  // MARK: - Private API

  private func setUpNavigation() {
    navigationItem.title = LocalizedString.title
  }

  private func setUpSubviews() {
    view.backgroundColor = .systemBackground
    view.addSubview(hostingController.view)

    let layoutGuide = view.safeAreaLayoutGuide
    NSLayoutConstraint.activate([
      hostingController.view.topAnchor.constraint(equalTo: layoutGuide.topAnchor),
      hostingController.view.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor),
      hostingController.view.bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor),
      hostingController.view.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor),
    ])
  }
}

struct SubscribeOptionsView: View {

  public var prices: [SubscriptionPrice]

  private enum LayoutConstant {
    static let footerButtonHeight: CGFloat = 44.0
    static let footerButtonCornerRadius: CGFloat = 22.0
  }

  private enum LocalizedString {
    static let footerButtonPrefix = String(localized: "Starting at")
  }

  var body: some View {
    VStack {
      ScrollView(.vertical) {

      }
      Button(
        action: {

        },
        label: {
          Spacer()
          Text(LocalizedString.footerButtonPrefix + " \(prices[0].rawValue)")
            .underline()
            .foregroundStyle(.white)
            .padding()
          Spacer()
        }
      )
      .background(Color(.black))
      .frame(height: LayoutConstant.footerButtonHeight)
      .clipShape(RoundedRectangle(cornerRadius: LayoutConstant.footerButtonCornerRadius))
      .padding(.leading)
      .padding(.bottom)
      .padding(.trailing)
    }
  }
}

#Preview {
  SubscribeOptionsView(prices: injectSubscriptionService().fetchPrices())
}
