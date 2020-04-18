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
  
  var articles: [Article] = [] { didSet { self.articlesCollectionView.reloadData() } }
  
  var fetchedArticles: [Article]  = []
  var filteredArticles: [Article] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureSearchController()
    setupArticlesCollectionView()
    getArticles()
  }
  
  
  func configureSearchController() {
    let searchController = UISearchController()
    searchController.searchResultsUpdater                 = self
    searchController.obscuresBackgroundDuringPresentation = false
    searchController.searchBar.placeholder                = "Seach by title"
    self.navigationItem.searchController                  = searchController
  }
  
  
  /// Fetches articles from the NetworkManager singleton and appends them to the local instance of the articles array.
  func getArticles() {
    NetworkManager.shared.getArticles { [weak self] result in
      guard let self = self else { return }
      
      switch result {
      case .success(let apiData):
        apiData.data.articles.forEach { self.articles.append($0.details) }
        self.fetchedArticles = self.articles
        
      case .failure(let error):
        print(error)
      }
    }
  }
  
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    switch segue.identifier {
    case Identifier.Segue.fromArticlesToArticleDetails:
      guard let detailsViewController            = segue.destination as? ArticleDetailsViewController,
        let cell                                 = sender as? ArticleCollectionViewCell,
        let indexPath                            = self.articlesCollectionView.indexPath(for: cell) else { return }
      
      detailsViewController.navigationItem.title = articles[indexPath.row].title
      detailsViewController.articleBody          = articles[indexPath.row].body
      detailsViewController.articleAuthor        = "Author: \(articles[indexPath.row].author)"
      detailsViewController.articleThumbnail     = cell.articleImageView.image
      
    default: break
    }
  }

}


extension ArticlesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  
  func setupArticlesCollectionView() {
    self.articlesCollectionView.delegate   = self
    self.articlesCollectionView.dataSource = self
  }
  
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return articles.count
  }
  
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = articlesCollectionView.dequeueReusableCell(withReuseIdentifier: Identifier.Cell.articleCollectionViewCell, for: indexPath) as? ArticleCollectionViewCell else { return UICollectionViewCell() }
    
    let article                 = articles[indexPath.row]
    cell.articleTitleLabel.text = article.title
    cell.articleAuthor.text     = article.author
    cell.articleImageView.downloadImage(fromURL: article.thumbnailLink!)
    return cell
  }
  
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    UserInterfaceHelper.calculateCellSize(for: articles, in: articlesCollectionView, with: indexPath)
  }

}


extension ArticlesViewController: UISearchResultsUpdating {
  
  func updateSearchResults(for searchController: UISearchController) {
    guard let searchText = searchController.searchBar.text, !searchText.isEmpty else {
      filteredArticles.removeAll()
      articles.removeAll()
      articles = fetchedArticles
      return
    }
    
    filteredArticles = articles.filter { $0.title.lowercased().contains(searchText.lowercased()) }
    articles         = filteredArticles
  }

}
