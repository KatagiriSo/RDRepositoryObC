//
//  RDJSON.m
//  RDRepositoryObC
//
//  Created by RodhosSoft on 2020/02/27.
//  Copyright © 2020 developer. All rights reserved.
//

#import "RDJSON.h"
#import "RDUtil.h"

@implementation RDJSON
+ (instancetype)dict:(NSDictionary <NSString*, RDJSON*> *)dict {
    RDJSON_Dict *rdjson = [RDJSON_Dict new];
    rdjson.dic = dict;
    return rdjson;
}
+ (instancetype)array:(NSArray <RDJSON *> *)array {
    RDJSON_Array *rdjson = [RDJSON_Array new];
    rdjson.array = array;
    return rdjson;
}
+ (instancetype)string:(NSString *)string {
    RDJSON_String *rdjson = [RDJSON_String new];
    rdjson.string = string;
    return rdjson;
}
+ (instancetype)number:(NSNumber *)number {
    RDJSON_Number *rdjson = [RDJSON_Number new];
    rdjson.number = number;
    return rdjson;
}
+ (instancetype)null {
    RDJSON_Null *rdjson = [RDJSON_Null new];
    return rdjson;
}
+ (instancetype)wrapJson:(id)json {
    if ([json isKindOfClass:[NSDictionary<NSString *, id> class]]) {
        NSMutableDictionary *d = [NSMutableDictionary dictionary];
        NSDictionary<NSString *, id> *dict = json;
        [dict enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, id  _Nonnull value, BOOL * _Nonnull stop) {
            d[key] = [self wrapJson:value];
        }];
        return [self dict:d];
    }
    
    if ([json isKindOfClass:[NSArray<id> class]]) {
        NSArray <id>*array = json;
        return [self array:[array map:^id _Nonnull(id _Nonnull ob) {
            return [self wrapJson:ob];
        }]];
    }

    if ([json isKindOfClass:[NSString class]]) {
        NSString *string = json;

        return [self string:string];
    }
    
    if ([json isKindOfClass:[NSNumber class]]) {
        NSNumber *number = json;

        return [self number:number];
    }
    
    return [self null];
}

+ (nullable instancetype)parse:(NSData *)data {
    NSError *error;
    RDJSON *json = nil;
    @try {
        id raw = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        if (error != nil) {
            NSLog(@"[Error]parse:%@", [error debugDescription]);
            return nil;
        }
        if (raw == nil) {
            return nil;
        }

        json = [self wrapJson:raw];
        
    } @catch (NSException *exception) {
        NSLog(@"[Exception]parse:%@", [exception debugDescription]);
        json = nil;
    } @finally {
        
    }
    return nil;
}
- (id)raw {
    NSAssert(NO, @"must override");
    return [NSNull null];
}

- (nullable NSString *)string {
    if ([self isKindOfClass:[RDJSON_String class]]) {
        RDJSON_String *json = (RDJSON_String *)self;
        return json.string;
    }
    return nil;
}

- (nullable NSNumber *)number {
    if ([self isKindOfClass:[RDJSON_Number class]]) {
        RDJSON_Number *json = (RDJSON_Number *)self;
        return json.number;
    }
    return nil;
}

- (BOOL)isNull {
    if ([self isKindOfClass:[RDJSON_Null class]]) {
        return YES;
    }
    return NO;
}

- (nullable NSDictionary<NSString *, RDJSON *> *)dict {
    if ([self isKindOfClass:[RDJSON_Dict class]]) {
        RDJSON_Dict *json = (RDJSON_Dict *)self;
        return json.dic;
    }
    return nil;
}

- (nullable NSArray<RDJSON *> *)array {
    if ([self isKindOfClass:[RDJSON_Array class]]) {
        RDJSON_Array *json = (RDJSON_Array *)self;
        return json.array;
    }
    return nil;
}

- (nullable instancetype)objectForKeyedSubscript:(NSString *)key {
        if ([self isKindOfClass:[RDJSON_Dict class]]) {
            RDJSON_Dict *json = (RDJSON_Dict *)self;
            return json.dic[key];
        }
        return nil;
}

//- (void)setObject:(id)object forKeyedSubscript:(NSString *)key;

- (nullable instancetype)objectAtIndexedSubscript:(NSUInteger)index {
    if ([self isKindOfClass:[RDJSON_Array class]]) {
        RDJSON_Array *json = (RDJSON_Array *)self;
        return json.array[index];
    }
    return nil;
}

//- (void)setObject:(id)object atIndexedSubscript:(NSUInteger)index
@end

@implementation RDJSON(Date)
- (nullable NSDate *)date {
    NSString *s = [self string];
    if (s == nil) {
        return nil;
    }
    
    return [self dateFromString:s];
}

//todo: memory
- (nullable NSDate *)dateFromString:(nullable NSString *)fromString {
    if (fromString == nil) {
        return nil;
    }
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    dateFormatter.dateFormat = @"yyyy/MM/DD HH:mm:ss";
    return [dateFormatter dateFromString:fromString];
}

//todo: memory
- (nullable NSString *)dateFromDate:(nullable NSDate *)fromDate {
    if (fromDate == nil) {
        return nil;
    }
    
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    dateFormatter.dateFormat = @"yyyy/MM/DD HH:mm:ss";
    return [dateFormatter stringFromDate:fromDate];
}
@end

@implementation RDJSON_Dict : RDJSON
- (id)raw {
    NSMutableDictionary *retDic = [NSMutableDictionary dictionary];
    [self.dic enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, RDJSON * _Nonnull obj, BOOL * _Nonnull stop) {
        retDic[key] = obj.raw;
    }];
    return  retDic;
}
@end

@implementation RDJSON_Array : RDJSON
- (id)raw {
    NSArray *ret = [self.array map:^id _Nonnull(RDJSON * _Nonnull ob) {
        return ob.raw;
    }];
    return ret;
}
@end

@implementation RDJSON_String : RDJSON
- (id)raw {
    return self.string;
}
@end
@implementation RDJSON_Number : RDJSON
- (id)raw {
    return self.number;
}
@end

@implementation RDJSON_Null : RDJSON
- (id)raw {
    return [NSNull null];
}
@end
