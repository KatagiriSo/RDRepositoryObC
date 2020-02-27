//
//  RDLoadOperation.h
//  RDRepositoryObC
//
//  Created by RodhosSoft on 2020/02/27.
//  Copyright © 2020 developer. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RDLoadOperation<T> : NSOperation
@property (nullable, nonatomic) T data;
- (nullable NSError *)getError;
- (void)main; // please override
- (BOOL)isConcurrent; // please override
- (BOOL)isAsynchronous; // please override
@end

NS_ASSUME_NONNULL_END
