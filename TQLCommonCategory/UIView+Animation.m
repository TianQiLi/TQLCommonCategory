//
//  UIView+Animation.m
//  B2C_iPhone_V4
//
//  Created by tianqi on 15/10/8.
//  Copyright (c) 2015年 edu24ol. All rights reserved.
//

#import "UIView+Animation.h"
@implementation UIView (Animation)

- (void)startAnimationCutom_twinkleTypeWithCallBack:(void(^)())stop_CutomAnimation
{
    self.alpha = 0;
    [UIView animateWithDuration:0.15 animations:^{
        self.alpha = 1;
    } completion:^(BOOL finished) {
        self.alpha = 0;
        [UIView animateWithDuration:0.15 animations:^{
            self.alpha = 1;
        } completion:^(BOOL finished) {
            if (stop_CutomAnimation) {
                stop_CutomAnimation();
            }
        }];
    }];
    
    
}

- (void)startAnimationCutom_ScalewithType:(NSUInteger)_type  withCallBack:(void(^)())stop_CutomAnimation
{
    
    float _duration=0;
    if (_type==1) {//点击
        _duration=0.4;
    }
    else if (_type==2) {//展示
        _duration=1;
    }
    [self startAnimationCutom_ScalewithDuration:_duration withCallBack:stop_CutomAnimation];
    
}
#pragma mark --放缩
/*放缩*/
- (void)startAnimationCutom_ScaleDefaultDurationWithCallBack:(void(^)())stop_CutomAnimation
{
    [self startAnimationCutom_ScalewithDuration:0.3 withCallBack:^{
        if (stop_CutomAnimation) {
            stop_CutomAnimation();
        }
        
    }];
}

- (void)startAnimationCutom_ScalewithDuration:(float)_duration  withCallBack:(void(^)())stop_CutomAnimation
{
    [[self subviews] enumerateObjectsUsingBlock:^(id obj,NSUInteger idex,BOOL * stop) {
        [self performAnimationOnView:obj duration:_duration delay:0 callback:^(void) {
            if (idex == (self.subviews.count-1)) {
                if (stop_CutomAnimation) {
                    stop_CutomAnimation();
                }
                
            }
            
        }];
    }];
    
}

/*放缩*/
- (void)performAnimationOnView:(UIView *)view duration:(NSTimeInterval)duration delay:(NSTimeInterval)delay callback:(void(^)())stopAnimation
{
    // Start
    view.transform = CGAffineTransformIdentity;
    [UIView animateKeyframesWithDuration:duration/3 delay:delay options:0 animations:^{
        // End
        view.transform = CGAffineTransformMakeScale(0.95, 0.95);
    } completion:^(BOOL finished) {
        [UIView animateKeyframesWithDuration:duration/3 delay:0 options:0 animations:^{
            // End
            view.transform = CGAffineTransformMakeScale(1.15, 1.15);
        } completion:^(BOOL finished) {
            [UIView animateKeyframesWithDuration:duration/3 delay:0 options:0 animations:^{
                // End
                view.transform = CGAffineTransformIdentity;
            } completion:^(BOOL finished) {
                if (stopAnimation) {
                    stopAnimation();
                }
                
            }];
        }];
    }];
    
}

#pragma mark --/*放大-导航*/
- (void)startAnimationCutom_ScaleToLargeWithDefaultDurationWithCallBack:(void(^)())stop_CutomAnimation
{
    [self startAnimationCutom_ScaleToLargeWithDuration:0.3 withCallBack:^{
        if (stop_CutomAnimation) {
            stop_CutomAnimation();
        }
    }];
}

- (void)startAnimationCutom_ScaleToLargeWithDuration:(float)_duration  withCallBack:(void(^)())stop_CutomAnimation
{
    [[self subviews] enumerateObjectsUsingBlock:^(id obj,NSUInteger idex,BOOL * stop) {
        [self performAnimationOnView_large:obj duration:_duration delay:0 callback:^(void) {
            if (idex == (self.subviews.count-1)) {
                if (stop_CutomAnimation) {
                    stop_CutomAnimation();
                }
                
            }
            
        }];
    }];
    
}

