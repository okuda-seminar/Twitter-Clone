import SwiftUI

struct JobsSearchInputSheetView: View {
  @Environment(\.dismiss) private var dismiss

  // MARK: - Private Props

  private enum LayoutConstant {
    static let searchBarImageLeadingPadding: CGFloat = 6.0
    static let searchBarHeight: CGFloat = 32.0
  }

  private enum LocalizedString {
    static let jobTitle = String(localized: "Job title")
    static let location = String(localized: "Location")
  }

  var body: some View {
    VStack {
      HStack(alignment: .top) {
        DismissalButton()
          .padding(.trailing)
        SearchBars()
      }
      Spacer()
    }
    .padding()
  }

  @ViewBuilder
  private func DismissalButton() -> some View {
    Button(
      action: {
        dismiss()
      },
      label: {
        Image(systemName: "arrow.left")
          .resizable()
          .scaledToFit()
          .frame(height: 28)
      }
    )
    .foregroundStyle(.primary)
    .frame(height: 44)
  }

  @ViewBuilder
  private func SearchBars() -> some View {
    VStack(alignment: .leading) {
      HStack {
        Image(systemName: "magnifyingglass")
          .padding(.leading, LayoutConstant.searchBarImageLeadingPadding)
        TextField(LocalizedString.jobTitle, text: .constant(""))
          .frame(height: LayoutConstant.searchBarHeight)
      }
      .background(Color(uiColor: .brandedLightGrayBackground))
      .frame(height: LayoutConstant.searchBarHeight)
      .clipShape(RoundedRectangle(cornerRadius: LayoutConstant.searchBarHeight / 2))

      HStack {
        Image(systemName: "map")
          .padding(.leading, LayoutConstant.searchBarImageLeadingPadding)
        TextField(LocalizedString.location, text: .constant(""))
          .frame(height: LayoutConstant.searchBarHeight)
      }
      .background(Color(uiColor: .brandedLightGrayBackground))
      .frame(height: LayoutConstant.searchBarHeight)
      .clipShape(RoundedRectangle(cornerRadius: LayoutConstant.searchBarHeight / 2))
    }
  }
}

#Preview {
  JobsSearchInputSheetView()
}
