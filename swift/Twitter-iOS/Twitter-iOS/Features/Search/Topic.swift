//
//  Topic.swift
//  Twitter-iOS
//
//  Created by 奥田遼 on 2024/03/16.
//

import Foundation

func createFakeTopic() -> Topic {
  return Topic(id: UUID(), category: "Technology", name: "iMac", numOfPosts: 1413)
}

struct Topic: Identifiable {
  let id: UUID
  let category: String
  let name: String
  let numOfPosts: Int
}
