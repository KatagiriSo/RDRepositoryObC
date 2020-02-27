//
//  RDWikipediaCache.h
//  RDRepositoryObC
//
//  Created by RodhosSoft on 2020/02/27.
//  Copyright © 2020 developer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RDCache.h"
#import "RDWikipediaRecord.h"

NS_ASSUME_NONNULL_BEGIN

@interface RDWikipediaCache : RDCache<NSArray<RDWikipediaRecord *>*>
@end

NS_ASSUME_NONNULL_END
