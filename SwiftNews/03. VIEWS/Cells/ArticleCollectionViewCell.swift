//
//  ArticleCollectionViewCell.swift
//  SwiftNews
//
//  Created by BES on 2020-02-12.
//  Copyright © 2020 BEstelrich. All rights reserved.
//

import UIKit

@IBDesignable
class ArticleCollectionViewCell: UICollectionViewCell {
  
  @IBOutlet weak var articleTitleLabel: UILabel!
  @IBOutlet weak var articleImageView: UIImageView!
  
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configure()
  }
  
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    configure()
  }
  
  
  private func configure() {
    self.layer.cornerRadius  = 30
  }
  
}
