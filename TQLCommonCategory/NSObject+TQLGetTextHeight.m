//
//  NSObject+TQLGetTextHeight.m
//  hqedu24olapp
//
//  Created by litianqi on 2018/7/30.
//  Copyright © 2018年 edu24ol. All rights reserved.
//

#import "NSObject+TQLGetTextHeight.h"

@implementation NSObject (TQLGetTextHeight)
+(CGFloat)heightWithText:(NSString *)content  withRectWishSize:(CGSize)contentSize withLineSpacing:(CGFloat)_lineSpacing withFontSize:(NSInteger)fontSize{
    return [[self class] heightWithText:content withRectWishSize:contentSize withLineSpacing:_lineSpacing withFont:[UIFont systemFontOfSize:fontSize] lineBreakMode:NSLineBreakByCharWrapping textAlignmentLeft:NSTextAlignmentLeft needRevise:NO block:nil];
}

+(CGFloat)heightWithText:(NSString *)content  withRectWishSize:(CGSize)contentSize withLineSpacing:(CGFloat)_lineSpacing withFont:(UIFont *)font needRevise:(BOOL)needRevise{
    return [[self class] heightWithText:content withRectWishSize:contentSize withLineSpacing:_lineSpacing withFont:font lineBreakMode:NSLineBreakByCharWrapping textAlignmentLeft:NSTextAlignmentLeft needRevise:needRevise block:nil];
}

+(CGFloat)heightWithText:(NSString *)content  withRectWishSize:(CGSize)contentSize withLineSpacing:(CGFloat)_lineSpacing withFont:(UIFont *)font maxNumberLine:(NSInteger)maxNumLine{
    CGFloat textHeight = [[self class] heightWithText:content withRectWishSize:contentSize withLineSpacing:_lineSpacing withFont:font needRevise:YES];
    CGFloat maxHeight = maxNumLine * (font.pointSize + _lineSpacing) - _lineSpacing;
    if (maxNumLine && (textHeight > maxHeight)) {
        return maxHeight;
    }
    return textHeight;
}

+ (NSInteger)lineRowWithText:(NSString *)content  withRectWishSize:(CGSize)contentSize withFontSize:(NSInteger )fontSize{
    content = content ? content : @"";
    UIFont * font = [UIFont systemFontOfSize:fontSize];
    NSDictionary * attributes = @{NSFontAttributeName : font,
                                  };
    CGSize sizeContent = [content  boundingRectWithSize:contentSize
                                                options:(NSStringDrawingUsesLineFragmentOrigin)
                                             attributes:attributes
                                                context:nil].size;
    
    
    float lineRow = sizeContent.height/font.lineHeight;
    return lineRow;
   
}

+ (CGFloat)lineRowHeightWithText:(NSString *)content  withRectWishSize:(CGSize)contentSize withFontSize:(NSInteger )fontSize lineSpace:(CGFloat)lineSpace{
    NSInteger lineRow = [[self class] lineRowWithText:content withRectWishSize:contentSize withFontSize:fontSize];
    CGFloat height = lineRow * lineSpace;
    return height;
}

+ (CGFloat)lineRowHeightWithText:(NSString *)content  withRectWishSize:(CGSize)contentSize withFontSize:(NSInteger )fontSize lineSpace:(CGFloat )lineSpace maxRow:(NSInteger)maxRow{
    NSInteger lineRow = [[self class] lineRowWithText:content withRectWishSize:contentSize withFontSize:fontSize];
    if (maxRow) {
        lineRow = MIN(lineRow, maxRow);
    }
    CGFloat height = lineRow * lineSpace;
    return height;
}


+(CGFloat)heightWithText:(NSString *)content  withRectWishSize:(CGSize)contentSize withLineSpacing:(CGFloat)_lineSpacing withFont:(UIFont *)font lineBreakMode:(NSLineBreakMode)lineBreakMode textAlignmentLeft:(NSTextAlignment)textAlignment  needRevise:(BOOL)needRevise block:(void (^)(BOOL isSingle))block{
    content = content ? content : @"";
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode =lineBreakMode;
    paragraphStyle.alignment = textAlignment;
    paragraphStyle.lineSpacing =_lineSpacing;
    NSDictionary * attributes = @{NSFontAttributeName : font,
                                  NSParagraphStyleAttributeName : paragraphStyle};
    CGSize sizeContent = [content  boundingRectWithSize:contentSize
                                                        options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                                     attributes:attributes
                                                        context:nil].size;
    
    NSInteger height = sizeContent.height + 1;
    CGSize sizeSingle =[@"" sizeWithAttributes:@{NSFontAttributeName:font}];
    NSInteger singlelineHeight = ceilf(sizeSingle.height)  + _lineSpacing;
    if (labs(height - singlelineHeight) < 2) {//单行-修正
        if (needRevise) {
            height = ceilf(font.pointSize);
        }
        if (block) {
            block(YES);
        }
    }else{
        if (block) {
            block(NO);
        }
    }
    return height;
}

