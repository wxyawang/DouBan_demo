//
//  HomeViewController.h
//  My_Instance_project
//
//  Created by bp on 2019/3/18.
//  Copyright © 2019 bp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
NS_ASSUME_NONNULL_BEGIN

@interface HomeViewController : UIViewController
@property (nonatomic,strong)UIButton *locatButton;
@property (nonatomic,strong)NSString *locatStr;
- (void)getInterDataArrsy ;
- (void)leftBarButton;
- (void)checkNet;
- (void)getSearchTextField;
- (void)locationPosition;
@end

NS_ASSUME_NONNULL_END
