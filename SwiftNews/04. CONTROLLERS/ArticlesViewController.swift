//
//  ViewController.swift
//  SwiftNews
//
//  Created by BES on 2020-02-12.
//  Copyright © 2020 BEstelrich. All rights reserved.
//

import UIKit

class ArticlesViewController: UIViewController {
  
  @IBOutlet weak var articlesCollectionView: UICollectionView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupArticlesCollectionView()
  }
  
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if let detailsViewController = segue.destination as? ArticleDetailsViewController {
      detailsViewController.navigationItem.title = "Passing title"
    }
  }

}


extension ArticlesViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  
  func setupArticlesCollectionView() {
    self.articlesCollectionView.delegate   = self
    self.articlesCollectionView.dataSource = self
  }
  
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 20
  }
  
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = articlesCollectionView.dequeueReusableCell(withReuseIdentifier: Identifier.Cell.articleCollectionViewCell, for: indexPath) as? ArticleCollectionViewCell else { return UICollectionViewCell() }
    
    return cell
  }
  
}
