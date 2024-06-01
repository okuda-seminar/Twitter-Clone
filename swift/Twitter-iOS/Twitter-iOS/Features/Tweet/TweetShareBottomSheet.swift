import SwiftUI

struct TweetShareBottomSheet: View {
  @Environment(\.dismiss) private var dismiss
  @State private var isPresented = false

  private enum LocalizedString {
    static let title = String(localized: "Share post")
    static let headline = String(localized: "Send via Direct Message")
    static let copyLink = String(localized: "Copy Link")
    static let shareVia = String(localized: "Share via...")
    static let messages = String(localized: "Messages")
    static let gmail = String(localized: "Gmail")
    static let dismissalText = String(localized: "Cancel")
  }

  var body: some View {
    ZStack {
      Background()

      VStack {
        Spacer()
        Sheet()
      }
    }
  }

  @ViewBuilder
  private func Background() -> some View {
    Color.black
      .opacity(0.1)
      .ignoresSafeArea()
      .onTapGesture {
        dismiss()
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
        HStack {
          VStack {
            Image(systemName: "link")
            Text(LocalizedString.copyLink)
          }
          VStack {
            Image(systemName: "square.and.arrow.up")
            Text(LocalizedString.shareVia)
          }
          Spacer()
        }
        HStack {
          VStack {
            Image(systemName: "message")
            Text(LocalizedString.copyLink)
          }
          VStack {
            Image(systemName: "envelope.fill")
            Text(LocalizedString.gmail)
          }
          Spacer()
        }
        Button(
          action: {
            dismiss()
          },
          label: {
            Text(LocalizedString.dismissalText)
              .underline()
              .padding()
              .clipShape(RoundedRectangle(cornerRadius: 12.0))
          }
        )
        .buttonStyle(.plain)
        .foregroundStyle(.primary)
      }
      .padding(.leading)
    }
    .background(Color(uiColor: .systemBackground))
  }
}

#Preview {
  TweetShareBottomSheet()
}