//push or pop
- (void)pushOrPop:(BOOL)isPush animationCutom_ScaleToLargeByDefaultDurationWithNavgation:(UINavigationController *)nav withTargetViewController:(UIViewController *)targetViewController withCallBack:(void(^)())stop_CutomAnimation
{
    float duration = 0.26;
    if (!isPush) {
         duration = 0.21;
    }
    
    [self pushOrPop:isPush AnimationCutom_ScaleToLargeWithDuration:duration withNavgation:nav withTargetViewController:targetViewController withCallBack:^{
        if (stop_CutomAnimation) {
            stop_CutomAnimation();
        }
        
    }];
    
}

- (void)pushOrPop:(BOOL)isPush AnimationCutom_ScaleToLargeWithDuration:(float)_duration withNavgation:(UINavigationController *)nav withTargetViewController:(UIViewController *)targetViewController withCallBack:(void(^)())stop_CutomAnimation
{
    
    [self startAnimationCutom_ScaleToLargeWithDuration:_duration withCallBack:^{
        if (!nav || !targetViewController) {
            if (stop_CutomAnimation) {
                stop_CutomAnimation();
            }
            return ;
        }
        targetViewController.view.hidden = NO;
        targetViewController.view.alpha = 0;
        
        nav.view.alpha = 0;
        nav.view.transform = CGAffineTransformMakeScale(1.03, 1.04);
        [UIView animateWithDuration:0.5 animations:^{
            targetViewController.view.alpha = 1;
            nav.view.alpha = 1;
            nav.view.transform = CGAffineTransformIdentity;
            if (isPush) {
                [nav pushViewController:targetViewController animated:NO];
            }
            else
                [nav popViewControllerAnimated:NO];
            
        } completion:^(BOOL finished) {
            nav.view.transform = CGAffineTransformIdentity;
            if (stop_CutomAnimation) {
                stop_CutomAnimation();
            }
        }];
        
        
    }];
    
}

/*放大*/
- (void)performAnimationOnView_large:(UIView *)view duration:(NSTimeInterval)duration delay:(NSTimeInterval)delay callback:(void(^)())stopAnimation
{
    // Start
    view.transform = CGAffineTransformIdentity;
    float _duration = duration/2;
    [UIView animateKeyframesWithDuration:_duration delay:delay options:0 animations:^{
        // End
        view.transform = CGAffineTransformMakeScale(0.95, 0.95);
    } completion:^(BOOL finished) {
        [UIView animateKeyframesWithDuration:_duration delay:0 options:0 animations:^{
            // End
            view.transform = CGAffineTransformMakeScale(1.05, 1.05);
        } completion:^(BOOL finished) {
            view.transform = CGAffineTransformIdentity;
            if (stopAnimation) {
                stopAnimation();
            }
        }];
    }];
    
}

#pragma mark --震动

- (void)startAnimationVertical_shakeForSubView:(BOOL)isFromTop  isShowOrDissmiss:(BOOL)isShow completion:(void(^)())stopAnimation
{
    if (isShow) {
        [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            [obj startAnimationCutom_shake:isFromTop delay:idx * 0.04 completion:stopAnimation];
             
        }];
    } else {
        NSInteger count = self.subviews.count;
        [self.subviews enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
             [obj dismissWithShakeAnimation:!isFromTop delay:(count - idx) * 0.08 completion:stopAnimation];
        }];
    }
}

- (void)startAnimationVertical_shake:(BOOL)isFromTop delay:(float)delay completion:(void(^)())stopAnimation
{
    if (isFromTop) {
        float _y_offet =  (self.center.y + self.frame.size.height);
        self.transform = CGAffineTransformMakeTranslation(0, -_y_offet);
    } else {
        float _y_offet = self.superview.height - (self.frame.origin.y) + self.height;
        self.transform = CGAffineTransformMakeTranslation(0, _y_offet);
    }
    
    [UIView animateWithDuration:1.5 delay:delay usingSpringWithDamping:0.53 initialSpringVelocity:0 options:0 animations:^(void) {
         self.transform = CGAffineTransformIdentity;
         
     } completion:^(BOOL finished) {
         if (stopAnimation) {
             stopAnimation();
         }
         
     }];
}

