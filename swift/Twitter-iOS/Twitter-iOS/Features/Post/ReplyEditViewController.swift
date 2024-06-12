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

  override func viewDidLoad() {
    super.viewDidLoad()
    setUpSubviews()
  }

  private func setUpSubviews() {
    view.addSubview(hostingController.view)
    view.backgroundColor = .systemBackground

    let layoutGuide = view.safeAreaLayoutGuide
    NSLayoutConstraint.activate([
      hostingController.view.topAnchor.constraint(equalTo: layoutGuide.topAnchor),
      hostingController.view.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor),
      hostingController.view.bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor),
      hostingController.view.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor),
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
  private let currentUser = injectCurrentUser()

  var body: some View {
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
        HStack(alignment: .top) {
          LeftSideContent()
          MainContent()
          Spacer()
        }
      }
    }
  }

  @ViewBuilder
  private func LeftSideContent() -> some View {
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
      // Change height dynamically later.
      .frame(height: 100)

      Image(uiImage: currentUser.icon)
        .resizable()
        .scaledToFit()
        .frame(width: LayoutConstant.iconSize, height: LayoutConstant.iconSize)
    }
  }

  @ViewBuilder
  private func MainContent() -> some View {
    VStack(alignment: .leading) {
      HStack {
        Text(originalPostModel.userName)
      }
      Text(originalPostModel.bodyText)

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
