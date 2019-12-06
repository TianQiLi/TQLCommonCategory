//
//  NSString+Tool.h
//  GEDU_Demo
//
//  Created by Eric on 14/10/29.
//  Copyright (c) 2014年 Eric. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Tool)

/**
 *  得到document路径
 *
 *  @return document路径
 */
+ (NSString *)documentPath;

/**
 *  得到缓存路径
 *
 *  @return 缓存路径
 */
+ (NSString *)cachePath;

/**
 *  将日期格式化
 *
 *  @param date       日期
 *  @param dateFormat 格式化例如："yyyyMMdd"
 *
 *  @return 格式化后的日期
 */
+ (NSString *)formatWithDate:(NSDate *)date andDateFormat:(NSString *)dateFormat;

/**
 *  得到APP版本
 *
 *  @return APP版本
 */
+ (NSString *)getAppVer;

/**
 *  移除所有空格
 *
 *  @return 移除空格后的字符串
 */
- (NSString *)removeAllSpace;

/**
 *  移除字符串两端的空格
 *
 *  @return 字符串
 */
- (NSString *)trim;


/**
 *  字符串转换为URL（已经经过UTF－8 处理）
 *
 *  @return NSURL
 */
- (NSURL *)toURL;

/**
 *  判断是否是Email
 *
 *  @return YES，NO
 */
- (BOOL)isEmail;

/**
 *  判断是否为空（nil,"",空格都可以判断）
 *
 *  @return YES，NO
 */
- (BOOL)isEmpty;


- (NSString *) escapeHTML;
- (NSString *) unescapeHTML;

/**
 *  移除HTML标签
 *
 *  @return 字符串
 */
- (NSString *) stringByRemovingHTML;

/**
 *  MD5 加密
 *
 *  @return MD5加密后的字符串
 */
- (NSString *)MD5;

/**
 *  得到拼音
 *
 *  @return 字符串的拼音
 */
- (NSString *)pinYin;


- (NSString *)URLEncode;


/**
 *  比较，是不是老版本
 *
 *  @param otherVersion 要比较的版本
 *
 *  @return YES，NO
 */
- (BOOL) isOlderVersionThan:(NSString *)otherVersion;

/**
 *  比较是不是新版本
 *
 *  @param otherVersion 要比较的版本
 *
 *  @return YES，NO
 */
- (BOOL) isNewerVersionThan:(NSString *)otherVersion;

//字符串的Size
- (CGSize)getSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size;
- (CGFloat)getHeightWithFont:(UIFont *)font constrainedToSize:(CGSize)size;
- (CGFloat)getWidthWithFont:(UIFont *)font constrainedToSize:(CGSize)size;

- (CGSize)getSizeWithFont:(UIFont *)font paragraphStyle:(NSMutableParagraphStyle *)paragraphStyle constrainedToSize:(CGSize)size;
- (CGFloat)getHeightWithFont:(UIFont *)font paragraphStyle:(NSMutableParagraphStyle *)paragraphStyle constrainedToSize:(CGSize)size;
- (CGFloat)getWidthWithFont:(UIFont *)font paragraphStyle:(NSMutableParagraphStyle *)paragraphStyle constrainedToSize:(CGSize)size;

// 得到String的高
- (CGFloat)getHeightWithFont:(UIFont *)font lineSpacing:(CGFloat)lineSpacing width:(CGFloat)width;

//HmacSHA1加密；
+ (NSString *)HmacSha1:(NSString *)key data:(NSString *)data;

//- (NSString *)urlSafeString;

#pragma mark - coding.net emoji

- (BOOL)containsEmoji;

- (NSString *)emotionMonkeyName;

/**
 移除换行符
 */
- (NSString *)removeLineBreak;

@end
