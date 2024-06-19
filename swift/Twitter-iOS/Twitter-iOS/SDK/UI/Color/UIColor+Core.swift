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
  static let brandedLightBlueBackground = createCustomUIColor(red: 231, green: 247, blue: 255)
  static let brandedWhiteBackGround = createCustomUIColor(red: 253, green: 253, blue: 253)

  // MARK: - General

  static let brandedBlue = createCustomUIColor(red: 28, green: 134, blue: 237)
  static let branededLightBlue = createCustomUIColor(red: 124, green: 184, blue: 225)
  static let branededLightBlue2 = createCustomUIColor(red: 227, green: 242, blue: 252)

  // MARK: - Text

  static let brandedLightGrayText = createCustomUIColor(red: 62, green: 72, blue: 80)
}
