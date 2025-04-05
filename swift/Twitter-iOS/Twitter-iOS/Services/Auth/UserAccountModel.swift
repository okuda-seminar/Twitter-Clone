import Foundation

// MARK: - User Account

/// Struct to store user account info.
public struct UserAccountModel: Codable {
  var id: UUID
  var username: String
  var displayName: String
  /// If the app is not authorized, then this becomes true.
  var isFakeAccount: Bool
}

extension UserAccountModel {
  /// Fallback account which shouldn't be used in the real app flow after signing in.
  public static let fakeAccount: UserAccountModel =
    .init(id: UUID(), username: "", displayName: "", isFakeAccount: true)
}

// MARK: - Sign Up

/// Struct to encode the sign up request.
public struct SignUpRequest: Codable {
  let displayName: String
  let userName: String
  let password: String

  enum CodingKeys: String, CodingKey {
    case displayName = "display_name"
    case userName = "username"
    case password
  }
}

/// Struct to decode the sign up response.
struct SignUpResponse: Codable {
  let token: String
  let user: SignUpUserResponse
}

/// User struct to decode the user object.
public struct SignUpUserResponse: Codable {
  let bio: String
  let createdAt: String
  let displayName: String
  let id: String
  let isPrivate: Bool
  let updatedAt: String
  let userName: String

  /// Custom keys to map the JSON keys to the struct properties
  enum CodingKeys: String, CodingKey {
    case bio
    case createdAt = "created_at"
    case displayName = "display_name"
    case id
    case isPrivate = "is_private"
    case updatedAt = "updated_at"
    case userName = "username"
  }
}