- (void)dismissWithShakeAnimation:(BOOL)isToBottom delay:(float)delay completion:(void(^)())stopAnimation
{
    float y_offet = 0;
    
    if (isToBottom) {
          y_offet = self.superview.height - (self.frame.origin.y) + self.height;
    } else {
        y_offet = -(self.center.y + self.frame.size.height);
    }
    
    
    [UIView animateWithDuration:1 delay:delay usingSpringWithDamping:0.53 initialSpringVelocity:0 options:0 animations:^(void) {
         self.transform = CGAffineTransformMakeTranslation(0, y_offet);
         
     } completion:^(BOOL finished) {
         self.transform = CGAffineTransformIdentity;
         if (stopAnimation) {
             stopAnimation();
         }
         
     }];

    
    
 }

- (void)startAnimationCutom_shakeForSubView:(BOOL)isLeft completion:(void(^)())stopAnimation
{
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [obj startAnimationCutom_shake:isLeft delay:idx * 0.04 completion:stopAnimation];
    }];
}



- (void)startAnimationCutom_shake:(BOOL)isLeft delay:(float)delay completion:(void(^)())stopAnimation
{
    if (isLeft) {
         float _x_offet = self.superview.width - (self.center.x + self.frame.size.width);
         self.transform = CGAffineTransformMakeTranslation(_x_offet, 0);
    } else {
         float _y_offet = self.superview.height - (self.frame.origin.y) + self.height;
        self.transform = CGAffineTransformMakeTranslation(0, _y_offet);
    }
   
    [UIView animateWithDuration:1.5 delay:delay usingSpringWithDamping:0.53 initialSpringVelocity:0 options:0 animations:^(void) {
         self.transform = CGAffineTransformIdentity;
         
     } completion:^(BOOL finished) {
         if (stopAnimation) {
             stopAnimation();
         }
         
     }];
}

- (void)startAnimationCutom_SlideWithDirection:(BOOL)isleft withIndex:(NSInteger)index withBlock:(void(^)())stopAnimation
{
    float _duration = 0.3;//0.3
    float _delay = 0.2;//0.2
    [self startAnimationCutom_SlideWithDirection:isleft withIndex:index duration:(float)_duration delay:(float)_delay withBlock:^{
        if (stopAnimation) {
            stopAnimation();
        }
    }];
}

- (void)startAnimationCutom_SlideWithDirection:(BOOL)isleft withIndex:(NSInteger)index duration:(float)_duration delay:(float)_delay withBlock:(void(^)())stopAnimation
{
    NSInteger count = index;
    [[self subviews] enumerateObjectsUsingBlock:^(id obj,NSUInteger idex,BOOL * stop) {
        [self performAnimationOnView_Slide:obj withDirection:isleft  duration:_duration delay:_delay * count callback:^(void) {
            if (idex == (self.subviews.count - 1)) {
                if (stopAnimation) {
                    stopAnimation();
                }
            }
            
        }];
    }];
}

- (void)performAnimationOnView_Slide:(UIView *)view withDirection:(BOOL)isLeft duration:(NSTimeInterval)duration delay:(NSTimeInterval)delay callback:(void(^)())stopAnimation
{
    float _x_offet=[UIScreen mainScreen].bounds.size.width-self.center.x;
    if (isLeft) {
        _x_offet = -_x_offet;
    }
    self.transform=CGAffineTransformMakeTranslation(_x_offet, 0);
    self.alpha=0;
    [UIView animateWithDuration:duration delay:delay options:0 animations:^(void) {
         self.alpha = 0.2;
         self.transform=CGAffineTransformIdentity;
     } completion:^(BOOL finished) {
         [UIView animateWithDuration:0.8 animations:^{
             self.alpha = 1;
         } completion:^(BOOL finished) {
             if (stopAnimation) {
                 stopAnimation();
             }
             
         }];
         
     }];
    
}

