import SwiftUI

struct NewPostTagEditView: View {

  private enum LayoutConstant {
    static let TagEditHeaderSpacerMinLength: CGFloat = 125.0
  }

  private enum LocalizedString {
    static let viewTitle = String(localized: "Tag people")
    static let tagEditDoneButtonTitle = String(localized: "Done")
    static let userSearchInputFieldTitle = String(localized: "Tag:")
  }

  @ObservedObject private(set) var viewObserver: NewPostEditViewObserver
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
      Spacer(minLength: LayoutConstant.TagEditHeaderSpacerMinLength)

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
    .padding(.horizontal)
  }

  @ViewBuilder
  private func TagCandidateUsersList() -> some View {
    // TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/441
    // - Create TagCandidateUsersList with Dummy Data in NewPostTagEditView.swift.
  }
}

#Preview {
  NewPostTagEditView(viewObserver: NewPostEditViewObserver())
}
