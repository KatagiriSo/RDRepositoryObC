//
//  RDUtil.m
//  RDRepositoryObC
//
//  Created by RodhosSoft on 2020/02/27.
//  Copyright © 2020 developer. All rights reserved.
//

#import "RDUtil.h"

@implementation RDUtil

@end

@implementation RDUtil (isNull)

- (BOOL)isNull {
    return [[NSNull null] isEqual:self];
}

- (instancetype)nullCheck {
    if ([self isNull]) {
        return nil;
    } else {
        return self;
    }
}

- (NSString *)stringCheck {
    if ([self isKindOfClass:[NSString class]]) {
        return (NSString *)self;
    } else {
        return nil;
    }
}


- (NSNumber *)numberCheck{
    if ([self isKindOfClass:[NSNumber class]]) {
        return (NSNumber *)self;
    } else {
        return nil;
    }
}

@end

@implementation NSArray(List)
- (NSArray <id> *)filter:(BOOL (^)(id))block {
    NSMutableArray *list = [NSMutableArray new];
    for (id o in self) {
        if (block(o)) {
            [list addObject:o];
        }
    }
    return list;
}


- (NSArray<id> *)map:(id (^)(id))block {
    NSMutableArray *list = [NSMutableArray new];
    for (id o in self) {
        id r = block(o);
        if (r) {
            [list addObject:r];
        }
    }
    return list;
}

- (NSArray <id>*)mapWithIndex:(id (^)(id obj, NSUInteger idx))block {
    NSMutableArray *list = [NSMutableArray new];
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        id mappedOb = block(obj,idx);
        [list addObject:mappedOb];
    }];
    return list;
}


- (id)find:(BOOL (^)(id))block {
    for (id o in self) {
        if (block(o)) {
            return o;
        }
    }
    
    return nil;
}

- (void)forEach:(BOOL (^)(id))block {
    for (id o in self) {
        if (!block(o)) {
            break;
        }
    }
}

+ (NSArray <id>*)join:(NSArray <NSArray*>*)arrays {
    NSMutableArray *ret = [NSMutableArray array];
    for (id ar in arrays) {
        [ret addObjectsFromArray:ar];
    }
    return ret;
}
@end

@implementation NSMutableArray(List)
- (id)shift {
    if (self.count == 0) {
        return nil;
    }
    id ret = self[0];
    [self removeObjectAtIndex:0];
    return ret;
}

- (void)addObjectWithOutNill:(id)ob {
    if (ob) {
        [self addObject:ob];
    }
}
@end

@implementation NSDictionary(Util)
+ (NSDictionary *)dictionaryWithDictionaryList:(NSArray<NSDictionary *>*)list {
    NSArray *keys = [NSArray join:[list map:^(NSDictionary * dic) {
        return dic.allKeys;
    }]];
    NSArray *values = [NSArray join:[list map:^(NSDictionary * dic) {
        return dic.allValues;
    }]];
    NSDictionary *ret = [[NSDictionary alloc] initWithObjects:values forKeys:keys];
    return ret;
}

- (NSMutableDictionary *)mutableDictionary {
    return [NSMutableDictionary dictionaryWithDictionary:self];
}
@end

@implementation NSString(Util)
- (NSString *)add:(NSString *)str {
    return [self stringByAppendingString:str];
}

- (NSString *)space:(NSUInteger)num {
    NSString *ret = self;
    for (NSInteger i=0;i<num;i++) {
        ret = [ret add:@" "];
    }
    return ret;
}
@end
