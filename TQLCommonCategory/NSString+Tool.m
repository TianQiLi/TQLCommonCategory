//
//  NSString+Tool.m
//  GEDU_Demo
//
//  Created by Eric on 14/10/29.
//  Copyright (c) 2014年 Eric. All rights reserved.
//

#import "NSString+Tool.h"
#import <CommonCrypto/CommonDigest.h>
#import <sys/xattr.h>
#import <UIKit/UIKit.h>
#include <CommonCrypto/CommonHMAC.h>


@implementation NSString (Tool)

+ (NSString *)documentPath
{
    static NSString *path = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)
                 objectAtIndex:0] copy];
        [NSString addSkipBackupAttributeToItemAtURL:[NSURL fileURLWithPath:path]];
    });
    return path;
}

+ (BOOL)addSkipBackupAttributeToItemAtURL:(NSURL *)URL
{
    if (URL==nil) {
        return NO;
    }
    NSString *systemVersion=[[UIDevice currentDevice] systemVersion];
    float version=[systemVersion floatValue];
    if (version<5.0) {
        return YES;
    }
    if (version>=5.1) {
        assert([[NSFileManager defaultManager] fileExistsAtPath: [URL path]]);
        
        NSError *error = nil;
        BOOL success = [URL setResourceValue: [NSNumber numberWithBool: YES]
                                      forKey: NSURLIsExcludedFromBackupKey error: &error];
        if (!success) {
        }
        return success;
    }
    
    if ([systemVersion isEqual:@"5.0"]) {
        return NO;
    } else {
        assert([[NSFileManager defaultManager] fileExistsAtPath: [URL path]]);
        
        const char *filePath = [[URL path] fileSystemRepresentation];
        
        const char *attrName = "com.apple.MobileBackup";
        u_int8_t attrValue = 1;
        
        int result = setxattr(filePath, attrName, &attrValue, sizeof(attrValue), 0, 0);
        return result == 0;
    }
    return YES;
}

+ (NSString *)cachePath
{
    static NSString *path = nil;
    if (!path) {
        path = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)
                 objectAtIndex:0] copy];
    }
    return path;
}


+ (NSString *)formatWithDate:(NSDate *)date andDateFormat:(NSString *)dateFormat
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:dateFormat];
    NSString *result = [dateFormatter stringFromDate:date];
    
    return result;
}

+ (NSString *)getAppVer
{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
}

- (NSURL *)toURL
{
    return [NSURL URLWithString:[self stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
}

- (BOOL)isEmail
{
    
    NSString *emailRegEx =
    @"(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}"
    @"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"
    @"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-"
    @"z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5"
    @"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"
    @"9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"
    @"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])";
    
    NSPredicate *regExPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
    return [regExPredicate evaluateWithObject:[self lowercaseString]];
}

- (NSString *)trimWhitespace
{
    NSMutableString *str = [self mutableCopy];
    CFStringTrimWhitespace((__bridge CFMutableStringRef)str);
    return str;
}

- (BOOL)isEmpty
{
    return [[self trimWhitespace] isEqualToString:@""];
}

- (NSString *)URLEncode
{
    NSString *result =
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                              (CFStringRef)self,
                                                              NULL,
                                                              CFSTR("!*'();:@&;=+$,/?%#[] "),
                                                              kCFStringEncodingUTF8));
    return [result trim];
}

- (NSString *) escapeHTML
{
    NSMutableString *s = [NSMutableString string];
    
    NSUInteger start = 0;
    NSUInteger len = [self length];
    NSCharacterSet *chs = [NSCharacterSet characterSetWithCharactersInString:@"<>&\""];
    
    while (start < len) {
        NSRange r = [self rangeOfCharacterFromSet:chs options:0 range:NSMakeRange(start, len-start)];
        if (r.location == NSNotFound) {
            [s appendString:[self substringFromIndex:start]];
            break;
        }
        
        if (start < r.location) {
            [s appendString:[self substringWithRange:NSMakeRange(start, r.location-start)]];
        }
        
        switch ([self characterAtIndex:r.location]) {
            case '<':
                [s appendString:@"&lt;"];
                break;
            case '>':
                [s appendString:@"&gt;"];
                break;
            case '"':
                [s appendString:@"&quot;"];
                break;
                //			case '…':
                //				[s appendString:@"&hellip;"];
                //				break;
            case '&':
                [s appendString:@"&amp;"];
                break;
        }
        
        start = r.location + 1;
    }
    
    return s;
}


