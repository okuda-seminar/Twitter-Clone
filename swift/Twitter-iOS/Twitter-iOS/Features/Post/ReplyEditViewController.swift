import SwiftUI
import UIKit

class ReplyEditViewController: UIViewController {
  private lazy var hostingController: UIHostingController = {
    let controller = UIHostingController(
      rootView: ReplyEditView(originalPostModel: createFakePostModel()))
    controller.view.translatesAutoresizingMaskIntoConstraints = false
    addChild(controller)
    controller.didMove(toParent: self)
    return controller
  }()

  private lazy var keyboardToolBarViewController: KeyboardToolbarViewController = {
    let viewController = KeyboardToolbarViewController()
    viewController.view.translatesAutoresizingMaskIntoConstraints = false
    addChild(viewController)
    viewController.didMove(toParent: self)
    return viewController
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    setUpSubviews()
  }

  private func setUpSubviews() {
    view.addSubview(hostingController.view)
    view.addSubview(keyboardToolBarViewController.view)
    view.backgroundColor = .systemBackground

    let layoutGuide = view.safeAreaLayoutGuide
    let keyboardLayoutGuide = view.keyboardLayoutGuide
    NSLayoutConstraint.activate([
      hostingController.view.topAnchor.constraint(equalTo: layoutGuide.topAnchor),
      hostingController.view.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor),
      hostingController.view.bottomAnchor.constraint(
        equalTo: keyboardToolBarViewController.view.topAnchor, constant: -5),
      hostingController.view.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor),

      keyboardToolBarViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      keyboardToolBarViewController.view.bottomAnchor.constraint(
        equalTo: keyboardLayoutGuide.topAnchor),
      keyboardToolBarViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
    ])
  }
}

struct ReplyEditView: View {
  public var originalPostModel: PostModel

  private enum LayoutConstant {
    static let iconSize: CGFloat = 48.0
  }

  private enum LocalizedString {
    static let dismissalButtonText = String(localized: "Cancel")
    static let postButtonText = String(localized: "Post")
    static let inputPlaceholder = String(localized: "Post your reply")

    static let deleteButtonText = String(localized: "Delete")
    static let saveDraftButtonText = String(localized: "Save draft")

  }

  @Environment(\.dismiss) private var dismiss
  @State private var inputText = ""
  @State private var showDismissalConfirmationSheet = false
  private let currentUser = InjectCurrentUser()

  var body: some View {
    /// Need to refactor this code with UIKit for some reasons.
    /// 1. becomeFirstResponder is not supported in SwiftUI natively.
    /// 2. scrollView isn't respecing height adjustment and toolbar can overlap it.
    /// 3. Need to wrpa this view with NavigationView unnecessary. Otherwise, the position of toolbar becomes wrong.
    NavigationView {
      VStack {
        Header()
        Divider()
        Content()
      }
      .padding()
      .sheet(isPresented: $showDismissalConfirmationSheet) {
        DismissalConfirmationSheet()
          .presentationDetents([.height(200), .medium])
      }
    }
  }

  @ViewBuilder
  private func Header() -> some View {
    HStack {
      Button(
        action: {
          if inputText.isEmpty {
            dismiss()
          } else {
            showDismissalConfirmationSheet.toggle()
          }
        },
        label: {
          Text(LocalizedString.dismissalButtonText)
            .underline()
        }
      )
      .foregroundStyle(.primary)
      .buttonStyle(.plain)

      Spacer()

      Button(
        action: {
        },
        label: {
          Text(LocalizedString.postButtonText)
            .underline()
            .padding(EdgeInsets(top: 8, leading: 24, bottom: 8, trailing: 24))
            .foregroundStyle(Color.white)
            .background(Color(uiColor: .brandedBlue))
            .clipShape(Capsule())
        }
      )
      .buttonStyle(.plain)
    }
  }

  @ViewBuilder
  private func Content() -> some View {
    ScrollView(.vertical) {
      VStack {
        OriginalPostContent()
        ReplyEditingContent()
      }
    }
  }

  @ViewBuilder
  private func OriginalPostContent() -> some View {
    HStack(alignment: .top) {
      VStack {
        originalPostModel.userIcon
          .resizable()
          .scaledToFit()
          .frame(width: LayoutConstant.iconSize, height: LayoutConstant.iconSize)

        HStack {
          // Need to place dummy Text to draw vertical Divider.
          Text("")
          Divider()
            .background(.gray)
          Text("")
        }
      }
      VStack(alignment: .leading) {
        HStack {
          Text(originalPostModel.userName)
          Spacer()
        }
        Text(originalPostModel.bodyText)
      }
    }
  }

  @ViewBuilder
  private func ReplyEditingContent() -> some View {
    HStack(alignment: .top) {
      Image(uiImage: currentUser.icon)
        .resizable()
        .scaledToFit()
        .frame(width: LayoutConstant.iconSize, height: LayoutConstant.iconSize)

      TextEditor(text: $inputText)
        .overlay(alignment: .topLeading) {
          if inputText.isEmpty {
            Text(LocalizedString.inputPlaceholder)
              .allowsHitTesting(false)
              .foregroundStyle(Color(uiColor: .brandedLightGrayText))
              .padding(8)
          }
        }
    }
  }

  @ViewBuilder
  private func DismissalConfirmationSheet() -> some View {
    VStack(alignment: .leading) {
      Button(
        action: {
          dismiss()
        },
        label: {
          HStack {
            Image(systemName: "trash")
            Text(LocalizedString.deleteButtonText)
            Spacer()
          }
        }
      )
      .buttonStyle(.plain)
      .foregroundStyle(Color(uiColor: .systemRed))
      .padding(.bottom)

      Button(
        action: {
          // Need to save draft first.
          dismiss()
        },
        label: {
          HStack {
            Image(systemName: "note.text")
            Text(LocalizedString.saveDraftButtonText)
            Spacer()
          }
        }
      )
      .foregroundStyle(Color(uiColor: .brandedLightGrayText))
      .buttonStyle(.plain)
      .padding(.bottom)

      Button(
        action: {
          showDismissalConfirmationSheet.toggle()
        },
        label: {
          HStack {
            Spacer()
            Text(LocalizedString.dismissalButtonText)
              .underline()
            Spacer()
          }
          .padding()
          .overlay {
            RoundedRectangle(cornerRadius: 24)
              .stroke(Color(uiColor: .brandedLightGrayBackground), lineWidth: 1.5)
          }
        }
      )
      .foregroundStyle(.primary)
      .buttonStyle(.plain)
    }
    .padding()
  }
}

#Preview {
  ReplyEditView(originalPostModel: createFakePostModel())
}
