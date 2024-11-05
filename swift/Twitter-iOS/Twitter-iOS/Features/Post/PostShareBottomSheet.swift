import SwiftUI

// TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/495
// - Refactor and Polish UI of PostShareBottomSheet.
struct PostShareBottomSheet: View {

  // MARK: - Public Props

  @Binding public var showShareSheet: Bool

  // MARK: - Private Props

  @Binding private(set) var isPostShareBottomSheetPresented: Bool

  private enum LocalizedString {
    static let title = String(localized: "Share post")
    static let headline = String(localized: "Send via Direct Message")
    static let copyLink = String(localized: "Copy Link")
    static let shareVia = String(localized: "Share via...")
    static let messages = String(localized: "Messages")
    static let gmail = String(localized: "Gmail")
    static let dismissalText = String(localized: "Cancel")
  }

  // MARK: - View

  var body: some View {
    VStack {
      Spacer()
      Sheet()
      Spacer()
    }
  }

  @ViewBuilder
  private func Sheet() -> some View {
    VStack {
      HStack {
        Spacer()
        Text(LocalizedString.title)
        Spacer()
      }
      .padding()

      VStack {
        HStack {
          Image(systemName: "envelope")
          Text(LocalizedString.headline)
          Spacer()
        }
        .padding(.bottom)

        HStack(alignment: .bottom) {
          Button {
            UIPasteboard.general.string = "Copied Deep Link"
            isPostShareBottomSheetPresented.toggle()
            let bannerController = BannerController(
              message: String(localized: "Copied to clipboard"), bannerType: .TextOnly)
            bannerController.show(on: AppRootViewController.sharedInstance)
          } label: {
            VStack {
              Image(systemName: "link")
              Text(LocalizedString.copyLink)
            }
          }
          .buttonStyle(.plain)

          Button(
            action: {
              isPostShareBottomSheetPresented.toggle()
              showShareSheet = true
            },
            label: {
              VStack {
                Image(systemName: "square.and.arrow.up")
                Text(LocalizedString.shareVia)
              }
            }
          )
          .buttonStyle(.plain)
          .foregroundStyle(.primary)

          VStack {
            Image(systemName: "message")
            Text(LocalizedString.messages)
          }
          VStack {
            Image(systemName: "envelope.fill")
            Text(LocalizedString.gmail)
          }
          Spacer()
        }

        Button(
          action: {
            isPostShareBottomSheetPresented.toggle()
          },
          label: {
            HStack {
              Spacer()
              Text(LocalizedString.dismissalText)
                .underline()
                .foregroundStyle(.primary)
              Spacer()
            }
            .padding()
          }
        )
        .buttonStyle(.plain)
        .overlay(
          RoundedRectangle(cornerRadius: 24)
            .stroke(Color(uiColor: .brandedLightGrayBackground), lineWidth: 2)
        )
      }
      .padding(.leading)
      .padding(.trailing)
    }
    .onAppear {
      showShareSheet = false
    }
    .background(Color(uiColor: .systemBackground))
  }
}

#Preview {
  PostShareBottomSheet(
    showShareSheet: .constant(false), isPostShareBottomSheetPresented: .constant(true))
}
