//
//  TabBarController.m
//  My_Instance_project
//
//  Created by bp on 2019/3/18.
//  Copyright © 2019 bp. All rights reserved.
//

#import "TabBarController.h"
#import "HomeViewController.h"
#import "AlbumViewController.h"
#import "KnowledgeViewController.h"
#import "MyViewController.h"
#import "NavigationViewController.h"
#import "CPFTabBar.h"
@interface TabBarController ()

@end

@implementation TabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // 添加子控制器
    [self initControllers];
    [UITabBar appearance].translucent = NO;
    
}
- (void)initControllers {
    
    [self setupChildVc:[[HomeViewController alloc] init] title:@"首页" image:@"tab_home_default~iphone" selectedImage:@"tab_home_selected~iphone"];
    
    [self setupChildVc:[[AlbumViewController alloc] init] title:@"专辑" image:@"tab_classification_default~iphone" selectedImage:@"tab_classification_selected~iphone"];
    
    [self setupChildVc:[[KnowledgeViewController alloc] init] title:@"知识" image:@"tab_zhishi _default~iphone" selectedImage:@"tab_zhishi_selected~iphone"];
    
    [self setupChildVc:[[MyViewController alloc] init] title:@"我的" image:@"tab_user_default" selectedImage:@"tab_user_selected~iphone"];
    
    // 更换tabBar
    [self setValue:[[CPFTabBar alloc] init] forKeyPath:@"tabBar"];
}
+ (void)initialize
{
    // 通过appearance统一设置所有UITabBarItem的文字属性
    // 后面带有UI_APPEARANCE_SELECTOR的方法, 都可以通过appearance对象来统一设置
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:11];
    attrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSFontAttributeName] = attrs[NSFontAttributeName];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor colorWithRed:41.0/255.0 green:174.0/255.0 blue:140.0/255.0 alpha:1.0];
    
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
}

/**
 * 初始化子控制器
 */
- (void)setupChildVc:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    // 设置文字和图片
    vc.view.backgroundColor = [UIColor whiteColor];
    vc.navigationItem.title = title;
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    // 包装一个导航控制器, 添加导航控制器为tabbarcontroller的子控制器
     //NavigationViewController *nav = [[NavigationViewController alloc] initWithRootViewController:vc];
    NavigationViewController *nav = [[NavigationViewController alloc]initWithRootViewController:vc];
    [self addChildViewController:nav];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
