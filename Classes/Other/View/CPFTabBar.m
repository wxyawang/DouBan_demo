//
//  TabBarController.h
//  My_Instance_project
//
//  Created by bp on 2019/3/18.
//  Copyright © 2019 bp. All rights reserved.
//

#import "CPFTabBar.h"
//#import "CPFPublishViewController.h"

@interface CPFTabBar ()
/** 发布按钮 */
@property (nonatomic, weak) UIButton *publishButton;

@end

@implementation CPFTabBar

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // 设置tabbar的背景图片
        [self setBackgroundImage:[UIImage imageNamed:@"tabbar-light"]];
        
        // 添加发布按钮
        UIButton *publishButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [publishButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [publishButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        [publishButton addTarget:self action:@selector(publishClick) forControlEvents:UIControlEventTouchUpInside];
        
       // publishButton.size = publishButton.currentBackgroundImage.size;
        [self addSubview:publishButton];
        self.publishButton = publishButton;
    }
    return self;
}

- (void)publishClick {
  
}

@end