- (void)startSlideAnimaitonWithDirection:(BOOL)isLeft callback:(void(^)())stopAnimation
{
    float _x_offet = [UIScreen mainScreen].bounds.size.width - self.center.x;
    if (isLeft) {
        _x_offet = -_x_offet;
    }
    self.transform = CGAffineTransformMakeTranslation(_x_offet, 0);
    self.alpha = 0;
    [UIView animateWithDuration:0.2 delay:0.1 options:0 animations:^(void) {
         self.alpha = 0.8;
         self.transform = CGAffineTransformIdentity;
     } completion:^(BOOL finished) {
         [UIView animateWithDuration:0.1 animations:^{
             self.alpha = 1;
         } completion:^(BOOL finished) {
             if (stopAnimation) {
                 stopAnimation();
             }
             
         }];
         
     }];
    
}


/*
 magnet
 */
- (void)startAnimationCutom_magnet_DirectionUp:(BOOL)isUp block:(void(^)())stopAnimation
{
    float _translationY=0;
    float selfHeight = self.frame.size.height;
    float threshold= selfHeight/2;
    float maxNum=0;
    if ([self isKindOfClass:[UITableViewCell class]]) {
        _translationY = self.bounds.size.height;
    }
    else if ([self.superview isKindOfClass:[UICollectionView class]]) {
        float _contentOffsety= 0;
        float superViewHeight = 0;
        if ([self.superview isKindOfClass:[UICollectionView class]]) {
            UICollectionView *collectonV=(UICollectionView *)self.superview;
            _contentOffsety= collectonV.contentOffset.y;
            superViewHeight = collectonV.frame.size.height;
            maxNum=collectonV.visibleCells.count;
        }
        
        _translationY = self.frame.origin.y- _contentOffsety;//相对y
        if (_translationY>= threshold && _translationY <=(superViewHeight- threshold)) {
            _translationY=0;
            return;
        }
        
        if (_translationY< threshold) {
            _translationY= -selfHeight*maxNum;
        }
        else
            _translationY = selfHeight*maxNum;
        
    }
    else
        _translationY = self.frame.origin.y<self.superview.frame.size.height ? fabs(self.superview.frame.size.height-self.origin.y) :self.bounds.size.height;
    
    self.alpha = 0;
    if (!isUp) {
        _translationY = -_translationY;
    }
    self.transform = CGAffineTransformMakeTranslation(0, _translationY);
    [UIView animateKeyframesWithDuration:0.4 delay:0.1 options:0 animations:^{
        self.alpha = 0.9;
        self.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        [UIView animateKeyframesWithDuration:0.3 delay:0 options:0 animations:^{
            self.alpha = 1;
        } completion:^(BOOL finished) {
            if (stopAnimation) {
                stopAnimation();
            }
        }];
        
    }];
    
    
}

- (void)performAnimationOnView_CutomMagnet:(UIView *)view duration:(NSTimeInterval)duration delay:(NSTimeInterval)delay callback:(void(^)())stopAnimation
{
    float _translationY=0;
    float _tempH=0;
    if ([self.superview isKindOfClass:[UICollectionView class]]) {
        UICollectionView *collectonV=(UICollectionView *)self.superview;
        _translationY = self.frame.origin.y- collectonV.contentOffset.y;
        if (_translationY<0) {
            _translationY=0;
            return;
        }
        
        _tempH=collectonV.frame.size.height+48;
        _translationY=_translationY<_tempH ?fabsf(_tempH-_translationY):0;
        
    }
    else if ([self.superview isKindOfClass:[UITableView class]]) {
        UITableView *collectonV=(UITableView *)self.superview;
        _translationY = self.frame.origin.y- collectonV.contentOffset.y;
        if (_translationY<0) {
            _translationY=0;
            return;
        }
        
        _tempH=collectonV.frame.size.height+48;
        _translationY=_translationY<_tempH ?fabsf(_tempH-_translationY):0;
        
    }
    else
        _translationY=self.frame.origin.y<self.superview.frame.size.height ? fabs(self.superview.frame.size.height-self.origin.y) :0;
    
    _translationY=[[UIScreen mainScreen]bounds].size.height;
    view.alpha = 0;
    view.transform = CGAffineTransformMakeTranslation(0, _translationY);
    [UIView animateKeyframesWithDuration:duration delay:delay options:0 animations:^{
        // End
        view.alpha = 1;
        //        view.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        if (stopAnimation) {
            stopAnimation();
        }
    }];
    
}

