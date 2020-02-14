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
    label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
    label.text = string
    label.sizeToFit()
    return label.frame.width
  }
  
  
  private static func calculateCellSizeWithoutThumbnail(for article: Article, in collectionView: UICollectionView) -> CGSize {
    let titleWidth                    = calculteWidthFromLabel(article.title)
    let collectionViewWidth           = collectionView.bounds.size.width
    
    let paddingWidth: CGFloat         = 10
    let singleLineHeight: CGFloat     = 40
    let additionalLineHeight: CGFloat = 15
    
    let titleWidthAndPadding: CGFloat = titleWidth + (paddingWidth * 2)
    let baseCellWidth                 = titleWidthAndPadding <= collectionViewWidth ? titleWidthAndPadding : collectionViewWidth
    
    let numberOfLines                 = (titleWidthAndPadding / collectionViewWidth).rounded(.up)
    let baseCellHeight                = singleLineHeight + ((numberOfLines - 1) * additionalLineHeight)
    
    return CGSize(width: baseCellWidth, height: baseCellHeight)
  }
  
  
  private static func calculateCellSizeWithThumbnail(for article: Article, in collectionView: UICollectionView) -> CGSize {
    let thumbnailHeight: CGFloat      = CGFloat(article.thumbnailHeight ?? 0)
    let thumbnailWidth: CGFloat       = CGFloat(article.thumbnailWidth ?? 0)
    let thumbnailAspectRatio: CGFloat = thumbnailHeight / thumbnailWidth

    let baseCellSize                  = calculateCellSizeWithoutThumbnail(for: article, in: collectionView)
    
    return CGSize(width: baseCellSize.width, height: baseCellSize.height + (baseCellSize.width * thumbnailAspectRatio))
  }
  
}
