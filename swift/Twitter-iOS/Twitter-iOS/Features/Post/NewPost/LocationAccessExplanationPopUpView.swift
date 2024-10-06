import SwiftUI

struct LocationAccessExplanationPopUpView: View {

  private enum LayoutConstant {
    static let locationSettingsTransitionButtonHeight: CGFloat = 44.0
    static let locationSettingsTransitionButtonCornerRadius: CGFloat = 22.0
    static let alertTitleBottomPadding: CGFloat = 6.0
    static let mainVStackVericalPadding: CGFloat = 30.0
    static let mainVStackHorizontalPadding: CGFloat = 16.0
    static let roundRectangleForMainVStackCornerRadius: CGFloat = 25.0
    static let roundRectangleForMainVStackHorizontalPadding: CGFloat = 12.0
  }

  private enum LocalizedString {
    static let alertTitle = String(localized: "Precise location")
    // The backslashes (\) at the end of the lines are used to indicate line continuation.
    static let alertText = String(
      localized:
        """
        This lets X collect, store, and use your device's precise location, such as \
        GPS information, in order to improve your experience - for example, showing you \
        more local content, ads, and recommendations.
        """
    )
    static let locationSettingsTransitionButtonText = String(localized: "Next")
  }

  @ObservedObject private(set) var viewObserver: NewPostEditViewObserver

  var body: some View {
    VStack(alignment: .leading) {
      AlertTitle()
      AlertText()
      LocationSettingsTransitionButton()
    }
    .padding(.vertical, LayoutConstant.mainVStackVericalPadding)
    .padding(.horizontal, LayoutConstant.mainVStackHorizontalPadding)
    .background(.white)
    .clipShape(
      RoundedRectangle(cornerRadius: LayoutConstant.roundRectangleForMainVStackCornerRadius)
    )
    .padding(.horizontal, LayoutConstant.roundRectangleForMainVStackHorizontalPadding)
  }

  @ViewBuilder
  private func AlertTitle() -> some View {
    Text(LocalizedString.alertTitle)
      .font(.title2)
      .bold()
      .padding(.bottom, LayoutConstant.alertTitleBottomPadding)
  }

  @ViewBuilder
  private func AlertText() -> some View {
    Text(LocalizedString.alertText)
      .foregroundStyle(.gray)
      .padding(.bottom)
  }

  @ViewBuilder
  private func LocationSettingsTransitionButton() -> some View {
    Button {
      viewObserver.didTapLocationSettingsTransitionButtonCompletion?()
    } label: {
      Spacer()
      Text(LocalizedString.locationSettingsTransitionButtonText)
        .foregroundStyle(.white)
        .padding()
      Spacer()
    }
    .background(.black)
    .frame(height: LayoutConstant.locationSettingsTransitionButtonHeight)
    .clipShape(
      RoundedRectangle(cornerRadius: LayoutConstant.locationSettingsTransitionButtonCornerRadius))
  }
}

#Preview {
  LocationAccessExplanationPopUpView(viewObserver: NewPostEditViewObserver())
}
