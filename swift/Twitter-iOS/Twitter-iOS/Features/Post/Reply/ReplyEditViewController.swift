import SwiftUI
import UIKit

class ReplyEditViewController: UIViewController {

  private lazy var headerView: ReplyHeaderView = {
    let view = ReplyHeaderView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.dismissalButton.addAction(
      .init { _ in
        self.dismiss(animated: false)
      }, for: .touchUpInside)
    return view
  }()

  private lazy var bodyView: ReplyBodyView = {
    let view = ReplyBodyView()
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()

  private let keyBoardToolBarView: ReplyKeyboardToolbarView = {
    let view = ReplyKeyboardToolbarView()
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    setUpSubviews()
  }

  private func setUpSubviews() {
    view.addSubview(headerView)
    view.addSubview(bodyView)
    view.addSubview(keyBoardToolBarView)
    view.backgroundColor = .systemBackground

    bodyView.inputTextView.becomeFirstResponder()

    let layoutGuide = view.safeAreaLayoutGuide
    let keyboardLayoutGuide = view.keyboardLayoutGuide
    NSLayoutConstraint.activate([
      headerView.topAnchor.constraint(equalTo: layoutGuide.topAnchor),
      headerView.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor),
      headerView.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor),

      bodyView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
      bodyView.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor),
      bodyView.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor),
      bodyView.bottomAnchor.constraint(equalTo: keyBoardToolBarView.topAnchor),

      keyBoardToolBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      keyBoardToolBarView.bottomAnchor.constraint(
        equalTo: keyboardLayoutGuide.topAnchor),
      keyBoardToolBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
    ])
  }
}

extension ReplyEditViewController: UITextViewDelegate {

}

//struct ReplyEditView: View {
//  public var originalPostModel: PostModel
//
//  private enum LayoutConstant {
//    static let iconSize: CGFloat = 48.0
//  }
//
//
//  @Environment(\.dismiss) private var dismiss
//  @State private var inputText = ""
//  @State private var showDismissalConfirmationSheet = false
//  private let currentUser = InjectCurrentUser()
//
//  var body: some View {
//    /// Need to refactor this code with UIKit for some reasons.
//    /// 1. becomeFirstResponder is not supported in SwiftUI natively.
//    /// 2. scrollView isn't respecing height adjustment and toolbar can overlap it.
//    /// 3. Need to wrpa this view with NavigationView unnecessary. Otherwise, the position of toolbar becomes wrong.
//    GeometryReader { geoProxy in
//      VStack {
//        Divider()
//        Spacer()
//      }
//      .padding()
//      .frame(height: geoProxy.size.height)
//      .sheet(isPresented: $showDismissalConfirmationSheet) {
//        DismissalConfirmationSheet()
//          .presentationDetents([.height(200), .medium])
//      }
//    }
//  }
//
//  @ViewBuilder
//  private func Content() -> some View {
//    ScrollView(.vertical) {
//      VStack {
//        OriginalPostContent()
//      }
//    }
//  }
//
//  @ViewBuilder
//  private func ReplyEditingContent() -> some View {
//    HStack(alignment: .top) {
//      Image(uiImage: currentUser.icon)
//        .resizable()
//        .scaledToFit()
//        .frame(width: LayoutConstant.iconSize, height: LayoutConstant.iconSize)
//
//      TextEditor(text: $inputText)
//        .overlay(alignment: .topLeading) {
//          if inputText.isEmpty {
//            Text(LocalizedString.inputPlaceholder)
//              .allowsHitTesting(false)
//              .foregroundStyle(Color(uiColor: .brandedLightGrayText))
//              .padding(8)
//          }
//        }
//    }
//  }
//
//  @ViewBuilder
//  private func DismissalConfirmationSheet() -> some View {
//    VStack(alignment: .leading) {
//      Button(
//        action: {
//          dismiss()
//        },
//        label: {
//          HStack {
//            Image(systemName: "trash")
//            Text(LocalizedString.deleteButtonText)
//            Spacer()
//          }
//        }
//      )
//      .buttonStyle(.plain)
//      .foregroundStyle(Color(uiColor: .systemRed))
//      .padding(.bottom)
//
//      Button(
//        action: {
//          // Need to save draft first.
//          dismiss()
//        },
//        label: {
//          HStack {
//            Image(systemName: "note.text")
//            Text(LocalizedString.saveDraftButtonText)
//            Spacer()
//          }
//        }
//      )
//      .foregroundStyle(Color(uiColor: .brandedLightGrayText))
//      .buttonStyle(.plain)
//      .padding(.bottom)
//
//      Button(
//        action: {
//          showDismissalConfirmationSheet.toggle()
//        },
//        label: {
//          HStack {
//            Spacer()
//            Text(LocalizedString.dismissalButtonText)
//              .underline()
//            Spacer()
//          }
//          .padding()
//          .overlay {
//            RoundedRectangle(cornerRadius: 24)
//              .stroke(Color(uiColor: .brandedLightGrayBackground), lineWidth: 1.5)
//          }
//        }
//      )
//      .foregroundStyle(.primary)
//      .buttonStyle(.plain)
//    }
//    .padding()
//  }
//}

//#Preview {
//  ReplyEditView(originalPostModel: createFakePostModel())
//}