- (NSString *) unescapeHTML
{
    NSMutableString *s = [[NSMutableString alloc] init];
    NSMutableString *target = [self mutableCopy];
    NSCharacterSet *chs = [NSCharacterSet characterSetWithCharactersInString:@"&"];
    
    while ([target length] > 0) {
        NSRange r = [target rangeOfCharacterFromSet:chs];
        if (r.location == NSNotFound) {
            [s appendString:target];
            break;
        }
        
        if (r.location > 0) {
            [s appendString:[target substringToIndex:r.location]];
            [target deleteCharactersInRange:NSMakeRange(0, r.location)];
        }
        
        if ([target hasPrefix:@"&lt;"]) {
            [s appendString:@"<"];
            [target deleteCharactersInRange:NSMakeRange(0, 4)];
        } else if ([target hasPrefix:@"&gt;"]) {
            [s appendString:@">"];
            [target deleteCharactersInRange:NSMakeRange(0, 4)];
        } else if ([target hasPrefix:@"&quot;"]) {
            [s appendString:@"\""];
            [target deleteCharactersInRange:NSMakeRange(0, 6)];
        } else if ([target hasPrefix:@"&#39;"]) {
            [s appendString:@"'"];
            [target deleteCharactersInRange:NSMakeRange(0, 5)];
        } else if ([target hasPrefix:@"&#039;"]) {
            [s appendString:@"'"];
            [target deleteCharactersInRange:NSMakeRange(0, 6)];
        } else if ([target hasPrefix:@"&amp;"]) {
            [s appendString:@"&"];
            [target deleteCharactersInRange:NSMakeRange(0, 5)];
        } else if ([target hasPrefix:@"&hellip;"]) {
            [s appendString:@"…"];
            [target deleteCharactersInRange:NSMakeRange(0, 8)];
        } else {
            [s appendString:@"&"];
            [target deleteCharactersInRange:NSMakeRange(0, 1)];
        }
    }
    
    return s;
}


- (NSString *)stringByRemovingHTML
{
    
    NSString *html = self;
    NSScanner *thescanner = [NSScanner scannerWithString:html];
    NSString *text = nil;
    
    while ([thescanner isAtEnd] == NO) {
        [thescanner scanUpToString:@"<" intoString:NULL];
        [thescanner scanUpToString:@">" intoString:&text];
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text] withString:@" "];
    }
    return html;
}

