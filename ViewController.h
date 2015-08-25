//
//  ViewController.h
//  FacebookBubbles
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIButton *facebookMsgButton;

- (void)addSelectedImage:(NSData *)data;

@end

