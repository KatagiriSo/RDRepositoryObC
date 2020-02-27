//
//  RDWikipediaManager.m
//  RDRepositoryObC
//
//  Created by RodhosSoft on 2020/02/27.
//  Copyright © 2020 developer. All rights reserved.
//

#import "RDWikipediaManager.h"
#import "RDWikipediaOperation.h"

@implementation RDWikipediaManager
static RDWikipediaManager* sharedData_ = nil;

+ (instancetype)sharedManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedData_ = [RDWikipediaManager new];
    });
    return sharedData_;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.cache = [[RDWikipediaCache alloc] initEexpireInterval:0.0
                                                    operationBlock:^RDWikipediaOperation* _Nonnull{
            return [RDWikipediaOperation new];
        }];
    }
    return self;
}

- (void)loadList:(RDWikipediaCompleteBlock)completeBlock {
    [self.cache load:completeBlock];
}
- (void)reloadList:(RDWikipediaCompleteBlock)completeBlock {
    [self.cache reload:completeBlock];
}
- (void)setNeedReload {
    [self.cache setNeedsReload];
}
@end
