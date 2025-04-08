import Foundation
import os

public func injectDraftService() -> DraftServiceProtocol {
  return DraftService.shared
}

public protocol DraftServiceProtocol {
  var drafts: [DraftModel] { get }

  func save(draft: DraftModel)
  func remove(draft: DraftModel)
}

final class DraftService: DraftServiceProtocol {

  // MARK: - Public Props

  public static let shared = DraftService()

  public var drafts: [DraftModel] = []

  // MARK: - Private Props

  private static let savedDraftsKey = "com.x-clone.draftService.savedDrafts"

  private let logger = os.Logger(subsystem: "com.x-clone", category: "draftService")

  // MARK: - Public APIs

  public init() {
    loadDraftModels(key: DraftService.savedDraftsKey)
  }

  /// Add a new PostModel to existing the draft models and  save the updated ones.
  public func save(draft: DraftModel) {
    loadDraftModels(key: Self.savedDraftsKey)
    drafts.append(draft)
    saveDraftModels(drafts, key: Self.savedDraftsKey)
  }

  public func remove(draft: DraftModel) {
    guard let index = drafts.firstIndex(of: draft) else { return }
    drafts.remove(at: index)
    saveDraftModels(drafts, key: Self.savedDraftsKey)
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
  private func loadDraftModels(key: String) {
    guard let data = UserDefaults.standard.data(forKey: key) else {
      return
    }

    let decoder = JSONDecoder()
    do {
      drafts = try decoder.decode([DraftModel].self, from: data)
    } catch {
      logger.error("Failed to decode PostModel array: \(error)")
      return
    }
  }
}
