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
    static let searchButtonText = String(localized: "Search jobs")
    static let defaultSearchQueryListTitle = String(localized: "Try searching for")
    static let softwareEngineerQuery = String(localized: "Software Engineer")
    static let productManagerQuery = String(localized: "Product Manager")
    static let designerQuery = String(localized: "Designer")
    static let marketingManagerQuery = String(localized: "Marketing Manager")
    static let accountExecutiveQuery = String(localized: "Account Executive")
    static let accountManagerQuery = String(localized: "Account Manager")
    static let projectManagerQuery = String(localized: "Project Manager")
    static let businessAnalystQuery = String(localized: "Business Analyst")
    static let customerSupportQuery = String(localized: "Customer Support")
    static let talentAcquisitionSpecialistQuery = String(localized: "Talent Acquisition Specialist")
  }

  private let defaultSearchQueries: [String] = [
    LocalizedString.softwareEngineerQuery,
    LocalizedString.productManagerQuery,
    LocalizedString.designerQuery,
    LocalizedString.marketingManagerQuery,
    LocalizedString.accountExecutiveQuery,
    LocalizedString.accountManagerQuery,
    LocalizedString.projectManagerQuery,
    LocalizedString.businessAnalystQuery,
    LocalizedString.customerSupportQuery,
    LocalizedString.talentAcquisitionSpecialistQuery,
  ]

  // MARK: View

  var body: some View {
    VStack {
      SearchButton()
      DefaultSearchQueryList()
    }
    .padding(.vertical)
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
        Text(LocalizedString.searchButtonText)
          .padding(.vertical)
        Spacer()
      }
    )
    .foregroundStyle(Color(uiColor: .brandedLightGrayText))
    .background(Color(uiColor: .brandedLightGrayBackground))
    .frame(height: LayoutConstant.searchButtonHeight)
    .clipShape(RoundedRectangle(cornerRadius: LayoutConstant.searchButtonHeight / 2))
    .padding(.horizontal)
    .padding(.bottom)
  }

  @ViewBuilder
  private func DefaultSearchQueryList() -> some View {
    VStack(alignment: .leading) {
      Text(LocalizedString.defaultSearchQueryListTitle)
        .foregroundStyle(.gray)
        .padding(.leading)

      ScrollView {
        VStack {
          ForEach(defaultSearchQueries.indices, id: \.self) { index in
            DefaultSearchQueryRow(defaultSearchQueries[index])
              .padding(.top, index == 0 ? 10 : 0.0)
              .onTapGesture {
                // TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/537
                // - Implement Job Search Results Page for Default Search Queries in JobsSearchTabView.
              }
          }
        }
        .background(Color(uiColor: .brandedLightGrayBackground))
      }
    }
  }

  @ViewBuilder
  private func DefaultSearchQueryRow(_ queryText: String) -> some View {
    VStack {
      HStack {
        Text(queryText)
        Spacer()
        Image(systemName: "arrow.up.left")
      }
      .padding(.horizontal)

      Divider()
        .padding(.leading)
    }
  }
}

#Preview {
  JobsSearchTabView(showSearchInputSheet: .constant(false))
}
