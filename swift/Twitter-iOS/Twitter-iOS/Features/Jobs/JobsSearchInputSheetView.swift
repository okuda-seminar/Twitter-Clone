import SwiftUI

struct JobsSearchInputSheetView: View {
  @Environment(\.dismiss) private var dismiss

  private enum LayoutConstant {
    static let dismissalButtonIconHeight: CGFloat = 28.0
    static let dismissalButtonHeight: CGFloat = 44.0
  }

  var body: some View {
    Button(
      action: {
        dismiss()
      },
      label: {
        Image(systemName: "arrow.left")
          .resizable()
          .scaledToFit()
          .frame(height: LayoutConstant.dismissalButtonIconHeight)
      }
    )
    .foregroundStyle(.primary)
    .frame(height: LayoutConstant.dismissalButtonHeight)
  }
}

#Preview {
  JobsSearchInputSheetView()
}
