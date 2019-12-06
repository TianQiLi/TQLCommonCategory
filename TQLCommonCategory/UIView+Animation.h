//
//  UIView+Animation.h
//  B2C_iPhone_V4
//
//  Created by tianqi on 15/10/8.
//  Copyright (c) 2015年 edu24ol. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Animation)
/*
 闪烁
 */
- (void)startAnimationCutom_twinkleTypeWithCallBack:(void(^)())stop_CutomAnimation;
/*动画
 _type is the view's different duration of animation
 _type=1 express the view clicked
 _type=2 express the view display
 */
- (void)startAnimationCutom_ScalewithType:(NSUInteger)_type  withCallBack:(void(^)())stop_CutomAnimation;
- (void)startAnimationCutom_ScaleDefaultDurationWithCallBack:(void(^)())stop_CutomAnimation;
- (void)startAnimationCutom_ScalewithDuration:(float)_duration  withCallBack:(void(^)())stop_CutomAnimation;
//放大
- (void)startAnimationCutom_ScaleToLargeWithDefaultDurationWithCallBack:(void(^)())stop_CutomAnimation;
/*
 带动画导航功能-view:cell
 */
//push or pop
- (void)pushOrPop:(BOOL)isPush animationCutom_ScaleToLargeByDefaultDurationWithNavgation:(UINavigationController *)nav withTargetViewController:(UIViewController *)targetViewController withCallBack:(void(^)())stop_CutomAnimation;
- (void)pushOrPop:(BOOL)isPush AnimationCutom_ScaleToLargeWithDuration:(float)_duration withNavgation:(UINavigationController *)nav withTargetViewController:(UIViewController *)targetViewController withCallBack:(void(^)())stop_CutomAnimation;

//- (void)startAnimationCutom_ScaleToLargeWithDuration:(float)_duration withNavgation:(UINavigationController*)nav withTargetViewController:(UIViewController*)targetViewController withCallBack:(void(^)())stop_CutomAnimation;

- (void)startAnimationVertical_shakeForSubView:(BOOL)isFromTop isShowOrDissmiss:(BOOL)isShow completion:(void(^)())stopAnimation;
- (void)startAnimationCutom_shakeForSubView:(BOOL)isLeft completion:(void(^)())stopAnimation;
- (void)startAnimationCutom_shake:(BOOL)isLeft delay:(float)delay  completion:(void(^)())stopAnimation;
- (void)startAnimationCutom_Alpha:(void(^)())stopAnimation;

/*
 magnet
 */
- (void)startAnimationCutom_magnet_DirectionUp:(BOOL)isUp block:(void(^)())stopAnimation;

/*left or right*/
- (void)startAnimationCutom_SlideWithDirection:(BOOL)isleft withIndex:(NSInteger)index withBlock:(void(^)())stopAnimation;
- (void)startAnimationCutom_SlideWithDirection:(BOOL)isleft withIndex:(NSInteger)index duration:(float)_duration delay:(float)_delay withBlock:(void(^)())stopAnimation;
- (void)startSlideAnimaitonWithDirection:(BOOL)isLeft callback:(void(^)())stopAnimation;
- (void)swimAnimationDefault:(float)distance;

- (void)startAnimationCutomSpringInView:(UIView *)view conpleton:(void(^)())stopAnimation;

- (void)startAnimationCutomScaleWithView:(UIView *)animationView inView:(UIView *)inView conpleton:(void(^)())stopAnimation;

//- (void)startAnimationCutom_3dWithTargetViewController:(UIViewController*)vc withBlock:(void(^)(BOOL finished))completion;


- (void)setAnchorPoint:(CGPoint)anchorPoint forView:(UIView *)view;
@end

