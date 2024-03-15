//
//  Tweet.swift
//  Twitter-iOS
//
//  Created by 奥田遼 on 2024/03/10.
//

import SwiftUI

struct Tweet: Identifiable {
  let id: UUID
  let bodyText: String
  let userIcon: Image
  let userName: String
}