- (NSString *)MD5
{
    const char *cStr = [self UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

- (NSString *)trim
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

//获取拼音
- (NSString *)pinYin
{
    NSMutableString *ms = [[NSMutableString alloc] initWithString:self];
    //带有声调
    if (CFStringTransform((__bridge CFMutableStringRef)ms, 0, kCFStringTransformMandarinLatin, NO)) {
        
    }
    //去除声调
    if (CFStringTransform((__bridge CFMutableStringRef)ms, 0, kCFStringTransformStripDiacritics, NO)) {
        
    }
    
    return ms;
}

- (BOOL) isOlderVersionThan:(NSString *)otherVersion
{
    return ([self compare:otherVersion options:NSNumericSearch] == NSOrderedAscending);
}

- (BOOL) isNewerVersionThan:(NSString *)otherVersion
{
    return ([self compare:otherVersion options:NSNumericSearch] == NSOrderedDescending);
}

- (NSString *)removeAllSpace
{
    NSString *result = [self stringByReplacingOccurrencesOfString:@" " withString:@""];
    result = [result stringByReplacingOccurrencesOfString:@"    " withString:@""];
    return result;
}


//得到String的Size
- (CGSize)getSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size
{
    CGSize resultSize = CGSizeZero;
    if (self.length <= 0) {
        return resultSize;
    }
    if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1) {
        resultSize = [self boundingRectWithSize:size
                                        options:(NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading)
                                     attributes:@{NSFontAttributeName: font}
                                        context:nil].size;
    } else {
#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0
        resultSize = [self sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByWordWrapping];
        
#endif
    }
    resultSize = CGSizeMake(MIN(size.width, ceilf(resultSize.width)), MIN(size.height, ceilf(resultSize.height)));
    return resultSize;
}

//得到String的高
- (CGFloat)getHeightWithFont:(UIFont *)font constrainedToSize:(CGSize)size
{
    return [self getSizeWithFont:font constrainedToSize:size].height;
}

//得到String的宽
- (CGFloat)getWidthWithFont:(UIFont *)font constrainedToSize:(CGSize)size
{
    return [self getSizeWithFont:font constrainedToSize:size].width;
}


//得到String的Size
- (CGSize)getSizeWithFont:(UIFont *)font paragraphStyle:(NSMutableParagraphStyle *)paragraphStyle constrainedToSize:(CGSize)size
{
    CGSize resultSize = CGSizeZero;
    if (self.length <= 0) {
        return resultSize;
    }
    if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1) {
        resultSize = [self boundingRectWithSize:size
                                        options:(NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading)
                                     attributes:@{NSFontAttributeName: font,NSParagraphStyleAttributeName:paragraphStyle}
                                        context:nil].size;
    } else {
#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0
        resultSize = [self sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByWordWrapping];
        
#endif
    }
    resultSize = CGSizeMake(MIN(size.width, ceilf(resultSize.width)), MIN(size.height, ceilf(resultSize.height)));
    return resultSize;
}

//得到String的高
- (CGFloat)getHeightWithFont:(UIFont *)font paragraphStyle:(NSMutableParagraphStyle *)paragraphStyle constrainedToSize:(CGSize)size
{
    return [self getSizeWithFont:font paragraphStyle:paragraphStyle constrainedToSize:size].height;
}

//得到String的宽
- (CGFloat)getWidthWithFont:(UIFont *)font paragraphStyle:(NSMutableParagraphStyle *)paragraphStyle constrainedToSize:(CGSize)size
{
    return [self getSizeWithFont:font paragraphStyle:paragraphStyle constrainedToSize:size].width;
}

//得到String的高
- (CGFloat)getHeightWithFont:(UIFont *)font lineSpacing:(CGFloat)lineSpacing width:(CGFloat)width
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = lineSpacing;

    return [self getSizeWithFont:font paragraphStyle:paragraphStyle constrainedToSize:CGSizeMake(width, MAXFLOAT)].height;
}


//HmacSHA1加密；
+ (NSString *)HmacSha1:(NSString *)key data:(NSString *)data
{
    const char *cKey  = [key cStringUsingEncoding:NSASCIIStringEncoding];
    const char *cData = [data cStringUsingEncoding:NSASCIIStringEncoding];
    //Sha256:
    // unsigned char cHMAC[CC_SHA256_DIGEST_LENGTH];
    //CCHmac(kCCHmacAlgSHA256, cKey, strlen(cKey), cData, strlen(cData), cHMAC);
    
    //sha1
    unsigned char cHMAC[CC_SHA1_DIGEST_LENGTH];
    CCHmac(kCCHmacAlgSHA1, cKey, strlen(cKey), cData, strlen(cData), cHMAC);
    
    NSData *HMAC = [[NSData alloc] initWithBytes:cHMAC
                                          length:sizeof(cHMAC)];
    
    NSString *hash = [HMAC base64EncodedStringWithOptions:0];//将加密结果进行一次BASE64编码。
    return hash;
}

//- (NSString *)urlSafeString{
//    //We first encode the string in case it already had escaped characters
//    NSString *encoded = self.encodedURLString;
//    //Add escapes
//    return (__bridge_transfer NSString *) CFURLCreateStringByAddingPercentEscapes(NULL,
//                                                                                  (CFStringRef)encoded,
//                                                                                  NULL,
//                                                                                  NULL,
//                                                                                  kCFStringEncodingUTF8);
//}
//- (NSString *) encodedURLString{
//    return (__bridge_transfer NSString *) CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL,
//                                                                                                  (CFStringRef)self,
//                                                                                                  CFSTR(""),
//                                                                                                  kCFStringEncodingUTF8);
//}

