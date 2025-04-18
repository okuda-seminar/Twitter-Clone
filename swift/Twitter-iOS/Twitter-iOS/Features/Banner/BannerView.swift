import SwiftUI

struct BannerView: View {
  @Environment(\.dismiss) private var dismiss
  @ObservedObject public var dataSource: BannerViewDataSource
  public var type: BannerType

  public enum BannerType {
    case TextOnly
    case TextAndButton
  }

  public var headlineText: String

  private enum LayoutConstant {
    static let edgeCornerRadius = 16.0
  }

  private enum LocalizedString {
    static let dismissalText = String(localized: "Undo")
  }

  var body: some View {
    VStack(alignment: .leading) {
      HStack {
        Image(systemName: "speaker")
          .foregroundStyle(Color(uiColor: .brandedBlue))
        Text(headlineText)
        Spacer()
      }
      .padding()

      if type != .TextOnly {
        DismissalButton()
      }
    }
    .background(Color(uiColor: .brandedLightBlue2))
    .clipShape(RoundedRectangle(cornerRadius: LayoutConstant.edgeCornerRadius))
    .overlay(
      RoundedRectangle(cornerRadius: LayoutConstant.edgeCornerRadius)
        .stroke(Color(uiColor: .brandedLightBlue))
    )
    .padding()
  }

  @ViewBuilder
  private func DismissalButton() -> some View {
    Button(
      action: {
        dataSource.isBeingDismissed = true
      },
      label: {
        Spacer()
        Text(LocalizedString.dismissalText)
          .underline()
          .foregroundStyle(.white)
          .padding()
        Spacer()
      }
    )
    .background(Color(uiColor: .brandedBlue))
    .frame(height: 44)
    .clipShape(RoundedRectangle(cornerRadius: 22))
    .padding(.leading)
    .padding(.bottom)
    .padding(.trailing)
  }
}

public final class BannerViewDataSource: ObservableObject {
  public var isBeingDismissed = false {
    didSet {
      NotificationCenter.default.post(name: .isBeingDismissedDidChange, object: nil)
    }
  }
}

#Preview {
  BannerView(
    dataSource: BannerViewDataSource(), type: .TextAndButton,
    headlineText: "koube_neko has been muted")
}
