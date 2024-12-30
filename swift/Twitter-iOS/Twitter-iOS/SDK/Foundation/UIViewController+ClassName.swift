import UIKit

extension UIViewController {
  var className: String {
    return String(describing: type(of: self))
  }
}
