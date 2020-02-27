//
//  RDJSON.h
//  RDRepositoryObC
//
//  Created by RodhosSoft on 2020/02/27.
//  Copyright © 2020 developer. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


@interface RDJSON : NSObject
+ (instancetype)dict:(NSDictionary <NSString*, RDJSON*> *)dict;
+ (instancetype)array:(NSArray <RDJSON *> *)array;
+ (instancetype)string:(NSString *)string;
+ (instancetype)number:(NSNumber *)number;
+ (instancetype)null;
+ (instancetype)wrapJson:(id)json;
+ (nullable instancetype)parse:(NSData *)data;
- (id)raw;
- (nullable NSString *)string;
- (nullable NSNumber *)number;
- (BOOL)isNull;
- (nullable NSDictionary<NSString *, RDJSON *> *)dict;
- (nullable NSArray<RDJSON *> *)array;
- (nullable instancetype)objectForKeyedSubscript:(NSString *)key;
//- (void)setObject:(id)object forKeyedSubscript:(NSString *)key;
- (nullable instancetype)objectAtIndexedSubscript:(NSUInteger)index;
//- (void)setObject:(id)object atIndexedSubscript:(NSUInteger)index;
@end

@interface RDJSON(Date)
- (nullable NSDate *)date;
- (nullable NSDate *)dateFromString:(nullable NSString *)fromString;
- (nullable NSString *)dateFromDate:(nullable NSDate *)fromDate;
@end


@interface RDJSON_Dict : RDJSON
@property (nonnull, strong) NSDictionary <NSString *, RDJSON *>*dic;
@end
@interface RDJSON_Array : RDJSON
@property (nonnull, strong) NSArray <RDJSON *>*array;
@end
@interface RDJSON_String : RDJSON
@property (nonnull, copy) NSString *string;
@end
@interface RDJSON_Number : RDJSON
@property (nonnull, copy) NSNumber *number;
@end
@interface RDJSON_Null : RDJSON
@end

NS_ASSUME_NONNULL_END
