//
//  ViewController.m
//  FacebookBubbles
//

#import "ViewController.h"
#import "InstagramDataManager.h"
#import "CollectionViewController.h"

@interface  ViewController()

@property (nonatomic, strong) NSMutableArray *arrayOfImageViews;
@property (nonatomic, assign) NSInteger originX;
@property (nonatomic, assign) NSInteger originY;
@property (nonatomic, strong) CollectionViewController *collectionViewController;

@end

@implementation ViewController

- (void)viewDidLoad {
    NSString *urlString = @"https://api.instagram.com/v1/tags/childhoodfriends/media/recent?count=400&client_id=b144ef1f82724d6995cd528c7c94f21b";

    [super viewDidLoad];
    
    self.originX = 0;
    self.originY = 100;

    /*
     * Display the Facebook messenger button.
     */
    [self.facebookMsgButton setBackgroundImage:[UIImage imageNamed:@"fb.jpg"] forState:UIControlStateNormal];
    [self.facebookMsgButton setNeedsDisplay];
    [self.facebookMsgButton addTarget:self action:@selector(messgenerButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    self.facebookMsgButton.contentMode = UIViewContentModeScaleAspectFit;
    
    self.arrayOfImageViews = [NSMutableArray array];

    /*
     * Get data from Instagram server using REST APIs.
     */
    [[InstagramDataManager sharedInstance] loadURLRequestWithURLString:urlString completionHandler:^(NSData *data) {
        if (data) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];

            [InstagramDataManager sharedInstance].dataArray = dict[@"data"];
        }
    }];
}

- (void)addSelectedImage:(NSData *)data {
   [self dismissViewControllerAnimated:YES completion:nil];

   UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageWithData:data]];
   imageView.frame = CGRectMake(self.originX, self.originY, 40, 40);

   self.originX += 10;

   [self.view addSubview:imageView];
   
   [self.arrayOfImageViews addObject:imageView];
}

- (void)messgenerButtonPressed:(id)sender {
    if (!self.collectionViewController) {
        self.collectionViewController = [[CollectionViewController alloc] initWithCollectionViewLayout:[UICollectionViewFlowLayout new]];
    }

    [self presentViewController:self.collectionViewController animated:YES completion:nil];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
  CGPoint point = [[touches anyObject] locationInView:self.view];
  
  self.originX = point.x;
  self.originY = point.y;
  
  for (UIImageView *imageView in self.arrayOfImageViews) {
    imageView.frame = CGRectMake(self.originX, self.originY, 40, 40);
                   
    self.originX += 10;
  }

  [self.view setNeedsDisplay];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
  CGPoint point = [[touches anyObject] locationInView:self.view];
  
  if (point.x > (self.view.frame.size.width / 2)) {
      self.originX = self.view.frame.size.width - ([self.arrayOfImageViews count] * 10);
  } else {
      self.originX = 0;
  }
  
  for (UIImageView *imageView in self.arrayOfImageViews) {
    imageView.frame = CGRectMake(self.originX, self.originY, 40, 40);
                   
    self.originX += 10;
  }

  [self.view setNeedsDisplay];
}

@end
