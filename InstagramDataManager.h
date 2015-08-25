//
//  InstagramDataManager.h
//  SelfieBox
//
//

#import <Foundation/Foundation.h>

@interface InstagramDataManager : NSObject

@property (nonatomic, strong) NSArray *dataArray;

+ (InstagramDataManager *)sharedInstance;

- (void)loadURLRequestWithURLString:(NSString *)urlString completionHandler:(void (^)(NSData *data))completionHandler;

- (NSString *)getThumbnailURLStringForCell:(NSInteger)index;
- (NSString *)getImageURLStringForCell:(NSInteger)index;

@end
