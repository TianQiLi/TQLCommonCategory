//
//  NSString+Validate.h
//  edu24app
//
//  Created by ouyongyong on 16/3/10.
//  Modified by lidebo on 16/4/15
//  Copyright © 2016年 edu24ol. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Validate)

/**
 *  手机号码长度校验，11位
 *
 *  @return 有效YES,无效NO
 */
- (BOOL)validateMobileLength;

/**
 *  邮箱格式校验
 *
 *  @return 有效YES,无效NO
 */
- (BOOL)validateEmail;

/**
 *  用户名校验，8~18位的数字、字母、下划线，不包含空格
 *
 *  @return 有效YES,无效NO
 */
- (BOOL)validateUserName;

/**
 *  手机号码校验，长度11位且为国内运营商有效手机号码
 *
 *  @return 有效YES,无效NO
 */
- (BOOL)validateMobile;

/**
 *  密码校验，4~18位的数字、字母、下划线
 *
 *  @return 有效YES,无效NO
 */
- (BOOL)validatePassword;

/**
 *  姓名校验，长度1-10位且全部汉字
 *
 *  @return 有效YES,无效NO
 */
- (BOOL)validateName;

/**
 *  身份证校验，长度小于20的字母、数字
 *
 *  @return 有效YES,无效NO
 */
- (BOOL)validateIdentityCard;

- (BOOL)validateCustom:(NSString *)regx;
@end
