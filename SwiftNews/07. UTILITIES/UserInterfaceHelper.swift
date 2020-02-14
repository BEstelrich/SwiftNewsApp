//
//  UserInterfaceHelper.swift
//  SwiftNews
//
//  Created by BES on 2020-02-14.
//  Copyright © 2020 BEstelrich. All rights reserved.
//

import UIKit

enum UserInterfaceHelper {
  
  typealias Article = ChildData
  
  
  static func calculateCellSize(for articles: [Article], in collectionView: UICollectionView, with indexPath: IndexPath) -> CGSize {
    let article: Article       = articles[indexPath.row]
    let hasThumbnailTheArticle = article.thumbnailWidth != nil ? true : false
    
    let cellWithoutThumbnail   = calculateCellSizeWithoutThumbnail(for: article, in: collectionView)
    let cellWithThumbnail      = calculateCellSizeWithThumbnail(for: article, in: collectionView)
    
    return hasThumbnailTheArticle ? cellWithThumbnail : cellWithoutThumbnail
  }
  
  
  private static func calculteWidthFromLabel(_ string: String) -> CGFloat {
    let label = UILabel(frame: .zero)
    label.text = string
    label.sizeToFit()
    return label.frame.width
  }
  
  
  private static func calculateCellSizeWithoutThumbnail(for article: Article, in collectionView: UICollectionView) -> CGSize {
    let titleWidth                  = calculteWidthFromLabel(article.title)
    let collectionViewWidth         = collectionView.bounds.size.width
    let padding: CGFloat            = 10
    let titleWithPadding: CGFloat   = titleWidth + (padding * 2)
    let additionalTitleLineHeight: CGFloat = 15
    
    let cellWidth                   = titleWithPadding <= collectionViewWidth ? titleWithPadding : collectionViewWidth
    
    let numberOfLines               = (titleWithPadding / collectionViewWidth).rounded(.up)
    let minimumTitleHeight: CGFloat = 40
    let cellHeight                  = minimumTitleHeight + ((numberOfLines - 1) * additionalTitleLineHeight)
    
    return CGSize(width: cellWidth, height: cellHeight)
  }
  
  
  private static func calculateCellSizeWithThumbnail(for article: Article, in collectionView: UICollectionView) -> CGSize {
    let thumbnailHeight: CGFloat      = CGFloat(article.thumbnailHeight ?? 0)
    let thumbnailWidth: CGFloat       = CGFloat(article.thumbnailWidth ?? 0)
    let thumbnailAspectRatio: CGFloat = thumbnailHeight / thumbnailWidth

    let minimumCellSize               = calculateCellSizeWithoutThumbnail(for: article, in: collectionView)
    
    return CGSize(width: minimumCellSize.width, height: minimumCellSize.height + (minimumCellSize.width * thumbnailAspectRatio))
  }
  
}
