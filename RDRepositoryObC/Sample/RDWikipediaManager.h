//
//  RDWikipediaManager.h
//  RDRepositoryObC
//
//  Created by RodhosSoft on 2020/02/27.
//  Copyright © 2020 developer. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "RDWikipediaCache.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^RDWikipediaCompleteBlock)(NSArray<RDWikipediaRecord *> * _Nullable records,  NSError * _Nullable error);

@interface RDWikipediaManager : NSObject
@property (nonnull) RDWikipediaCache *cache;
+ (instancetype)sharedManager;
- (void)loadList:(RDWikipediaCompleteBlock)completeBlock;
- (void)reloadList:(RDWikipediaCompleteBlock)completeBlock;
- (void)setNeedReload;
@end

NS_ASSUME_NONNULL_END
