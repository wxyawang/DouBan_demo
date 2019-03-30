//
//  NavigationViewController.m
//  Best friend is best
//
//  Created by bp on 2019/3/13.
//  Copyright © 2019 bp. All rights reserved.
//

#import "NavigationViewController.h"

@interface NavigationViewController ()

@end

@implementation NavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // interactivePopGestureRecognizer代理会让导航控制器重新设置右划返回功能
    self.interactivePopGestureRecognizer.delegate = (id)self;
    // Do any additional setup after loading the view.
}

+ (void)initialize
{
    // 当导航栏用在CPFNavigationController中, appearance设置才会生效
    UINavigationBar *bar = [UINavigationBar appearance];
    [bar setBarTintColor:[UIColor colorWithRed:41.0/255.0 green:174.0/255.0 blue:140.0/255.0 alpha:1.0]];
    [bar setBarStyle:UIBarStyleBlack];
    [bar setTitleTextAttributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:18]}];
    
    // 设置导航栏UIBarButtonItem文字颜色
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    
    // 默认状态
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = [UIColor yellowColor];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:17];
    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    // enable状态
    NSMutableDictionary *disableAttrs = [NSMutableDictionary dictionary];
    disableAttrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    disableAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:17];
    [item setTitleTextAttributes:disableAttrs forState:UIControlStateDisabled];
}

/**
 * 可以在这个方法中拦截所有push进来的控制器
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
    if (self.childViewControllers.count > 0) { // 如果push进来的不是第一个控制器
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"返回" forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];
        //[button setImage:[UIImage imageNamed:@"navigationButtonReturnClick"] forState:UIControlStateHighlighted];
        button.frame = CGRectMake(0, 0, 70, 30);
        // 让按钮内部的所有内容左对齐
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        //        [button sizeToFit];
        // 让按钮的内容往左边偏移10
        button.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        //[button setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        
        // 修改导航栏左边的item
        // 重写导航栏左边的navigationItem会导致右划返回手势失效
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
        
        // 隐藏tabbar
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    // 这句super的push要放在后面, 让以后push进来的viewController可以覆盖上面设置的leftBarButtonItem
    // 如果放到前面，就会使上面设置的leftBarButtonItem覆盖掉push进来的控制器自定义的leftBarButtonItem
    [super pushViewController:viewController animated:animated];
}

- (void)back
{
    [self popViewControllerAnimated:YES];
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
