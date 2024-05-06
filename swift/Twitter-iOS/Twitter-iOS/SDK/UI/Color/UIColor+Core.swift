import UIKit

private let rgbScaler = 255.0

private func createCustomUIColor(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat = 1.0)
  -> UIColor
{
  return UIColor.init(
    red: red / rgbScaler, green: green / rgbScaler, blue: blue / rgbScaler, alpha: alpha)
}

extension UIColor {
  // MARK: - Background
  static let brandedLightGrayBackground = createCustomUIColor(red: 236, green: 240, blue: 241)

  // MARK: - General
  static let brandedBlue = createCustomUIColor(red: 28, green: 134, blue: 237)
  static let branededLightBlue = createCustomUIColor(red: 124, green: 184, blue: 225)

  // MARK: - Text
  static let brandedLightGrayText = createCustomUIColor(red: 62, green: 72, blue: 80)
}
