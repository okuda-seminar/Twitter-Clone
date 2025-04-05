import Foundation

/// Dependency Injecter of Auth Service.
public func injectAuthService() -> AuthServiceProtocol {
  return AuthService.shared
}

/// Prototol for Auth Service.
public protocol AuthServiceProtocol {
  var isAuthenticated: Bool { get }
  var currentUser: UserAccountModel { get }

  func signUp(email: String, userName: String, displayName: String, password: String) async
}

extension Notification.Name {
  public static let authServiceDidChangeAuthenticationState = Notification.Name(
    "com.x-clone.authServiceDidChangeAuthenticationState")
}

/// Implmenting AuthServiceProtocol which should be injected when the app is running.
final class AuthService: AuthServiceProtocol {

  /// Singleton instance.
  public static let shared = AuthService(currentUser: AuthService.loadCurrentUser() ?? .fakeAccount)

  /// Key to store the current user acount info.
  public static let currentUserAccountUserDefaultsKey = "com.x-clone.authService.currentUserAccount"

  /// Current user info.
  public var currentUser: UserAccountModel

  /// Indicates if the app is authenticated.
  public var isAuthenticated: Bool {
    return !currentUser.isFakeAccount
  }

  // MARK: - Initialization

  public init(currentUser: UserAccountModel) {
    self.currentUser = currentUser
  }

  // MARK: - User Creation

  public func signUp(email: String, userName: String, displayName: String, password: String) async {
    // Construct the URL
    guard let url = URL(string: "http://localhost:80/api/users") else {
      return
    }

    let signUpRequest = SignUpRequest(
      displayName: displayName, userName: userName, password: password)
    let jsonEncoder = JSONEncoder()

    guard let jsonData = try? jsonEncoder.encode(signUpRequest) else {
      // TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/657 - Handle sign up error cases.
      return
    }

    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.httpBody = jsonData

    do {
      let (data, response) = try await URLSession.shared.data(for: request)
      if let httpResponse = response as? HTTPURLResponse,
        httpResponse.statusCode == 201,
        let newUser = user(from: data)
      {
        currentUser = newUser
        AuthService.saveCurrentUser(currentUser)
        NotificationCenter.default.post(name: .authServiceDidChangeAuthenticationState, object: nil)
      }
    } catch {
      // TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/657 - Handle sign up error cases.
    }
  }

  /// Decodes response data and returns UserAccountModel based on the response.
  private func user(from responseData: Data) -> UserAccountModel? {
    let decoder = JSONDecoder()
    guard
      let signUpResponse = try? decoder.decode(SignUpResponse.self, from: responseData),
      let userId = UUID(uuidString: signUpResponse.user.id)
    else {
      return nil
    }
    let user = UserAccountModel(
      id: userId,
      username: signUpResponse.user.userName,
      displayName: signUpResponse.user.displayName,
      isFakeAccount: false)
    return user
  }

  // MARK: - Persistence

  /// Save the current user info to the local storage.
  public static func saveCurrentUser(_ user: UserAccountModel) {
    UserDefaults.standard.set(
      try? JSONEncoder().encode(user), forKey: currentUserAccountUserDefaultsKey)
  }

  /// Load the current user info from the local storage.
  public static func loadCurrentUser() -> UserAccountModel? {
    guard let data = UserDefaults.standard.data(forKey: currentUserAccountUserDefaultsKey) else {
      return nil
    }
    return try? JSONDecoder().decode(UserAccountModel.self, from: data)
  }
}
