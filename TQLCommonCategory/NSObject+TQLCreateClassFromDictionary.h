//
//  NSObject+TQLCreateClassFromDictionary.h
//  hqedu24olapp
//
//  Created by litianqi on 2018/8/1.
//  Copyright © 2018年 edu24ol. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (TQLCreateClassFromDictionary)
+ (BOOL)tq_createClassModelFromDic:(NSDictionary *)dic withClassName:(NSString *)className;
@end
