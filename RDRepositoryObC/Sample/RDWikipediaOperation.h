//
//  RDWikipediaOperation.h
//  RDRepositoryObC
//
//  Created by RodhosSoft on 2020/02/27.
//  Copyright © 2020 developer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RDLoadOperation.h"

NS_ASSUME_NONNULL_BEGIN

@class RDWikipediaRecord;

@interface RDWikipediaOperation : RDLoadOperation<NSArray<RDWikipediaRecord *> *>
@end

NS_ASSUME_NONNULL_END
