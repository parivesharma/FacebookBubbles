//
//  InstagramDataManager.m
//  FacebookBubbles
//

#import "InstagramDataManager.h"

typedef void (^completionHandler)(NSData *data);

@interface InstagramDataManager () < NSURLSessionDataDelegate >
@property (nonatomic, strong) NSURLSession *session;
@property (nonatomic, strong) NSMutableDictionary *dictionary;
@end

@implementation InstagramDataManager

+ (InstagramDataManager *)sharedInstance {
    static InstagramDataManager *sharedInstance = nil;
    static dispatch_once_t onceToken;

    dispatch_once(&onceToken, ^{
        sharedInstance = [[InstagramDataManager alloc] init];
    });
    
    return sharedInstance;
}

- (id)init {
    self = [super init];
    
    if (self) {
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];

        self.session = [NSURLSession sessionWithConfiguration:configuration
                                                     delegate:self
                                                delegateQueue:nil];
        
        self.dictionary = [NSMutableDictionary dictionary];
    }

    return self;
}

- (NSString *)getThumbnailURLStringForCell:(NSInteger)index {
    NSDictionary *dict = [self.dataArray objectAtIndex:index];
    
    return dict[@"images"][@"thumbnail"][@"url"];
}

- (NSString *)getImageURLStringForCell:(NSInteger)index {
    NSDictionary *dict = [self.dataArray objectAtIndex:index];
    
    return dict[@"images"][@"standard_resolution"][@"url"];
}

- (void)loadURLRequestWithURLString:(NSString *)urlString completionHandler:(void (^)(NSData *data))completionHandler {
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:urlString]
                                                  cachePolicy:NSURLRequestReturnCacheDataElseLoad
                                              timeoutInterval:60];
    NSURLSessionDataTask *task = [self.session dataTaskWithRequest:request];
    
    [self.dictionary setObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:urlString, @"URLString",
                                                                                 [NSMutableData data], @"data",
                                                                                 [completionHandler copy], @"completionHandler",
                                                                                 nil]
                                                                          forKey:task];
    [task resume];
}

#pragma NSURLSession
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
                                     didReceiveData:(NSData *)data {
    [self.dictionary[dataTask][@"data"] appendData:data];
    
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
                           didCompleteWithError:(NSError *)error {
    if (self.dictionary[task]) {
        completionHandler completionHandler = self.dictionary[task][@"completionHandler"];

        if (completionHandler) {
            completionHandler(self.dictionary[task][@"data"]);
        }
    }
}

@end
