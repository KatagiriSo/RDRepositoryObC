//
//  RDWikipediaRecord.h
//  RDRepositoryObC
//
//  Created by RodhosSoft on 2020/02/27.
//  Copyright © 2020 developer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RDRecord.h"
#import "RDJSON.h"

NS_ASSUME_NONNULL_BEGIN

@interface RDWikipediaRecord : NSObject<RDRecord>
@property (assign) NSInteger identifier;
@property (assign) NSInteger ns;
@property (copy) NSString *title;
+ (nullable instancetype)record:(RDJSON *)raw;
@end

NS_ASSUME_NONNULL_END
