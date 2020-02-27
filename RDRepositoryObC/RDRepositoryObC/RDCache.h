//
//  RDCache.h
//  RDRepositoryObC
//
//  Created by RodhosSoft on 2020/02/27.
//  Copyright © 2020 developer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RDLoadOperation.h"

NS_ASSUME_NONNULL_BEGIN

typedef id T;

typedef RDLoadOperation<T> *_Nonnull(^OperationBlock)(void);
typedef void (^CompleteBlock)(__nullable T,  NSError * _Nullable );

@interface RDCache<T> : NSObject
@property (nonatomic, nonnull) OperationBlock makeLoadOperation;
- (instancetype)initEexpireInterval:(NSTimeInterval)expireInterval
                     operationBlock:(OperationBlock)operationBlock;
- (void)clear;
- (BOOL)isExpired;
- (void)load;
- (void)reload;
- (void)setNeedsReload;
- (void)load:(CompleteBlock)completeBlock;
- (void)reload:(CompleteBlock)completeBlock;
- (void)loadFinish:(NSError * _Nullable)error;
- (void)reloadFinish:(RDLoadOperation<T> *)operation;
@end

NS_ASSUME_NONNULL_END
