import SwiftUI

struct LocationPermissionAlertPopUpView: View {

  private enum LayoutConstant {
    static let locationSettingsTransitionButtonHeight: CGFloat = 44.0
    static let locationSettingsTransitionButtonCornerRadius: CGFloat = 22.0
    static let alertTitleBottomPadding: CGFloat = 6.0
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
  var body: some View {
    VStack(alignment: .leading) {
      Text(LocalizedString.alertTitle)
        .font(.title2)
        .bold()
        .padding(.bottom, LayoutConstant.alertTitleBottomPadding)

      Text(LocalizedString.alertText)
        .foregroundStyle(.gray)
        .padding(.bottom)

      Button {

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
    .padding()
  }
}

#Preview {
  LocationPermissionAlertPopUpView()
}
