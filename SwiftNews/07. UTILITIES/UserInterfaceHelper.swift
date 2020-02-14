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
    let isArticleWithImage: Bool     = articles[indexPath.row].thumbnailWidth != nil ? true : false
    
//    let padding: CGFloat             = 15
    let collectionViewWidth: CGFloat = collectionView.bounds.size.width
    
    let oneLineHeight: CGFloat        = 35
    let twoLinesHeight: CGFloat       = 55
    let threeLineHeight: CGFloat      = 75
    
    let thumbnailHeight: CGFloat      = CGFloat(articles[indexPath.item].thumbnailHeight ?? 0)
    let thumbnailWidth: CGFloat       = CGFloat(articles[indexPath.item].thumbnailWidth ?? 0)
    let thumbnailAspectRatio: CGFloat = thumbnailHeight/thumbnailWidth
    
    let titleWidth                    = calculateLabelSize(for: articles[indexPath.row].title)
    
    let onlyTextWidth                 = titleWidth < collectionViewWidth ? titleWidth : collectionViewWidth
    
    let onlyTextHeight: CGFloat = titleWidth < collectionViewWidth ?
      oneLineHeight : (titleWidth <= collectionViewWidth * 2) ?
        twoLinesHeight : threeLineHeight
    
    let textAndImageWidth: CGFloat = collectionViewWidth
    let textAndImageHeight: CGFloat = textAndImageWidth * thumbnailAspectRatio
    
    return isArticleWithImage ? CGSize(width: textAndImageWidth, height: textAndImageHeight) :
    CGSize(width: onlyTextWidth, height: CGFloat(onlyTextHeight))
  }
  
  
  private static func calculateLabelSize(for string: String) -> CGFloat {
    let label = UILabel(frame: .zero)
    label.text = string
    label.sizeToFit()
    return label.frame.width
  }
  
  
  private static func calculateTitleHeight(for title: String, in collectionView: UICollectionView) -> CGFloat {
    let titleWidth = calculateLabelSize(for: title)
    let numberOfLines = titleWidth / collectionView.bounds.size.width
    let defaultTitleSize: CGFloat = 35
    let titleHeight = defaultTitleSize + ((numberOfLines - 1) * 20)
    
    return titleHeight
  }
  
}
