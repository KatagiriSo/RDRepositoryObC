//
//  RDWikipediaOperation.m
//  RDRepositoryObC
//
//  Created by RodhosSoft on 2020/02/27.
//  Copyright © 2020 developer. All rights reserved.
//

#import "RDWikipediaOperation.h"
#import "RDJSON.h"
#import "RDUtil.h"
#import "RDWikipediaRecord.h"

// https://ja.wikipedia.org/w/api.php?action=query&list=random&rnnamespace=0&rnlimit=10&format=jsonfm&utf8=

NSString *sample_url = @"https://ja.wikipedia.org/w/api.php?action=query&list=random&rnnamespace=0&rnlimit=10&format=json&utf8=";

@interface RDURLResult<T> : NSObject
@property (nonatomic, nullable) T result;
@property (nonatomic, nullable) NSURLResponse *urlResponse;
@property (nonatomic, nullable) NSError *error;
@end

@implementation RDURLResult
@end

@interface RDWikipediaOperation()
@property (nonatomic) dispatch_semaphore_t semaphore;
@property (nonatomic, nullable) RDURLResult * result;
@end

@implementation RDWikipediaOperation
- (instancetype)init {
    self = [super init];
    if (self) {
        self.semaphore = dispatch_semaphore_create(0);
    }
    return self;
}

- (void)main {
    RDURLResult *result = [self load];
    if (result.result != nil) {
        RDJSON *json = [RDJSON wrapJson:result.result];
        if (json.dict) {
            self.data = [json.dict[@"query"][@"random"].array map:^id _Nonnull(RDJSON * _Nonnull raw) {
                return [RDWikipediaRecord record:raw];
            }];
        }
    }
}

- (nullable RDURLResult *)load {
    NSURL *url_ns = [NSURL URLWithString:sample_url];
    NSURL *url = [url_ns absoluteURL];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:30];
//    [request setValue:@"SampleApp" forKey:@"User-Agent"];
    request.HTTPMethod = @"GET";
    
    __weak RDWikipediaOperation *wself = self;
    NSURLSessionTask *task = [NSURLSession.sharedSession dataTaskWithRequest:request
                                                           completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        __nullable id json = nil;
        RDURLResult *res = [RDURLResult new];
        res.urlResponse = response;
        res.error = error;
        
        if (data == nil) {
            wself.result = res;
            dispatch_semaphore_signal(wself.semaphore);
            return;
        }
        
        NSError *error_ = nil;
        @try {
            json = [NSJSONSerialization JSONObjectWithData:data
                                                   options:NSJSONReadingAllowFragments
                                                     error:&error_];
            if (error != nil) {
                res.error = error;
            }
            res.result = json;
        } @catch (NSError *error) {
            res.error = error;
        } @finally {
            
        }
        
        wself.result = res;
        dispatch_semaphore_signal(wself.semaphore);
    }];
    
    [task resume];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    
    return self.result;
}

@end
