import SwiftUI

struct SearchHeaderView: View {

  public weak var delegate: SearchHeaderViewDelegate?

  private enum LayoutConstant {
    static let imageSize = 28.0
  }

  var body: some View {
    HStack {
      Button(
        action: {
          delegate?.didTapProfileIconButton()
        },
        label: {
          Image(systemName: "person.circle.fill")
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

        Text("Search")
          .foregroundStyle(Color.primary)
          .padding(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0))
        Spacer()
      }
      .background(Color.gray.opacity(0.15))
      .clipShape(Capsule())
      .onTapGesture {
        delegate?.didTapSearchBar()
      }

      Button(
        action: {
          delegate?.didTapSettingsEntryPointButton()
        },
        label: {
          Image(systemName: "gear")
            .resizable()
            .frame(width: LayoutConstant.imageSize, height: LayoutConstant.imageSize)
            .foregroundStyle(.black)
        }
      )
      .padding(EdgeInsets(top: 0, leading: 4, bottom: 0, trailing: 0))
    }
  }
}

protocol SearchHeaderViewDelegate: AnyObject {
  func didTapProfileIconButton()
  func didTapSearchBar()
  func didTapSettingsEntryPointButton()
}

#Preview{
  SearchHeaderView()
}
