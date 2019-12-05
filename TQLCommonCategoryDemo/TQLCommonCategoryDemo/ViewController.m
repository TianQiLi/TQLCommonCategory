//
//  ViewController.m
//  TQLCommonCategoryDemo
//
//  Created by litianqi on 2019/11/6.
//  Copyright © 2019 edu24ol. All rights reserved.
//

#import "ViewController.h"
#import <TQLCommonCategory.h>
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSString * str = @"tstsetsts";
    [[self class] tq_heightWithText:@"sfdfsdf" withRectWishSize:CGSizeMake(100, CGFLOAT_MAX) withLineSpacing:4 withFontSize:16];
    
    
}


@end
