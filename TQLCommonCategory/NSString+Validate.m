//
//  NSString+Validate.m
//  edu24app
//
//  Created by ouyongyong on 16/3/10.
//  Copyright © 2016年 edu24ol. All rights reserved.
//

#import "NSString+Validate.h"

@implementation NSString (Validate)

- (BOOL)validateMobileLength
{
    NSString *phoneRegex = @"^\\d{11}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:self];
    
}

- (BOOL)validateEmail
{
    NSString *mailRegex = @"^([a-z0-9]*[-_]?[a-z0-9]+)*@([a-z0-9]*[-_]?[a-z0-9]+)+[\\.](.*?)";
    NSPredicate *mailCheck = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",mailRegex];
    return [mailCheck evaluateWithObject:self];
    
}

- (BOOL)validateUserName
{
    NSString *regx = @"[A-Z0-9a-z_]{8,18}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regx];
    return [pred evaluateWithObject:self];
}

- (BOOL)validateMobile
{
    NSString *MOBILE = @"^1(3[0-9]|5[0-35-9]|8[02-5-9]|78|47)\\d{8}$";
    
    NSString *CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    
    NSString *CU = @"^1(3[0-2]|5[256]|8[56]|76|45)\\d{8}$";
    
    NSString *CT = @"^1((33|53|8[019]|7[07])[0-9]|349)\\d{7}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:self] == YES)
        || ([regextestcm evaluateWithObject:self] == YES)
        || ([regextestct evaluateWithObject:self] == YES)
        || ([regextestcu evaluateWithObject:self] == YES)) {
        return YES;
    }
    else {
        return NO;
    }
}

- (BOOL)validatePassword
{
    NSString *regx = @"[A-Z0-9a-z_]{6,20}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regx];
    return [pred evaluateWithObject:self];
}

- (BOOL)validateName
{
    NSString *regx = @"[\u4e00-\u9fa5]{1,10}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regx];
    return [pred evaluateWithObject:self];
}

- (BOOL)validateIdentityCard
{
    NSString *regx = @"[A-Z0-9a-z]{1,20}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regx];
    return [pred evaluateWithObject:self];
}

- (BOOL)validateCustom:(NSString *)regx
{
    if (regx.length == 0) {
        return YES;
    }
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regx];
    return [pred evaluateWithObject:self];
}



@end
