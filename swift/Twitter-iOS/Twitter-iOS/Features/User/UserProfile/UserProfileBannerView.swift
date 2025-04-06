import SwiftUI

struct UserProfileBannerView: View {

  // MARK: Public Props

  @Binding public var scrollOffset: CGFloat
  @Binding public var titleOffset: CGFloat
  public var borderOffsetToSwitch: CGFloat

  @ObservedObject var viewObserver: UserProfileViewObserver

  // MARK: Private Props

  private enum LayoutConstant {
    static let bannerImageWidth = UIScreen.main.bounds.width
    static let bannerImageCornerRadius = 0.0
    static let backgroundCircleSize: CGFloat = 30.0
    static let backgroundCircleOpacity: CGFloat = 0.5
  }

  private enum LocalizedString {
    static let turnOffReportsText = String(localized: "Turn off reports")
    static let viewTopicsText = String(localized: "View Topics")
    static let addOrRemoveListsText = String(localized: "Add/remove from Lists")
    static let viewListsText = String(localized: "View Lists")
    static let shareText = String(localized: "Share @userName")
    static let muteText = String(localized: "Mute @userName")
    static let blockText = String(localized: "Block @userName")
    static let reportText = String(localized: "Report @userName")
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

  // MARK: View

  var body: some View {
    GeometryReader { proxy -> AnyView in
      let minY = proxy.frame(in: .global).minY
      Task { @MainActor in
        scrollOffset = minY
      }
      return AnyView(
        ZStack {
          userProfileBannerView(minY: minY)
          UserProfileBlurView()
            .opacity(blurViewOpacity)

          // TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/329
          // - Adjust Layout for UserProfileButtonsView, Username, and Post Count in UserProfileBannerView.swift.
          userProfileButtonsAndTextView()
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

  @ViewBuilder
  private func userProfileBannerView(minY: CGFloat) -> some View {
    Image("UserBanner")
      .resizable()
      .aspectRatio(contentMode: .fill)
      .frame(
        width: LayoutConstant.bannerImageWidth, height: minY > 0 ? 180 + minY : 180,
        alignment: .center
      )
      .cornerRadius(LayoutConstant.bannerImageCornerRadius)
  }

  @ViewBuilder
  private func userProfileButtonsAndTextView() -> some View {
    VStack(spacing: 5) {
      HStack {
        Button {
          viewObserver.didTapBackButtonCompletion?()
        } label: {
          Image(systemName: "arrow.left")
            .background(
              Circle()
                .fill(Color.black)
                .opacity(LayoutConstant.backgroundCircleOpacity)
                .frame(
                  width: LayoutConstant.backgroundCircleSize,
                  height: LayoutConstant.backgroundCircleSize)
            )
            .foregroundColor(.white)
        }
        .padding(.leading)

        Spacer()

        Button {
          // TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/322
          // - Implement View Transition for Search Button in UserProfileBannerView.swift.
        } label: {
          Image(systemName: "magnifyingglass")
            .background(
              Circle()
                .fill(Color.black)
                .opacity(LayoutConstant.backgroundCircleOpacity)
                .frame(
                  width: LayoutConstant.backgroundCircleSize,
                  height: LayoutConstant.backgroundCircleSize)
            )
            .foregroundColor(.white)
        }

        userProfileCustomMenu()

      }
      .padding()

      Text("userName")
        .fontWeight(.bold)
        .foregroundColor(.white)

      Text("150 posts")
        .foregroundColor(.white)
    }
  }

  @ViewBuilder
  private func userProfileCustomMenu() -> some View {
    Menu {
      // TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/320
      // - Implement Appropriate Functionality for Each Menu Item in UserProfileBannerView.swift.
      Button {

      } label: {
        HStack {
          Text(LocalizedString.turnOffReportsText)
          Image(systemName: "square.slash")
        }
      }

      Button {

      } label: {
        HStack {
          Text(LocalizedString.viewTopicsText)
          Image(systemName: "text.bubble")
        }
      }

      Button {

      } label: {
        HStack {
          Text(LocalizedString.addOrRemoveListsText)
          Image(systemName: "note.text.badge.plus")
        }
      }

      Button {

      } label: {
        HStack {
          Text(LocalizedString.viewListsText)
          Image(systemName: "note.text")
        }
      }

      Button {

      } label: {
        HStack {
          Text(LocalizedString.shareText)
          Image(systemName: "tray.and.arrow.up")
        }
      }

      Button {

      } label: {
        HStack {
          Text(LocalizedString.muteText)
          Image(systemName: "speaker.slash")
        }
      }

      Button {

      } label: {
        HStack {
          Text(LocalizedString.blockText)
          Image(systemName: "slash.circle")
        }
      }

      Button {

      } label: {
        HStack {
          Text(LocalizedString.reportText)
          Image(systemName: "flag")
        }
      }

    } label: {
      Image(systemName: "ellipsis")
        .background(
          Circle()
            .fill(Color.black)
            .opacity(LayoutConstant.backgroundCircleOpacity)
            .frame(
              width: LayoutConstant.backgroundCircleSize,
              height: LayoutConstant.backgroundCircleSize)
        )
        .foregroundColor(.white)
    }
    .padding(.horizontal)
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
    borderOffsetToSwitch: 80, viewObserver: UserProfileViewObserver()
  )
}
