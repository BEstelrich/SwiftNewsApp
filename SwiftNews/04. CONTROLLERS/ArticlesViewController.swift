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
  
  var articles: [Child] = [] {
    didSet {
      DispatchQueue.main.async { self.articlesCollectionView.reloadData() }
    }
  }
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    getArticles()
    setupArticlesCollectionView()
  }
  
  
  func getArticles() {
      NetworkManager.shared.getArticles { [weak self] result in
          guard let self = self else { return }
          
          switch result {
          case .success(let redditJSON):
            for article in redditJSON.data.children {
              self.articles.append(article)
            }
            
          case .failure(let error):
              print(error)
          }
      }
  }
  
  func downloadImage(from stringUrl: String?) -> UIImage? {
    guard let url = stringUrl,
      url != "self",
      url != "default",
      let imageUrl = NSURL(string: url),
      let data = NSData(contentsOf: imageUrl as URL)
      else { return nil }
    
    return UIImage(data: data as Data)
  }
  
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if let detailsViewController = segue.destination as? ArticleDetailsViewController {
      if let cell = sender as? ArticleCollectionViewCell,
        let indexPath = self.articlesCollectionView.indexPath(for: cell) {
        detailsViewController.navigationItem.title = articles[indexPath.row].data.title
        detailsViewController.articleBody          = articles[indexPath.row].data.selftext
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
    
    cell.articleTitleLabel.text = article.data.title
    cell.articleImageView.image = downloadImage(from: article.data.thumbnail)
    
    return cell
  }
  
}
