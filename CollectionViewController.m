//
//  CollectionViewController.m
//  FacebookBubbles
//

#import "CollectionViewController.h"
#import "CollectionViewCell.h"
#import "InstagramDataManager.h"

@implementation CollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.collectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:@"CollectionViewCell"];
    [self.collectionView setBackgroundColor:[UIColor whiteColor]];
    self.collectionView.alwaysBounceVertical = YES;

    self.view.backgroundColor = [UIColor whiteColor];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section {
    return [InstagramDataManager sharedInstance].dataArray.count;
}

#pragma mark - UICollectionViewDelegate

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionViewCell" forIndexPath:indexPath];
    
    cell.thumbnailString = [[InstagramDataManager sharedInstance] getThumbnailURLStringForCell:indexPath.item];
    
    [cell setUpCollectionCell];

    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    return CGSizeMake(CGRectGetWidth(self.view.frame), 40);
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(80, 80);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 5;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 5;
}

@end
