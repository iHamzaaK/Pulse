
import UIKit
class UserProfileTagsFlowLayout: UICollectionViewFlowLayout {

  override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {

    let collectionViewWidth = self.collectionView!.frame.width - (self.sectionInset.right + self.sectionInset.left)



    let attributesForElementsInRect = super.layoutAttributesForElements(in: rect)
    var newAttributesForElementsInRect = [UICollectionViewLayoutAttributes]()

    var leftMargin: CGFloat = 0.0;

    for attributes in attributesForElementsInRect! {
      
      if (attributes.frame.origin.x == self.sectionInset.left) {
        leftMargin = self.sectionInset.left
      }
      else if (attributes.frame.origin.x + attributes.frame.size.width > collectionViewWidth) {
        var newLeftAlignedFrame = attributes.frame
        newLeftAlignedFrame.origin.x = self.sectionInset.left
        attributes.frame = newLeftAlignedFrame
      }
        else {
        var newLeftAlignedFrame = attributes.frame
        newLeftAlignedFrame.origin.x = leftMargin
        attributes.frame = newLeftAlignedFrame
      }
      leftMargin += attributes.frame.size.width + 8 // Makes the space between cells
      newAttributesForElementsInRect.append(attributes)
    }

    return newAttributesForElementsInRect
  }
}
