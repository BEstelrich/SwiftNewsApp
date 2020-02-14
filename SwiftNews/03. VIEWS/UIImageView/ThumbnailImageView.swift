//
//  ThumbnailImageView.swift
//  SwiftNews
//
//  Created by BES on 2020-02-13.
//  Copyright © 2020 BEstelrich. All rights reserved.
//

import UIKit

class ThumbnailImageView: UIImageView {
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }
  
  
  /// Fetches the article's thumbnail from the NetworkManager singleton and assigns it to the ImageView cell.
  func downloadImage(fromURL url: String) {
    NetworkManager.shared.downloadImage(from: url) { [weak self] image in
      guard let self = self else { return }
      DispatchQueue.main.async { self.image = image }
    }
  }
  
}
