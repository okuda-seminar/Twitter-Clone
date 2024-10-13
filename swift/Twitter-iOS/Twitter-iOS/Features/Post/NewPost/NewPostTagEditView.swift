import SwiftUI

struct NewPostTagEditView: View {

  private enum LayoutConstant {
    static let tagEditHeaderSpacerMinLength: CGFloat = 125.0
    static let userIconSize: CGFloat = 35.0
    static let nameAndUsernameSpacing: CGFloat = 0.1
  }

  private enum LocalizedString {
    static let viewTitle = String(localized: "Tag people")
    static let tagEditDoneButtonTitle = String(localized: "Done")
    static let userSearchInputFieldTitle = String(localized: "Tag:")
  }

  private enum TextFieldState {
    case empty
    case filled
  }

  private var currentTextFieldState: TextFieldState {
    switch userInputText {
    case "":
      return .empty
    default:
      return .filled
    }
  }

  @ObservedObject private(set) var viewObserver: NewPostEditViewObserver
  @ObservedObject private(set) var dataSource: NewPostEditDataSource
  @FocusState private var inputFieldIsFocused: Bool
  @State private var userInputText: String = ""

  var body: some View {
    VStack {
      TagEditHeader()
      UserSearchInputField()

      Divider()

      TagCandidateUsersList()

      Spacer()
    }
  }

  @ViewBuilder
  private func TagEditHeader() -> some View {
    HStack(alignment: .center) {
      // Setting minLength is to center the view title.
      Spacer(minLength: LayoutConstant.tagEditHeaderSpacerMinLength)

      Text(LocalizedString.viewTitle)
        .font(.title2)
        .bold()

      Spacer()
      Button {
        viewObserver.didTapTagEditDoneButtonCompletion?()
      } label: {
        Text(LocalizedString.tagEditDoneButtonTitle)
          .foregroundStyle(.gray)
      }
    }
    .padding()
  }

  @ViewBuilder
  private func UserSearchInputField() -> some View {
    HStack {
      Text(LocalizedString.userSearchInputFieldTitle)

      TextField(
        "",
        text: $userInputText
      )
      .focused($inputFieldIsFocused)
    }
    .onAppear {
      inputFieldIsFocused = true
    }
    .onChange(of: userInputText) {
      switch currentTextFieldState {
      case .empty:
        viewObserver.didEmptyTextFieldCompletion?()
      case .filled:
        viewObserver.didInputTextFieldCompletion?()
      }
    }
    .padding(.horizontal)
  }

  @ViewBuilder
  private func TagCandidateUsersList() -> some View {
    ScrollView(.vertical) {
      VStack {
        ForEach(dataSource.tagCandidateUsers) { candidate in
          TagCandidateUserCell(candidate)
        }
      }
    }
  }

  @ViewBuilder
  private func TagCandidateUserCell(_ tagCandidateUser: SearchedUserModel) -> some View {
    HStack(alignment: .center) {
      Image(uiImage: tagCandidateUser.icon ?? UIImage(systemName: "person.circle")!)  // Safe to force unwrap.
        .frame(width: LayoutConstant.userIconSize, height: LayoutConstant.userIconSize)

      VStack(alignment: .leading, spacing: LayoutConstant.nameAndUsernameSpacing) {
        Text(tagCandidateUser.name)

        Text(tagCandidateUser.userName)
          .foregroundStyle(.gray)
      }

      Spacer()
    }
    .padding(.horizontal)
  }
}

#Preview {
  NewPostTagEditView(
    viewObserver: NewPostEditViewObserver(), dataSource: createFakeNewPostEditDataSource())
}
