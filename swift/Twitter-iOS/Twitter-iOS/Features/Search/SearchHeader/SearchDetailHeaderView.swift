import SwiftUI

struct SearchDetailHeaderView: View {

  public weak var delegate: SearchDetailHeaderViewDelegate?

  public var searchQuery: String

  private enum LayoutConstant {
    static let imageSize = 24.0
  }

  @Environment(\.dismiss) private var dismiss

  var body: some View {
    HStack {
      Button(
        action: {
          dismiss()
        },
        label: {
          Image(systemName: "arrow.left")
            .resizable()
            .frame(width: LayoutConstant.imageSize, height: LayoutConstant.imageSize)
            .foregroundStyle(.black)
        }
      )
      .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 4))

      HStack {
        Spacer()
        Image(systemName: "magnifyingglass")
          .foregroundStyle(Color.primary)

        Text(searchQuery)
          .foregroundStyle(Color.primary)
          .padding(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0))
        Spacer()
      }
      .background(Color.gray.opacity(0.15))
      .clipShape(Capsule())
      .onTapGesture {
        self.delegate?.didTapSearchBar()
      }

      Button(
        action: {
        },
        label: {
          Image(systemName: "line.3.horizontal.decrease.circle")
            .resizable()
            .frame(width: LayoutConstant.imageSize, height: LayoutConstant.imageSize)
            .foregroundStyle(.black)
        }
      )
      .padding(EdgeInsets(top: 0, leading: 4, bottom: 0, trailing: 0))
    }
  }
}

protocol SearchDetailHeaderViewDelegate: AnyObject {
  func didTapBackButton()
  func didTapSearchBar()
  func didTapSearchFiltersEntryPoint()
}

#Preview{
  SearchDetailHeaderView(searchQuery: "Some search query")
}
