//
//  RDCache.m
//  RDRepositoryObC
//
//  Created by RodhosSoft on 2020/02/27.
//  Copyright © 2020 developer. All rights reserved.
//

#import "RDCache.h"

typedef id T;

@interface RDCache()
@property (nullable, nonatomic) T cache;
@property (nonatomic, assign) NSTimeInterval expireInterval;
@property (nonnull, nonatomic) NSOperationQueue *queue;
@property (nullable, assign, nonatomic) NSDate *lastLoadDateTime;
@property (nonatomic, assign) BOOL isLoading;
@property (nonatomic, nonnull) NSArray<CompleteBlock> *loadCompletions;
@end

@implementation RDCache

- (instancetype)initEexpireInterval:(NSTimeInterval)expireInterval
                     operationBlock:(OperationBlock)operationBlock {
    self = [super init];
    if (self) {
        self.queue = [NSOperationQueue new];
        self.loadCompletions = @[];
        self.expireInterval = expireInterval;
        self.makeLoadOperation = operationBlock;
    }
    return self;
}

- (void)dealloc {
    [self clear];
}

- (void)clear {
    [self.queue cancelAllOperations];
    [self.queue waitUntilAllOperationsAreFinished];
    self.cache = nil;
    self.lastLoadDateTime = nil;
}

- (BOOL)isExpired {
    
    if (self.expireInterval < 0.0) {
        return  self.lastLoadDateTime == nil ? YES : NO;
    }
    
    if (self.expireInterval == 0.0) {
        return YES;
    }
    
    NSDate *lastLoadDateTime = self.lastLoadDateTime;
    if (lastLoadDateTime == nil) {
        return YES;
    }
    
    NSDate *expireDateTime = [lastLoadDateTime  dateByAddingTimeInterval:self.expireInterval];
    BOOL isExpired = [expireDateTime earlierDate:[NSDate date]];
    
    return isExpired;
}

- (void)load {
    if (self.isExpired) {
        [self reload];
    } else {
        [self loadFinish:nil];
    }
}

- (void)reload {
    if (self.isLoading) {
        return;
    }
    
    RDLoadOperation<T> *operation = [self makeLoadOperation]();
    
    self.isLoading = YES;
    
    __weak RDCache *wself = self;
    __weak RDLoadOperation<T> *woperation = operation;
    operation.completionBlock = ^{
        if ([operation getError] == nil) {
            [wself reloadFinish:woperation];
            wself.lastLoadDateTime = [NSDate date];
        }
        wself.isLoading = NO;
        [wself loadFinish:[woperation getError]];
        
        woperation.completionBlock = nil;
    };
    
    [self.queue addOperation:operation];
}

- (void)setNeedsReload {
    [self.queue cancelAllOperations];
    [self.queue waitUntilAllOperationsAreFinished];
    self.lastLoadDateTime = nil;
}

- (void)load:(CompleteBlock)completeBlock {
    @synchronized (self.loadCompletions) {
        self.loadCompletions = [self.loadCompletions arrayByAddingObject:completeBlock];
    }
    
    [self load];
}

- (void)reload:(CompleteBlock)completeBlock {
    @synchronized (self.loadCompletions) {
        self.loadCompletions = [self.loadCompletions arrayByAddingObject:completeBlock];
    }
    
    [self reload];
}

- (void)loadFinish:(NSError * _Nullable)error {
    NSArray<CompleteBlock> *completions =  self.loadCompletions;
    T result = self.cache;
    self.loadCompletions = @[];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        for (CompleteBlock completeBlock in completions) {
            completeBlock(result, error);
        }
    });
}

- (void)reloadFinish:(RDLoadOperation<T> *)operation {
    self.cache = operation.data;
}

@end
