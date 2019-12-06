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
- (void)hq_startAnimationCutom_twinkleTypeWithCallBack:(void(^)(void))stop_CutomAnimation;
/*动画
 _type is the view's different duration of animation
 _type=1 express the view clicked
 _type=2 express the view display
 */
- (void)hq_startAnimationCutom_ScalewithType:(NSUInteger)_type  withCallBack:(void(^)(void))stop_CutomAnimation;
- (void)hq_startAnimationCutom_ScaleDefaultDurationWithCallBack:(void(^)(void))stop_CutomAnimation;
- (void)hq_startAnimationCutom_ScalewithDuration:(float)_duration  withCallBack:(void(^)(void))stop_CutomAnimation;
//放大
- (void)hq_startAnimationCutom_ScaleToLargeWithDefaultDurationWithCallBack:(void(^)(void))stop_CutomAnimation;
/*
 带动画导航功能-view:cell
 */
//push or pop
- (void)hq_pushOrPop:(BOOL)isPush animationCutom_ScaleToLargeByDefaultDurationWithNavgation:(UINavigationController *)nav withTargetViewController:(UIViewController *)targetViewController withCallBack:(void(^)(void))stop_CutomAnimation;
- (void)hq_pushOrPop:(BOOL)isPush AnimationCutom_ScaleToLargeWithDuration:(float)_duration withNavgation:(UINavigationController *)nav withTargetViewController:(UIViewController *)targetViewController withCallBack:(void(^)(void))stop_CutomAnimation;

//- (void)startAnimationCutom_ScaleToLargeWithDuration:(float)_duration withNavgation:(UINavigationController*)nav withTargetViewController:(UIViewController*)targetViewController withCallBack:(void(^)())stop_CutomAnimation;

- (void)hq_startAnimationVertical_shakeForSubView:(BOOL)isFromTop isShowOrDissmiss:(BOOL)isShow completion:(void(^)(void))stopAnimation;
- (void)hq_startAnimationCutom_shakeForSubView:(BOOL)isLeft completion:(void(^)(void))stopAnimation;
- (void)hq_startAnimationCutom_shake:(BOOL)isLeft delay:(float)delay  completion:(void(^)(void))stopAnimation;
- (void)hq_startAnimationCutom_Alpha:(void(^)(void))stopAnimation;

/*
 magnet
 */
- (void)hq_startAnimationCutom_magnet_DirectionUp:(BOOL)isUp block:(void(^)(void))stopAnimation;

/*left or right*/
- (void)hq_startAnimationCutom_SlideWithDirection:(BOOL)isleft withIndex:(NSInteger)index withBlock:(void(^)(void))stopAnimation;
- (void)hq_startAnimationCutom_SlideWithDirection:(BOOL)isleft withIndex:(NSInteger)index duration:(float)_duration delay:(float)_delay withBlock:(void(^)(void))stopAnimation;
- (void)hq_startSlideAnimaitonWithDirection:(BOOL)isLeft callback:(void(^)(void))stopAnimation;
- (void)hq_swimAnimationDefault:(float)distance;

- (void)hq_startAnimationCutomSpringInView:(UIView *)view conpleton:(void(^)(void))stopAnimation;

- (void)hq_startAnimationCutomScaleWithView:(UIView *)animationView inView:(UIView *)inView conpleton:(void(^)(void))stopAnimation;

//- (void)startAnimationCutom_3dWithTargetViewController:(UIViewController*)vc withBlock:(void(^)(BOOL finished))completion;


- (void)hq_setAnchorPoint:(CGPoint)anchorPoint forView:(UIView *)view;
@end


