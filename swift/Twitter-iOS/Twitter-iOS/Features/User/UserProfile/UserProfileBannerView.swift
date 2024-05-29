import SwiftUI

struct UserProfileBannerView: View {

  private enum LayoutConstant {
    static let bannerImageWidth = UIScreen.main.bounds.width
    static let bannerImageCornerRadius = 0.0
  }

  @Binding public var scrollOffset: CGFloat
  @Binding public var titleOffset: CGFloat
  public var borderOffsetToSwitch: CGFloat

  var body: some View {
    GeometryReader { proxy -> AnyView in
      let minY = proxy.frame(in: .global).minY
      DispatchQueue.main.async {
        scrollOffset = minY
      }
      return AnyView(
        ZStack {
          Image("UserBanner")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(
              width: LayoutConstant.bannerImageWidth, height: minY > 0 ? 180 + minY : 180,
              alignment: .center
            )
            .cornerRadius(LayoutConstant.bannerImageCornerRadius)

          UserProfileBlurView()
            .opacity(blurViewOpacity)

          VStack(spacing: 5) {
            Text("userName")
              .fontWeight(.bold)
              .foregroundColor(.white)

            Text("150 posts")
              .foregroundColor(.white)
          }
          .offset(y: 120)
          .offset(y: titleOffset > 100 ? 0 : -currentTitleOffset)
          .opacity(titleOffset < 100 ? 1 : 0)
        }
        .clipped()
        .frame(height: minY > 0 ? 180 + minY : nil)
        .offset(y: minY > 0 ? -minY : -minY < borderOffsetToSwitch ? 0 : -minY - 80)
      )
    }
  }

  private var blurViewOpacity: Double {
    let progress = -(scrollOffset + borderOffsetToSwitch) / 150
    return Double(-scrollOffset > borderOffsetToSwitch ? progress : 0)
  }

  private var currentTitleOffset: CGFloat {
    let progress = 20 / titleOffset
    let offset = 60 * (progress > 0 && progress <= 1 ? progress : 1)
    return offset
  }
}

struct UserProfileBlurView: UIViewRepresentable {
  func makeUIView(context: Context) -> UIVisualEffectView {
    return UIVisualEffectView(effect: UIBlurEffect(style: .systemChromeMaterialDark))
  }

  func updateUIView(_ uiView: UIVisualEffectView, context: Context) {}
}

#Preview {
  UserProfileBannerView(
    scrollOffset: .constant(CGFloat(0)),
    titleOffset: .constant(CGFloat(0)),
    borderOffsetToSwitch: 80
  )
}