+(BOOL)isSingleWithText:(NSString *)content  withRectWishSize:(CGSize)contentSize withLineSpacing:(CGFloat)_lineSpacing withFont:(UIFont *)font lineBreakMode:(NSLineBreakMode)lineBreakMode textAlignmentLeft:(NSTextAlignment)textAlignment{
    CGFloat height  = [[self class] heightWithText:content withRectWishSize:contentSize withLineSpacing:_lineSpacing withFont:font lineBreakMode:NSLineBreakByCharWrapping textAlignmentLeft:NSTextAlignmentLeft needRevise:NO block:nil];
    
    CGSize size =[@"" sizeWithAttributes:@{NSFontAttributeName:font}];
    NSInteger singlelineHeight = ceilf(size.height)  + _lineSpacing;
    if (fabs(height - singlelineHeight) < 2) {//单行-修正
        return YES;
    }
    return NO;
 }


/**
 * @param :edgeMargin 距离容器边框的间距-针对边上的元素
 * @param :spaceEdge 标签之间的水平间距和垂直间距-top：垂直间距; left:水平间距.  bottom 和right 无用,传0即可
 * @param :paddIngInsetsItem 标签本身的内边距：文本相对于标签本身边框
 */
+ (CGRect)getBoundsForTextTagArray:(NSArray *)tagArray font:(UIFont *)font edgeMargeForContainerView:(UIEdgeInsets)edgeMargin spaceEdge:(UIEdgeInsets)spaceEdge paddIngInsetsForItem:(UIEdgeInsets)paddIngInsetsItem maxWidth:(NSInteger)maxWidth block:(void (^) (CGRect frame, CGRect boundsContainerView ,BOOL islast, NSString * obj))block{
    CGRect containerViewFrame = CGRectZero;
    //TODO: 别名计算高度
    if (tagArray.count > 0) {
        //距离容器边框的宽度
        NSInteger marginLeft = edgeMargin.left;
        NSInteger marginTop  = edgeMargin.top;
        
        //标签本身之间的水平间距和垂直间距
        NSInteger marginInner_horizontal = spaceEdge.left;
        NSInteger marginInner_vertical  = spaceEdge.top;
        
        NSInteger results_width = marginLeft;
        NSInteger results_height = marginTop ;
        NSInteger max_width = maxWidth;
        NSInteger lineNumber = 1;
        NSInteger lastTextHeight = 0;
        NSInteger i = 0;
        
        //test
        NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
        paragraphStyle.alignment = NSTextAlignmentLeft;
        paragraphStyle.lineSpacing = 0;
        //end
        
        for (NSString * alias in tagArray) {
            i++;
            CGSize size =  [alias sizeWithAttributes:@{NSFontAttributeName:font,NSParagraphStyleAttributeName : paragraphStyle}];
            NSInteger text_width = ceil(size.width);
            NSInteger text_height = size.height;
            //修正：待完善-待验证确认
            text_height = ceilf(font.pointSize);
            
            //计算宽度-上下边距
            text_width = text_width + (paddIngInsetsItem.left + paddIngInsetsItem.right);//标签本身的宽度
            //计算高度
            text_height = text_height + (paddIngInsetsItem.top + paddIngInsetsItem.bottom);//标签本身的高度
            
            //上下间距
            NSInteger temp_textWidth = text_width + marginInner_horizontal;
            //对右边临界判断，比较右边距和水平间距大小，取最大值做是否换行的判断标准
            NSInteger temp_textWidth_max = text_width + MAX(edgeMargin.right, marginInner_horizontal);
            NSInteger temp_textHeight = text_height + marginInner_vertical;
            lastTextHeight = temp_textHeight;
            //文本标签的frame
            CGRect rectItem = CGRectZero;
            
            if ((results_width + temp_textWidth_max) > max_width ) {//需要换行; 累计更新高度
                //            if ((results_width + temp_textWidth) > max_width ) {//需要换行; 累计更新高度
                results_height += temp_textHeight;//y起新行
                results_width = marginLeft;
                rectItem = CGRectMake(results_width, results_height, text_width, text_height);
                
                lineNumber ++;//行数增加
            }else{
                rectItem = CGRectMake(results_width, results_height, text_width, text_height);
                results_width += temp_textWidth;//累计更新宽度：采用真是的宽度，而不是右边界最大值temp_textWidth_max
            }
            
            BOOL isLast = NO;
            if (i == tagArray.count) {
                results_height += lastTextHeight;//最后修正:加上最后元素的高度
                
                
                results_height -= marginInner_vertical;//减去垂直间距
                results_height += edgeMargin.bottom; //加上底部边距
                
                isLast = YES;
            }
            
            containerViewFrame = CGRectMake(0, 0, max_width, results_height);
            if (block) {
                block(rectItem,containerViewFrame,isLast,alias);
            }
        }
    }
    return containerViewFrame;
    
}


@end
