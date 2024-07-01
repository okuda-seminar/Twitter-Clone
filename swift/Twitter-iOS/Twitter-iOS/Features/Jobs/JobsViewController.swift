import SwiftUI
import UIKit

class JobsViewController: UIViewController {

  // MARK: - Private Props

  private enum LocalizedString {
    static let navigationBarTitle = String(localized: "Jobs")
  }

  private lazy var hostingController: UIHostingController = {
    let controller = UIHostingController(rootView: JobsView())
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
    view.backgroundColor = .systemBackground
    navigationItem.title = LocalizedString.navigationBarTitle
  }

  private func setUpSubviews() {
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

struct JobsView: View {

  @State private var activeTabModel: JobsTabModel.Tab = .search
  @State private var tabToScroll: JobsTabModel.Tab?

  private var tabModels: [JobsTabModel] = [
    .init(id: .search),
    .init(id: .saved),
  ]

  var body: some View {
    VStack(spacing: 0) {
      TabBar()
      Tabs()
      Spacer()
    }
  }

  @ViewBuilder
  private func TabBar() -> some View {
    HStack {
      ForEach(tabModels) { tabModel in
        Spacer()
        Button(
          action: {
            withAnimation {
              activeTabModel = tabModel.id
              tabToScroll = tabModel.id
            }
          },
          label: {
            Text(tabModel.id.rawValue)
              .foregroundStyle(activeTabModel == tabModel.id ? Color.primary : .gray)
          }
        )
        .buttonStyle(.plain)
        Spacer()
      }
    }
    .padding(.top)
    .padding(.bottom)
    .overlay(alignment: .bottom) {
      ZStack {
        Divider()
      }
    }
  }

  @ViewBuilder
  private func Tabs() -> some View {
    ScrollView(.horizontal) {
      LazyHStack(spacing: 0) {
        ForEach(tabModels) { tabModel in
          switch tabModel.id {
          case .search:
            Text("Duumy")
              .frame(width: UIScreen.main.bounds.width)
          case .saved:
            Text("No saved jobs")
              .frame(width: UIScreen.main.bounds.width)
          }
        }
      }
      .scrollTargetLayout()
    }
    .scrollIndicators(.hidden)
    .scrollTargetBehavior(.paging)
    .scrollPosition(id: $tabToScroll)
    .onChange(of: tabToScroll) { _, newValue in
      if let newValue {
        withAnimation {
          tabToScroll = newValue
          activeTabModel = newValue
        }
      }
    }
  }
}

#Preview {
  JobsView()
}
