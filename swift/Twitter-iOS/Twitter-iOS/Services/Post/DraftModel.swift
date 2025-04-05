import Foundation

public struct DraftModel: Identifiable, Codable {
  /// The identifier for the Draft (conforms to Identifiable)
  public let id: UUID

  /// The text of the Draft
  public var text: String

  /// Initialize the Draft struct
  public init(text: String) {
    self.id = UUID()
    self.text = text
  }
}
