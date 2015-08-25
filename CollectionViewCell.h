//
//  CollectionViewCell.h
//  FacebookBubbles
//

#import <UIKit/UIKit.h>

@interface CollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) NSString *thumbnailString;
@property (nonatomic, strong) NSData *imageData;

- (void)setUpCollectionCell;

@end