//是否包含emoji
- (BOOL)containsEmoji
{
    if (!self || self.length <= 0) {
        return NO;
    }
    __block BOOL returnValue = NO;
    [self enumerateSubstringsInRange:NSMakeRange(0, [self length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:
     ^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
         
         const unichar hs = [substring characterAtIndex:0];
         // surrogate pair
         if (0xd800 <= hs && hs <= 0xdbff) {
             if (substring.length > 1) {
                 const unichar ls = [substring characterAtIndex:1];
                 const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                 if (0x1d000 <= uc && uc <= 0x1f77f) {
                     returnValue = YES;
                 }
             }
         } else if (substring.length > 1) {
             const unichar ls = [substring characterAtIndex:1];
             if (ls == 0x20e3) {
                 returnValue = YES;
             }
             
         } else {
             // non surrogate
             if (0x2100 <= hs && hs <= 0x27ff) {
                 returnValue = YES;
             } else if (0x2B05 <= hs && hs <= 0x2b07) {
                 returnValue = YES;
             } else if (0x2934 <= hs && hs <= 0x2935) {
                 returnValue = YES;
             } else if (0x3297 <= hs && hs <= 0x3299) {
                 returnValue = YES;
             } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                 returnValue = YES;
             }
         }
     }];
    
    return returnValue;
}

#pragma mark emotion_monkey
+ (NSDictionary *)emotion_monkey_dict
{
    static NSDictionary *_emotion_monkey_dict;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _emotion_monkey_dict = @{@"coding_emoji_01": @"哈哈",
                                 @"coding_emoji_02": @"吐",
                                 @"coding_emoji_03": @"压力山大",
                                 @"coding_emoji_04": @"忧伤",
                                 @"coding_emoji_05": @"坏人",
                                 @"coding_emoji_06": @"酷",
                                 @"coding_emoji_07": @"哼",
                                 @"coding_emoji_08": @"你咬我啊",
                                 @"coding_emoji_09": @"内急",
                                 @"coding_emoji_10": @"32个赞",
                                 @"coding_emoji_11": @"加油",
                                 @"coding_emoji_12": @"闭嘴",
                                 @"coding_emoji_13": @"wow",
                                 @"coding_emoji_14": @"泪流成河",
                                 @"coding_emoji_15": @"NO!",
                                 @"coding_emoji_16": @"疑问",
                                 @"coding_emoji_17": @"耶",
                                 @"coding_emoji_18": @"生日快乐",
                                 @"coding_emoji_19": @"求包养",
                                 @"coding_emoji_20": @"吹泡泡",
                                 @"coding_emoji_21": @"睡觉",
                                 @"coding_emoji_22": @"惊讶",
                                 @"coding_emoji_23": @"Hi",
                                 @"coding_emoji_24": @"打发点咯",
                                 @"coding_emoji_25": @"呵呵",
                                 @"coding_emoji_26": @"喷血",
                                 @"coding_emoji_27": @"Bug",
                                 @"coding_emoji_28": @"听音乐",
                                 @"coding_emoji_29": @"垒码",
                                 @"coding_emoji_30": @"我打你哦",
                                 @"coding_emoji_31": @"顶足球",
                                 @"coding_emoji_32": @"放毒气",
                                 @"coding_emoji_33": @"表白",
                                 @"coding_emoji_34": @"抓瓢虫",
                                 @"coding_emoji_35": @"下班",
                                 @"coding_emoji_36": @"冒泡"};
    });
    return _emotion_monkey_dict;
}
- (NSString *)emotionMonkeyName
{
    return [NSString emotion_monkey_dict][self];
}


/**
 移除换行符
 */
- (NSString *)removeLineBreak
{
    NSArray *strArray = [self componentsSeparatedByString:@"\n"];
    
    if (strArray.count > 0) {
        return [strArray componentsJoinedByString:@""];
    }
    
    return nil;
}

@end
