//
//  TweetModel.swift
//  Twitter-iOS
//

import SwiftUI

struct TweetModel: Identifiable {
  let id: UUID
  let bodyText: String
  let userIcon: Image
  let userName: String
}
