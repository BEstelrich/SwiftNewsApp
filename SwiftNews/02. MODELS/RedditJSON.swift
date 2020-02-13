//
//  Article.swift
//  SwiftNews
//
//  Created by BES on 2020-02-13.
//  Copyright © 2020 BEstelrich. All rights reserved.
//

import Foundation

struct RedditJSON: Codable {
  let data: ArticleData
}


struct ArticleData: Codable {
  let children: [Child]
}


struct Child: Codable {
  let data: ChildData
}


struct ChildData: Codable {
  let title: String
  let selftext: String
  let thumbnail: String?
  let thumbnailHeight: Int?
  let thumbnailWidth: Int?

  enum CodingKeys: String, CodingKey {
    case title
    case selftext
    case thumbnail
    case thumbnailHeight = "thumbnail_height"
    case thumbnailWidth  = "thumbnail_width"
  }

}
