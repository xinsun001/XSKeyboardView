//
//  TxtPicmodel.m
//  XSKeyboardView
//
//  Created by admin on 2020/12/31.
//  Copyright © 2020 xin sun. All rights reserved.
//

#import "TxtPicmodel.h"

@implementation TxtPicmodel


- (instancetype)initWithDictionary:(NSDictionary *)dic {
    self = [super init];
    
    if (self) {
        [self setValuesForKeysWithDictionary:dic];
    }
    
    return self;
}


- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}


@end
