//
//  ArticleDetailsViewController.swift
//  SwiftNews
//
//  Created by BES on 2020-02-12.
//  Copyright © 2020 BEstelrich. All rights reserved.
//

import UIKit

class ArticleDetailsViewController: UIViewController {
  
  @IBOutlet weak var articleImageView: UIImageView!
  @IBOutlet weak var articleBodyTextView: UITextView!
  
  var articleImage: UIImage?
  var articleBody: String = ""
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureViewController()
  }
  
  
  func configureViewController() {
    articleBodyTextView.text = articleBody
    articleImageView.image   = articleImage
  }
  
}
