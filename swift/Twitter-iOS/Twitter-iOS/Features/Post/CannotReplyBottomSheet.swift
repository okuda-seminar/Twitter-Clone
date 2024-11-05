import SwiftUI

struct CannotReplyBottomSheet: View {

  // MARK: - Private Props

  private enum LayoutConstant {
    static let headerBottomPadding: CGFloat = 5.0
    static let dismissalTextHeight: CGFloat = 40.0
    static let dismissalTextCornerRadius: CGFloat = 20.0
  }

  private enum LocalizedString {
    static let headerText = String(localized: "You can't reply ... yet")
    static let subheaderText = String(
      localized: """
        Communities are public, so you can read posts — but you must join to participate.
        """)
    static let dismissalText = String(localized: "Got it")
  }

  @Binding private(set) var isCannotReplyBottomSheetPresented: Bool

  // MARK: - View

  var body: some View {
    VStack(alignment: .leading) {
      Header()
      Subheader()
      DismissalText()
    }
    .padding()
  }

  @ViewBuilder
  private func Header() -> some View {
    Text(LocalizedString.headerText)
      .font(.title)
      .fontWeight(.heavy)
      .padding(.bottom, LayoutConstant.headerBottomPadding)
  }

  // TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/494
  // - Enable Display of Different Subheader in CannotReplyBottomSheet Based on Community Type.
  @ViewBuilder
  private func Subheader() -> some View {
    Text(LocalizedString.subheaderText)
      .font(.subheadline)
      .foregroundStyle(.gray)
  }

  @ViewBuilder
  private func DismissalText() -> some View {
    HStack {
      Spacer()

      Text(LocalizedString.dismissalText)
        .foregroundStyle(.white)
        .fontWeight(.medium)

      Spacer()
    }
    .frame(height: LayoutConstant.dismissalTextHeight)
    .background(.black)
    .clipShape(RoundedRectangle(cornerRadius: LayoutConstant.dismissalTextCornerRadius))
    .padding(.top)
    .onTapGesture {
      isCannotReplyBottomSheetPresented.toggle()
    }
  }
}

#Preview {
  CannotReplyBottomSheet(isCannotReplyBottomSheetPresented: .constant(true))
}
