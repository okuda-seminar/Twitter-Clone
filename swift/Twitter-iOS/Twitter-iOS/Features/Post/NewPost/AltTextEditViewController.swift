import SwiftUI
import UIKit

class AltTextEditViewController: UIViewController {

  // TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/416
  // - Fix Memory Leaks in AltTextEditViewController.swift.

  private enum LocalizedString {
    static let titleText = String(localized: "Write alt text")
    static let dismissalButtonText = String(localized: "Cancel")
    static let saveButtonText = String(localized: "Save")
    static let helpButtonText = String(localized: "What's an image description?")
  }

  private enum LayoutConstant {
    static let headlineFontSize: CGFloat = 20.0
    static let buttonsAndTitleStackViewTopPadding: CGFloat = 10.0
    static let scrollViewTopPadding: CGFloat = 10.0
    static let helpButtonAndCountStackViewTopPadding: CGFloat = 10.0
    static let leadingPadding: CGFloat = 15.0
    static let trailingPadding: CGFloat = -15.0
  }

  @ObservedObject private var dataSource: NewPostEditDataSource
  private let selectedImageIndex: Int

  init(selectedImageIndex: Int, dataSource: NewPostEditDataSource) {
    self.selectedImageIndex = selectedImageIndex
    self.dataSource = dataSource
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private let viewTitle: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = LocalizedString.titleText
    label.font = UIFont.systemFont(ofSize: LayoutConstant.headlineFontSize, weight: .heavy)
    label.textColor = .white
    return label
  }()

  private let dismissalButton: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setTitle(LocalizedString.dismissalButtonText, for: .normal)
    return button
  }()

  private let saveButton: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setTitle(LocalizedString.saveButtonText, for: .normal)
    return button
  }()

  private lazy var hostingController: UIHostingController = {
    let controller = UIHostingController(
      rootView: AltTextEditSheetView(selectedImageIndex: selectedImageIndex, dataSource: dataSource)
    )
    controller.view.translatesAutoresizingMaskIntoConstraints = false
    addChild(controller)
    controller.didMove(toParent: self)
    return controller
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    setUpSubViews()
  }

  private func setUpSubViews() {
    view.backgroundColor = .black

    let buttonsAndTitleStackView = UIStackView(arrangedSubviews: [
      dismissalButton, viewTitle, saveButton,
    ])
    buttonsAndTitleStackView.translatesAutoresizingMaskIntoConstraints = false
    buttonsAndTitleStackView.axis = .horizontal
    buttonsAndTitleStackView.distribution = .equalSpacing

    let scrollView = UIScrollView()
    scrollView.translatesAutoresizingMaskIntoConstraints = false
    hostingController.view.backgroundColor = .black
    scrollView.addSubview(hostingController.view)

    view.addSubview(buttonsAndTitleStackView)
    view.addSubview(scrollView)

    dismissalButton.addAction(
      .init { _ in
        self.dismiss(animated: true)
      }, for: .touchUpInside)

    let layoutGuide = view.safeAreaLayoutGuide
    let keyboardLayoutGuide = view.keyboardLayoutGuide
    let scrollViewFrameLayoutGuide = scrollView.frameLayoutGuide

    NSLayoutConstraint.activate([
      buttonsAndTitleStackView.topAnchor.constraint(
        equalTo: layoutGuide.topAnchor, constant: LayoutConstant.buttonsAndTitleStackViewTopPadding),
      buttonsAndTitleStackView.leadingAnchor.constraint(
        equalTo: layoutGuide.leadingAnchor, constant: LayoutConstant.leadingPadding),
      buttonsAndTitleStackView.trailingAnchor.constraint(
        equalTo: layoutGuide.trailingAnchor, constant: LayoutConstant.trailingPadding),

      scrollViewFrameLayoutGuide.topAnchor.constraint(
        equalTo: buttonsAndTitleStackView.bottomAnchor,
        constant: LayoutConstant.scrollViewTopPadding),
      scrollViewFrameLayoutGuide.leadingAnchor.constraint(
        equalTo: buttonsAndTitleStackView.leadingAnchor),
      scrollViewFrameLayoutGuide.trailingAnchor.constraint(
        equalTo: buttonsAndTitleStackView.trailingAnchor),
      scrollViewFrameLayoutGuide.bottomAnchor.constraint(equalTo: keyboardLayoutGuide.topAnchor),

      hostingController.view.topAnchor.constraint(equalTo: scrollViewFrameLayoutGuide.topAnchor),
      hostingController.view.leadingAnchor.constraint(
        equalTo: scrollViewFrameLayoutGuide.leadingAnchor),
      hostingController.view.trailingAnchor.constraint(
        equalTo: scrollViewFrameLayoutGuide.trailingAnchor),
      hostingController.view.bottomAnchor.constraint(
        equalTo: scrollViewFrameLayoutGuide.bottomAnchor),
    ])
  }
}

struct AltTextEditSheetView: View {

  init(selectedImageIndex: Int, dataSource: NewPostEditDataSource) {
    self.selectedImageIndex = selectedImageIndex
    self.dataSource = dataSource
  }

  private enum LocalizedString {
    static let cancelEditButtonText = String(localized: "Cancel")
    static let sheetViewTitle = String("Write alt text")
    static let doneEditButtonText = String(localized: "Done")
    static let textFieldPlaceHolder = String(localized: "Image description")
    static let helpButtonText = String(localized: "What's an image description?")
  }

  private enum LayoutConstant {
    static let selectedImageHeight: CGFloat = 300.0
  }

  @ObservedObject private(set) var dataSource: NewPostEditDataSource
  @FocusState private(set) var isFocused: Bool

  private let selectedImageIndex: Int
  private let maxCharCounts: Int = 1000

  var body: some View {
    VStack {
      VStack {
        Image(uiImage: dataSource.selectedImages[selectedImageIndex])
          .resizable()
          .frame(
            height: LayoutConstant.selectedImageHeight
          )
      }

      TextField(
        "",
        text: $dataSource.altTexts[selectedImageIndex],
        prompt: Text(LocalizedString.textFieldPlaceHolder).foregroundStyle(.gray),
        axis: .vertical
      )
      .focused($isFocused)
      .foregroundStyle(.white)
      .onChange(of: dataSource.altTexts[selectedImageIndex]) {
        guard dataSource.altTexts[selectedImageIndex].count <= maxCharCounts else {
          dataSource.altTexts[selectedImageIndex] = String(
            dataSource.altTexts[selectedImageIndex].prefix(maxCharCounts))
          return
        }
      }

      HStack {
        Button {
          // TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/414
          // - Connect Help Button to "help.x.com" in AltTextEditViewController.swift.
        } label: {
          Text(LocalizedString.helpButtonText)
        }

        Spacer()

        Text("\(dataSource.altTexts[selectedImageIndex].count)/\(maxCharCounts)")
          .foregroundStyle(.gray)
      }

      Spacer()
    }
    .background(.black)
    .onAppear {
      isFocused = true
    }
  }
}

#Preview {
  AltTextEditViewController(selectedImageIndex: 0, dataSource: createFakeNewPostEditDataSource())
}
