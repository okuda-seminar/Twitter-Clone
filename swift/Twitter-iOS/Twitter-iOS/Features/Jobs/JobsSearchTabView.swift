import SwiftUI

struct JobsSearchTabView: View {

  // MARK: - Public Props

  @Binding public var showSearchInputSheet: Bool

  // MARK: - Private Props

  @State private var searchQuery = ""

  private enum LayoutConstant {
    static let searchButtonHeight: CGFloat = 44.0
  }

  private enum LocalizedString {
    static let search = String(localized: "Search")
  }

  var body: some View {
    VStack {
      SearchButton()
    }
  }

  @ViewBuilder
  private func SearchButton() -> some View {
    Button(
      action: {
        var transaction = Transaction()
        transaction.disablesAnimations = true
        withTransaction(transaction) {
          showSearchInputSheet.toggle()
        }
      },
      label: {
        Spacer()
        Image(systemName: "magnifyingglass")
        Text(LocalizedString.search)
          .padding(.top)
          .padding(.bottom)
        Spacer()
      }
    )
    .foregroundStyle(Color(uiColor: .brandedLightGrayText))
    .background(Color(uiColor: .brandedLightGrayBackground))
    .frame(height: LayoutConstant.searchButtonHeight)
    .clipShape(RoundedRectangle(cornerRadius: LayoutConstant.searchButtonHeight / 2))
    .padding(.leading)
    .padding(.bottom)
    .padding(.trailing)
  }
}

#Preview {
  JobsSearchTabView(showSearchInputSheet: .constant(false))
}
