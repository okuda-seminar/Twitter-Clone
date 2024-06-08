import SwiftUI
import UIKit
import os

struct GIFImagePlayer: UIViewRepresentable {

  public let resourceName: String

  public init(resourceName: String) {
    self.resourceName = resourceName
  }

  func makeUIView(context: Context) -> some UIView {
    let uiView = GIFImageView(frame: .zero, resourceName: resourceName)
    uiView.startAnimating()
    return uiView
  }

  func updateUIView(_ uiView: UIViewType, context: Context) {}
}

class GIFImageView: UIImageView {
  public let resourceName: String

  private let logger = Logger()

  init(frame: CGRect, resourceName: String) {
    self.resourceName = resourceName
    super.init(frame: frame)
    setUpView()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func setUpView() {
    let url = Bundle.main.url(forResource: resourceName, withExtension: "gif")
    guard let url else {
      logger.error("GIF resource name is wrong.")
      return
    }
    let source = CGImageSourceCreateWithURL(url as CFURL, nil)
    guard let source else {
      logger.warning("Failed to get source from \(url)")
      return
    }
    let count = CGImageSourceGetCount(source)
    let images = (0..<count)
      .map { index in
        CGImageSourceCreateImageAtIndex(source, index, nil)!
      }
      .map(UIImage.init(cgImage:))
    animationImages = images
    contentMode = .scaleAspectFit
  }
}
