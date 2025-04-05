import Foundation
import os

public func injectDraftService() -> DraftServiceProtocol {
  return DraftService.shared
}

public protocol DraftServiceProtocol {
  func save(draft: DraftModel)
}

final class DraftService: DraftServiceProtocol {

  // MARK: - Public Props

  public static let shared = DraftService()

  // MARK: - Private Props

  private static let draftKey = "com.x-clone.postService.draftKey"

  private let logger = os.Logger(subsystem: "com.x-clone", category: "draftService")

  // MARK: - Public APIs

  /// Add a new PostModel to existing the draft models and  save the updated ones.
  public func save(draft: DraftModel) {
    var draftModels = loadDraftModels(key: Self.draftKey)
    draftModels.append(draft)
    print(draftModels)
    saveDraftModels(draftModels, key: Self.draftKey)
  }

  /// Save PostModel array to UserDefaults (as before)
  private func saveDraftModels(_ draftModels: [DraftModel], key: String) {
    let encoder = JSONEncoder()
    do {
      let data = try encoder.encode(draftModels)
      UserDefaults.standard.set(data, forKey: key)
    } catch {
      logger.error("Failed to encode PostModel array: \(error)")
    }
  }

  /// Load PostModel array from UserDefaults (as before)
  private func loadDraftModels(key: String) -> [DraftModel] {
    guard let data = UserDefaults.standard.data(forKey: key) else {
      return []
    }

    let decoder = JSONDecoder()
    do {
      let draftModels = try decoder.decode([DraftModel].self, from: data)
      return draftModels
    } catch {
      logger.error("Failed to decode PostModel array: \(error)")
      return []
    }
  }
}
