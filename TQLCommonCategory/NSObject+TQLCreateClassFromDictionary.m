//
//  NSObject+TQLCreateClassFromDictionary.m
//  hqedu24olapp
//
//  Created by litianqi on 2018/8/1.
//  Copyright © 2018年 edu24ol. All rights reserved.
//

#import "NSObject+TQLCreateClassFromDictionary.h"

@implementation NSObject (TQLCreateClassFromDictionary)
//#ifdef DEBUG

+ (BOOL)tq_createClassModelFromDic:(NSDictionary *)dic withClassName:(NSString *)className{
    if ([dic isKindOfClass:[NSArray class]]) {
        NSArray * array = (NSArray *)dic;
        dic = (array.count > 0 ) ? array.firstObject : nil;
    }
    if(dic && ![dic isKindOfClass:[NSDictionary class]]){
        return NO;
    }
    
    if (!dic || dic.allValues.count == 0) {
        return NO;
    }
    if (!className || className.length == 0) {
        className = @"ClassName";
    }else{
        NSString * firsrChar = [className substringToIndex:1];
        className = [className stringByReplacingOccurrencesOfString:firsrChar withString:[firsrChar uppercaseString]];
    }
    NSArray * allkey = [dic allKeys];
    
    NSString * userPath = NSHomeDirectory();
    NSArray * array = [userPath componentsSeparatedByString:@"/"];
    NSString * userName = array[2];
    userPath = [NSString stringWithFormat:@"/Users/%@/Desktop/",userName];
    
    NSString * fileName_h = [NSString stringWithFormat:@"%@.h",className];
    NSString * fileName_m = [NSString stringWithFormat:@"%@.m",className];
    
    NSString * pretextFile_h = [NSString stringWithFormat:@"//  %@\n//  hqedu24olapp\n//\n//  Created by %@ on %@\n//  Copyright © 2016年 edu24ol. All rights reserved.",fileName_h,userName,[self tq_stringWithFormat:@"yyyy/MM/dd\n" date:[NSDate date]]];
    NSString * pretextFile_m = [NSString stringWithFormat:@"//  %@\n//  hqedu24olapp\n//\n//  Created by %@ on %@\n//  Copyright © 2016年 edu24ol. All rights reserved.",fileName_m,userName,[self  tq_stringWithFormat:@"yyyy/MM/dd\n" date:[NSDate date]]];
    
    NSString * pathFile_h = [NSString stringWithFormat:@"%@%@",userPath,fileName_h];
    NSString * pathFile_m = [NSString stringWithFormat:@"%@%@",userPath,fileName_m];
    
    
    //.h
    NSString * textInterger = @"\n@property (nonatomic, assign) NSInteger ";
    NSString * textString = @"\n@property (nonatomic, copy) NSString * ";
    NSString * textArray = @"\n@property (nonatomic, copy) NSArray * ";
    NSString * textDictionary = @"\n@property (nonatomic, copy) NSDictionary * ";
    NSString * resultsText_h = [NSString stringWithFormat:@"%@\n\n@interface %@ : NSObject\n",pretextFile_h,className];
    for (NSString * key in allkey) {
        NSNumber * value = [dic objectForKey:key];
        if ([value isKindOfClass:[NSNumber class]]) {
            resultsText_h = [NSString stringWithFormat:@"%@%@ %@;",resultsText_h,textInterger,key];
            
        }else if ([value isKindOfClass:[NSString class]]){
            resultsText_h = [NSString stringWithFormat:@"%@%@ %@;",resultsText_h,textString,key];
        }else if ([value isKindOfClass:[NSArray class]]){
            resultsText_h = [NSString stringWithFormat:@"%@%@ %@;",resultsText_h,textArray,key];
            [[self class] tq_createClassModelFromDic:value withClassName:key];
        }else if ([value isKindOfClass:[NSDictionary class]]){
            resultsText_h = [NSString stringWithFormat:@"%@%@ %@;",resultsText_h,textDictionary,key];
            [[self class] tq_createClassModelFromDic:value withClassName:key];
        }
    }
    
    resultsText_h = [NSString stringWithFormat:@"%@\n@end",resultsText_h];
    
    //.m
    NSString * resultsText_m = [NSString stringWithFormat:@"%@\n\n\n\n#import \"%@.h\"   \n\n@implementation %@ \n@end",pretextFile_m,className,className];
    
    //write .h
    
   
    NSFileManager * fileM = [NSFileManager defaultManager];
    if (![fileM fileExistsAtPath:pathFile_h]) {
        [fileM createFileAtPath:pathFile_h contents:[resultsText_h dataUsingEncoding:NSUTF8StringEncoding] attributes:@{NSFileProtectionKey: NSFileProtectionNone}];
    }
    NSError *error = nil;
    [resultsText_h writeToFile:pathFile_h atomically:YES encoding:NSUTF8StringEncoding error:&error];
    if (error) {
        NSLog(@"resultsText_h =%@",error);
    }
    //wriete .m
    
    if (![fileM fileExistsAtPath:pathFile_m]) {
        [fileM createFileAtPath:pathFile_m contents:[resultsText_m dataUsingEncoding:NSUTF8StringEncoding] attributes:@{NSFileProtectionKey: NSFileProtectionNone}];
        
    }
    [resultsText_m writeToFile:pathFile_m atomically:YES encoding:NSUTF8StringEncoding error:&error];
    if (error) {
        NSLog(@"resultsText_h =%@",error);
    }
    return YES;
}

- (NSString *) tq_stringWithFormat: (NSString *) format date:(NSDate *)date
{
    NSDateFormatter *formatter = [NSDateFormatter new];
//    formatter.locale = [NSLocale currentLocale]; // Necessary?
    formatter.dateFormat = format;
    return [formatter stringFromDate:date];
}


//#endif
@end
