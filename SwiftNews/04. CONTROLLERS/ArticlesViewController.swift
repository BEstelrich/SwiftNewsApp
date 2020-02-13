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
  
  typealias Article = ChildData
  
  var articles: [Article] = [] {
    didSet {
      DispatchQueue.main.async { self.articlesCollectionView.reloadData() }
    }
  }
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupArticlesCollectionView()
    getArticles()
  }
  
  
  func getArticles() {
      NetworkManager.shared.getArticles { [weak self] result in
          guard let self = self else { return }
          
          switch result {
          case .success(let apiData):
            apiData.data.articles.forEach { self.articles.append($0.details) }
            
          case .failure(let error):
              print(error)
          }
      }
  }
  
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if let detailsViewController = segue.destination as? ArticleDetailsViewController {
      if let cell = sender as? ArticleCollectionViewCell,
        let indexPath = self.articlesCollectionView.indexPath(for: cell) {
        detailsViewController.navigationItem.title = articles[indexPath.row].title
        detailsViewController.articleBody          = articles[indexPath.row].body
        detailsViewController.articleImage         = cell.articleImageView.image
      }
    }
  }

}


extension ArticlesViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  
  func setupArticlesCollectionView() {
    self.articlesCollectionView.delegate   = self
    self.articlesCollectionView.dataSource = self
  }
  
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return articles.count
  }
  
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = articlesCollectionView.dequeueReusableCell(withReuseIdentifier: Identifier.Cell.articleCollectionViewCell, for: indexPath) as? ArticleCollectionViewCell else { return UICollectionViewCell() }
    let article = articles[indexPath.row]
    
    cell.articleTitleLabel.text = article.title
    cell.articleImageView.downloadImage(fromURL: article.thumbnailLink!)
    
    return cell
  }
  
}
