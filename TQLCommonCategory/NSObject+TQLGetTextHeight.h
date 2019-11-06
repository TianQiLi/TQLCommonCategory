//
//  NSObject+TQLGetTextHeight.h
//  hqedu24olapp
//
//  Created by litianqi on 2018/7/30.
//  Copyright © 2018年 edu24ol. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSObject (TQLGetTextHeight)
+(CGFloat)tq_heightWithText:(NSString *)content  withRectWishSize:(CGSize)contentSize withLineSpacing:(CGFloat)_lineSpacing withFontSize:(NSInteger)fontSize;

+(CGFloat)tq_heightWithText:(NSString *)content  withRectWishSize:(CGSize)contentSize withLineSpacing:(CGFloat)_lineSpacing withFont:(UIFont *)font needRevise:(BOOL)needRevise;
/**
 * 支持最大行数设置：maxNumLine
 */
+(CGFloat)tq_heightWithText:(NSString *)content  withRectWishSize:(CGSize)contentSize withLineSpacing:(CGFloat)_lineSpacing withFont:(UIFont *)font maxNumberLine:(NSInteger )maxNumLine;

/**
 * 获取文本行数
 */
+ (NSInteger)tq_lineRowWithText:(NSString *)content  withRectWishSize:(CGSize)contentSize withFontSize:(NSInteger )fontSize;
+ (CGFloat)tq_lineRowHeightWithText:(NSString *)content  withRectWishSize:(CGSize)contentSize withFontSize:(NSInteger )fontSize lineSpace:(CGFloat *)lineSpace;
+ (CGFloat)tq_lineRowHeightWithText:(NSString *)content  withRectWishSize:(CGSize)contentSize withFontSize:(NSInteger )fontSize lineSpace:(CGFloat )lineSpace maxRow:(NSInteger)maxRow;

+(CGFloat)tq_heightWithText:(NSString *)content  withRectWishSize:(CGSize)contentSize withLineSpacing:(CGFloat)_lineSpacing withFont:(UIFont *)font lineBreakMode:(NSLineBreakMode)lineBreakMode textAlignmentLeft:(NSTextAlignment)textAlignment  needRevise:(BOOL)needRevise block:(void (^)(BOOL isSingle))block;


+(BOOL)tq_isSingleWithText:(NSString *)content  withRectWishSize:(CGSize)contentSize withLineSpacing:(CGFloat)_lineSpacing withFont:(UIFont *)font lineBreakMode:(NSLineBreakMode)lineBreakMode textAlignmentLeft:(NSTextAlignment)textAlignment;



/**
 * @param edgeMargin 距离容器边框的间距-针对边上的元素
 * @param spaceEdge 标签之间的水平间距和垂直间距-top：垂直间距; left:水平间距.  bottom 和right 无用,传0即可
 * @param paddIngInsetsItem 标签本身的内边距：文本相对于标签本身边框
 */
+ (CGRect)tq_getBoundsForTextTagArray:(NSArray *)tagArray font:(UIFont *)font edgeMargeForContainerView:(UIEdgeInsets)edgeMargin spaceEdge:(UIEdgeInsets)spaceEdge paddIngInsetsForItem:(UIEdgeInsets)paddIngInsetsItem maxWidth:(NSInteger)maxWidth block:(void (^) (CGRect frame, CGRect boundsContainerView ,BOOL islast, NSString * obj))block;

@end
