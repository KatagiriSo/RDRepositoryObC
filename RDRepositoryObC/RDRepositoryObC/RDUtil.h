//
//  RDUtil.h
//  RDRepositoryObC
//
//  Created by RodhosSoft on 2020/02/27.
//  Copyright © 2020 developer. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RDUtil : NSObject

@end

@interface NSObject (isNull)
-(BOOL)isNull;
- (instancetype)nullCheck;
- (NSString *)stringCheck;
- (NSNumber *)numberCheck;
@end

@interface NSArray<T>(List)
- (NSArray <T>*)filter:(BOOL (^)(T))block;
- (NSArray <id>*)map:(id (^)(T))block;
- (NSArray <id>*)mapWithIndex:(id (^)(T obj, NSUInteger idx))block;
- (T)find:(BOOL (^)(T))block;
- (void)forEach:(BOOL (^)(T))block;
+ (NSArray <id>*)join:(NSArray <NSArray*>*)arrays;
@end

@interface NSMutableArray<T>(List)
- (T)shift;
- (void)addObjectWithOutNill:(T)ob;
@end

@interface NSDictionary(Util)
+ (NSDictionary *)dictionaryWithDictionaryList:(NSArray<NSDictionary *>*)list;
- (NSMutableDictionary *)mutableDictionary;
@end

@interface NSString(Util)
- (NSString *)add:(NSString *)str;
- (NSString *)space:(NSUInteger)num;
@end

NS_ASSUME_NONNULL_END
