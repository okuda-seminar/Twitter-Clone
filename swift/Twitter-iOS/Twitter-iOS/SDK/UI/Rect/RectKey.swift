import SwiftUI

struct RectKey: PreferenceKey {
  static var defaultValue: CGRect = .zero
  static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
    value = nextValue()
  }
}

extension View {
  @ViewBuilder
  func rect(completion: @escaping (CGRect) -> Void) -> some View {
    // Need to handle below in the future.
    // https://stackoverflow.com/questions/64941607/swiftui-warning-bound-preference-tried-to-update-multiple-times-per-frame
    self.overlay {
      GeometryReader { reader in
        let rect = reader.frame(in: .scrollView(axis: .horizontal))
        Color.clear
          .preference(key: RectKey.self, value: rect)
          .onPreferenceChange(RectKey.self, perform: completion)
      }
    }
  }
}
