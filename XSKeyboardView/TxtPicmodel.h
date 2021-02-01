//
//  TxtPicmodel.h
//  XSKeyboardView
//
//  Created by admin on 2020/12/31.
//  Copyright © 2020 xin sun. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TxtPicmodel : NSObject

@property (nonatomic , copy) NSString              * cht;
@property (nonatomic , copy) NSString              * png;


- (instancetype)initWithDictionary:(NSDictionary *)dic ;

@end

NS_ASSUME_NONNULL_END
