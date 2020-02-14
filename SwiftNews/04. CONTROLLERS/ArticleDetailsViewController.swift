//
//  ArticleDetailsViewController.swift
//  SwiftNews
//
//  Created by BES on 2020-02-12.
//  Copyright © 2020 BEstelrich. All rights reserved.
//

import UIKit

class ArticleDetailsViewController: UIViewController {
  
  @IBOutlet weak var articleThumbnailImageView: UIImageView!
  @IBOutlet weak var articleBodyTextView: UITextView!
  
  var articleThumbnail: UIImage?
  var articleBody: String?
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureViewController()
  }
  
  
  /// This method configures the IBOutlets and hides the image when it's nil.
  func configureViewController() {
    articleBodyTextView.text           = articleBody
    articleThumbnailImageView.isHidden = articleThumbnail == nil ? true : false
    articleThumbnailImageView.image    = articleThumbnail
  }
  
}
