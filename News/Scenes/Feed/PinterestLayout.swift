//
//  PinterestLayout.swift
//  News
//
//  Created by Melih Yuvacı on 12.01.2023.
//

import UIKit

protocol PinterestLayoutDelegate: class {
    func collectionView(_ collectionView:UICollectionView, heightForPhotoAt indexPath:IndexPath, with width: CGFloat) -> CGFloat
    func collectionView(_ collectionView:UICollectionView, heightForCaptionAt indexPath:IndexPath, with width: CGFloat) -> CGFloat
}

class PinterestLayout: UICollectionViewLayout {
    
    var delegate: PinterestLayoutDelegate?
        
    fileprivate var numberOfColumns = 2
    fileprivate var cellPadding : CGFloat = 6
    
    fileprivate var contentHeight : CGFloat = 0
    fileprivate var contentWidth : CGFloat {
        guard let collectionView = collectionView else {
            return 0
        }
        let insets = collectionView.contentInset
        return collectionView.bounds.width - (insets.left + insets.right)
    }
    
    
    override var collectionViewContentSize: CGSize{
        return CGSize(width: contentWidth, height: contentHeight)
    }
    
    private var attributesCache = [UICollectionViewLayoutAttributes]()
    override func prepare() {
        guard attributesCache.isEmpty == true, let collectionView = collectionView else {
            return
        }
        let columnWidth = contentWidth / CGFloat(numberOfColumns)
        var xOffset = [CGFloat]()
        for column in 0 ..< numberOfColumns {
          xOffset.append(CGFloat(column) * columnWidth)
        }
        var column = 0
        var yOffset = [CGFloat](repeating: 0, count: numberOfColumns)
        
        for item in 0 ..< collectionView.numberOfItems(inSection: 0) {
            
            let indexPath = IndexPath(item: item, section: 0)
            // calculate the frame
            let width = columnWidth - cellPadding * 2

            let photoHeight = delegate?.collectionView(collectionView, heightForPhotoAt: indexPath, with: width)
            let captionHeight = (delegate?.collectionView(collectionView, heightForCaptionAt: indexPath, with: width))!

            let height = cellPadding * 2 + photoHeight! + captionHeight
            let frame = CGRect(x: xOffset[column], y: yOffset[column], width: columnWidth, height: height)
            let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)
            
            // create layout attributes
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = insetFrame
            attributesCache.append(attributes)
            
            //update column, yOffset
            contentHeight = max(contentHeight, frame.maxY)
            yOffset[column] = yOffset[column] + height
            
            column = column < (numberOfColumns - 1) ? (column + 1) : 0

        }
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var layoutAttributes = [UICollectionViewLayoutAttributes]()
        
        for attributes in layoutAttributes {
            if attributes.frame.intersects(rect){
                layoutAttributes.append(attributes)
            }
        }
        return layoutAttributes
    }
    
}