- (void)startAnimationCutom_Alpha:(void(^)())stopAnimation
{
    float _x_offet = [UIScreen mainScreen].bounds.size.width -self.center.x;
    self.transform = CGAffineTransformMakeTranslation(_x_offet, 0);
    self.alpha = 0;
    [UIView animateWithDuration:0.8 animations:^(void) {
        self.transform = CGAffineTransformIdentity;
        self.alpha = 0.9;
        
    } completion:^(BOOL finished) {
        if (stopAnimation) {
            stopAnimation();
        }
    }];
}

- (void)swimAnimationDefault:(float)distance
{
    
    if (self.hidden == YES || self.alpha == 0) {
        return;
    }
    
    [UIView animateWithDuration:1.2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.transform = CGAffineTransformMakeTranslation(0, -distance);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:1.2 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            self.transform = CGAffineTransformMakeTranslation(0, distance);
        } completion:^(BOOL finished) {
            [self swimAnimationDefault:distance];
        }];
        
    }];
    
}

//- (void)startAnimationCutom_3dWithTargetViewController:(UIViewController*)vc withBlock:(void(^)(BOOL finished))completion{
//    UIView * containView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height)];
//    [containView addSubview:vc.view];
//    vc.view.alpha = 0;
//    [containView setBackgroundColor:[UIColor clearColor]];
//
//    UIImageView * imageView = [[UIImageView alloc] initWithFrame:self.bounds];
//    imageView.center = CGPointMake(self.superview.center.x, self.superview.center.y);
//    imageView.image = [self returnImageFromView:self];
//
//    imageView.layer.shadowColor = [UIColor blackColor].CGColor;
//    imageView.layer.shadowOffset = CGSizeMake(0,0);
//    imageView.layer.shadowOpacity = .6;
//    imageView.layer.shadowRadius = 5;
//
//    [containView addSubview:imageView];
//
//    [[[UIApplication sharedApplication].delegate window] addSubview:containView];
//
//    float scaleX = kScreen_Width/imageView.frame.size.width;
//    scaleX = scaleX -0.5;
//    [UIView animateWithDuration:0.6 delay:0 options:0 animations:^{
//        imageView.center = CGPointMake(containView.frame.size.width/2,containView.frame.size.height/2);
//        [containView setBackgroundColor:[UIColor whiteColor]];
//
//    } completion:^(BOOL finished) {
//        [self hq_findViewController].navigationController.navigationBarHidden = YES;
//
//        CGPoint point = CGPointMake(0, 0.5);//设定翻转时的中心点，0.5为视图layer的正中
//        CGFloat radiants = -90 * M_PI/ 180;
//        imageView.layer.anchorPoint = point;
//
//        CATransform3D transform =CATransform3DIdentity;//获取一个标准默认的CATransform3D仿射变换矩阵
//        transform.m34=4.5/-2000;//透视效果
//        transform = CATransform3DRotate(transform, radiants, 0.0, 1.0, 0.0);
//        transform = CATransform3DScale(transform,scaleX,scaleX, 1);
//
//
//        vc.view.transform = CGAffineTransformMakeScale(0.8, 0.8);
//        [UIView animateWithDuration:0.5 delay:0.8 options:0 animations:^{
//            vc.view.transform = CGAffineTransformIdentity;
//            vc.view.alpha = 1;
//        } completion:^(BOOL finished) {
//
//        }];
//
//        [UIView animateWithDuration:1.3 delay:0 options:0 animations:^{
//            imageView.center = CGPointMake(10, imageView.center.y);
//            imageView.layer.transform = transform;
//
//        } completion:^(BOOL finished) {
//            imageView.layer.transform = CATransform3DIdentity;
//            vc.view.transform = CGAffineTransformIdentity;
//            [imageView removeFromSuperview];
//            [vc.view removeFromSuperview];
//            [containView removeFromSuperview];
//            if (completion) {
//                completion(YES);
//            }
//
//        }];
//
//    }];
//    return;
//
//}
//
//- (UIImage *)returnImageFromView:(UIView *)view{
//    UIGraphicsBeginImageContextWithOptions(view.size, NO, [UIScreen mainScreen].scale);
//    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
//    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    return img;
//}

