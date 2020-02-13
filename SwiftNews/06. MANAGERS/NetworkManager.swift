//
//  NetworkManager.swift
//  SwiftNews
//
//  Created by BES on 2020-02-13.
//  Copyright © 2020 BEstelrich. All rights reserved.
//

import UIKit

class NetworkManager {
  
  static let shared   = NetworkManager()
  private let baseURL = "https://www.reddit.com/r/swift/.json"
  let cache           = NSCache<NSString, UIImage>()
  
  
  private init() {}
  
  
  func getArticles(completed: @escaping (Result<APIData, AppError>) -> Void) {
    guard let url = URL(string: baseURL) else {
      completed(.failure(.invalidURL))
      return
    }
    
    let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
      guard error == nil else {
        completed(.failure(.unableToComplete))
        return
      }
      
      guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
        completed(.failure(.unableToComplete))
        return
      }
      
      guard let data = data else {
        completed(.failure(.invalidData))
        return
      }
      
      do {
        let decoder  = JSONDecoder()
        let articles = try decoder.decode(APIData.self, from: data)
        completed(.success(articles))
      } catch {
        completed(.failure(.invalidData))
      }
    }
    task.resume()
  }
  
  
  func downloadImage(from urlString: String, completed: @escaping (UIImage?) -> Void) {
    let cacheKey = NSString(string: urlString)

    if let image = cache.object(forKey: cacheKey) {
      completed(image)
      return
    }

    guard let url = URL(string: urlString) else {
      completed(nil)
      return
    }

    let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
      guard let self = self,
        error == nil,
        let response = response as? HTTPURLResponse,
        response.statusCode == 200,
        let data = data,
        let image = UIImage(data: data) else {
          completed(nil)
          return
      }

      self.cache.setObject(image, forKey: cacheKey)
      completed(image)
    }

    task.resume()
  }
  
}
