//
//  RDWikipediaRecord.m
//  RDRepositoryObC
//
//  Created by RodhosSoft on 2020/02/27.
//  Copyright © 2020 developer. All rights reserved.
//

#import "RDWikipediaRecord.h"

@interface RDWikipediaRecord()
@property (nonnull) RDJSON *raw;
@end

@implementation RDWikipediaRecord

+ (instancetype)record:(RDJSON *)raw {
    
    RDWikipediaRecord *record = [self new];
    record.raw = raw;
    
    NSNumber *identifier = raw[@"id"].number;
    if (!identifier) {
        return nil;
    }
    record.identifier = identifier.integerValue;
    
    NSNumber *ns = raw[@"ns"].number;
    if (!ns) {
        return nil;
    }
    record.ns = ns.integerValue;
    
    NSString *title = raw[@"title"].string;
    if (!title) {
        return nil;
    }
    
    record.title = title;
    
    return record;
}

- (NSString *)description {
    return [self.raw.raw description];
}
@end
