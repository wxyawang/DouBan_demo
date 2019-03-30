//
//  TabBarController.m
//  My_Instance_project
//
//  Created by bp on 2019/3/18.
//  Copyright © 2019 bp. All rights reserved.
//

#import "CPFPushGuideView.h"

@implementation CPFPushGuideView

+ (void)show {
    
    NSString *key = @"CFBundleShortVersionString";
   
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    NSString *sanBoxVersion = [[NSUserDefaults standardUserDefaults] stringForKey:key];
    
    if (![currentVersion isEqualToString:sanBoxVersion]) {
        
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        CPFPushGuideView *guideView = [CPFPushGuideView guideView];
        guideView.frame = window.bounds;
        [window addSubview:guideView];
        
        [[NSUserDefaults standardUserDefaults] setValue:currentVersion forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
}

+ (instancetype)guideView {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

- (IBAction)closePushGuideView {
    
    [self removeFromSuperview];
}

@end
