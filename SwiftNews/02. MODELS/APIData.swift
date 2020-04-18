//
//  APIData.swift
//  SwiftNews
//
//  Created by BES on 2020-02-13.
//  Copyright © 2020 BEstelrich. All rights reserved.
//

import Foundation

struct APIData: Codable {
  let data: ArticleData
}


struct ArticleData: Codable {
  let articles: [Child]
  
  enum CodingKeys: String, CodingKey {
    case articles = "children"
  }
}


struct Child: Codable {
  let details: ChildData
  
  enum CodingKeys: String, CodingKey {
    case details = "data"
  }
}


struct ChildData: Codable {
  let title: String
  let body: String
  let thumbnailLink: String?
  let thumbnailHeight: Int?
  let thumbnailWidth: Int?
  let author: String

  enum CodingKeys: String, CodingKey {
    case title
    case body            = "selftext"
    case thumbnailLink   = "thumbnail"
    case thumbnailHeight = "thumbnail_height"
    case thumbnailWidth  = "thumbnail_width"
    case author
  }

}