- (void)startAnimationCutomSpringInView:(UIView *)view conpleton:(void (^)())stopAnimation
{
    
    CGRect orgFrame = self.frame;
    CGRect fromFrame = CGRectMake(0, view.bounds.size.height, orgFrame.size.width * 0.5, orgFrame.size.height * 0.5);
    self.frame = fromFrame;
    
    POPSpringAnimation *cellSpringAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
    cellSpringAnimation.fromValue = [NSValue valueWithCGRect:fromFrame];
    cellSpringAnimation.toValue = [NSValue valueWithCGRect:orgFrame];
    cellSpringAnimation.springSpeed         = 2;
    cellSpringAnimation.springBounciness    = 5;
    cellSpringAnimation.dynamicsFriction    = 11;
    //    cellSpringAnimation.dynamicsTension     = 100;
    [self pop_addAnimation:cellSpringAnimation forKey:@"cellSpringAnimation"];
    
}

- (void)startAnimationCutomScaleWithView:(UIView *)animationView inView:(UIView *)inView conpleton:(void (^)())stopAnimation
{
    
    POPBasicAnimation *scaleAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    scaleAnimation.fromValue  = [NSValue valueWithCGSize:CGSizeMake(1.0f, 1.0f)];
    scaleAnimation.toValue  = [NSValue valueWithCGSize:CGSizeMake(10.0f, 10.0f)];
    scaleAnimation.duration = 0.5;
    [animationView.layer pop_addAnimation:scaleAnimation forKey:@"scaleAnimation"];
    
    POPBasicAnimation *alphaAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPViewAlpha];
    alphaAnimation.fromValue  = @0.3;
    alphaAnimation.toValue  = @0.0;
    alphaAnimation.duration = 0.5;
    [animationView pop_addAnimation:alphaAnimation forKey:@"alphaAnimation"];
    
    [alphaAnimation setCompletionBlock:^(POPAnimation * animation, BOOL finished) {
        [animationView removeFromSuperview];
        
        if (stopAnimation) {
            stopAnimation();
        }
        
    }];
    
}

- (void)setAnchorPoint:(CGPoint)anchorPoint forView:(UIView *)view
{
    CGPoint newPoint = CGPointMake(view.bounds.size.width * anchorPoint.x, view.bounds.size.height * anchorPoint.y);
    CGPoint oldPoint = CGPointMake(view.bounds.size.width * view.layer.anchorPoint.x, view.bounds.size.height * view.layer.anchorPoint.y);
    
    newPoint = CGPointApplyAffineTransform(newPoint, view.transform);
    oldPoint = CGPointApplyAffineTransform(oldPoint, view.transform);
    
    CGPoint position = view.layer.position;
    
    position.x -= oldPoint.x;
    position.x += newPoint.x;
    
    position.y -= oldPoint.y;
    position.y += newPoint.y;
    
    view.layer.position = position;
    view.layer.anchorPoint = anchorPoint;
}




@end

