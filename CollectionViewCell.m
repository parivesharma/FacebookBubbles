//
//  CollectionViewCell.m
//  FacebookBubbles
//

#import <Foundation/Foundation.h>
#import "CollectionViewCell.h"
#import "ViewController.h"
#import "InstagramDataManager.h"

@interface CollectionViewCell ()
@property (strong, nonatomic) UIButton *thumbnailButton;
@end

@implementation CollectionViewCell

- (void)imageSelected:(id)selector {
    ViewController *vc = (ViewController *)[UIApplication sharedApplication].delegate.window.rootViewController;
    
    /*
     * Send the selected image to main view controller.
     */
    [vc addSelectedImage:self.imageData];
}

- (void)setUpCollectionCell {
    if (!self.thumbnailButton) {
        self.thumbnailButton = [UIButton buttonWithType:UIButtonTypeCustom];
    }

    [self.thumbnailButton setFrame:CGRectMake(0.0, 0.0, self.frame.size.width, self.frame.size.width)];
    self.thumbnailButton.center = CGPointMake(CGRectGetWidth(self.frame) / 2, CGRectGetHeight(self.frame)/2);
    
    [[InstagramDataManager sharedInstance] loadURLRequestWithURLString:self.thumbnailString completionHandler:^(NSData *data) {
        if (data) {
            self.imageData = data;

            dispatch_async(dispatch_get_main_queue(), ^{
                [self.thumbnailButton setBackgroundImage:[UIImage imageWithData:data] forState:UIControlStateNormal];
                [self.thumbnailButton setNeedsDisplay];
            });
        }
    }];

    [self.thumbnailButton addTarget:self action:@selector(imageSelected:) forControlEvents:UIControlEventTouchUpInside];
    self.thumbnailButton.contentMode = UIViewContentModeScaleAspectFit;

    [self.contentView addSubview:self.thumbnailButton];
}

@end
