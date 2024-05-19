import SwiftUI

struct BannerView: View {
  @Environment(\.dismiss) private var dismiss
  @ObservedObject var dataSource: BannerViewDataSource

  public var headlineText: String

  private enum LayoutConstant {
    static let edgeCornerRadius = 16.0

    static let dismissalButtonHeight = 44.0
    static let dismissalButtonCornerRadius = 22.0
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
      .frame(height: LayoutConstant.dismissalButtonHeight)
      .clipShape(RoundedRectangle(cornerRadius: LayoutConstant.dismissalButtonCornerRadius))
      .padding(.leading)
      .padding(.bottom)
      .padding(.trailing)
    }
    .background(Color(uiColor: .branededLightBlue2))
    .clipShape(RoundedRectangle(cornerRadius: LayoutConstant.edgeCornerRadius))
    .overlay(
      RoundedRectangle(cornerRadius: LayoutConstant.edgeCornerRadius)
        .stroke(Color(uiColor: .branededLightBlue))
    )
    .padding()
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
  BannerView(dataSource: BannerViewDataSource(), headlineText: "koube_neko has been muted")
}
