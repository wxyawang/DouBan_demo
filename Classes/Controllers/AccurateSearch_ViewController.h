//
//  AccurateSearch_ViewController.h
//  My_Instance_project
//
//  Created by bp on 2019/3/22.
//  Copyright © 2019 bp. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface AccurateSearch_ViewController : UIViewController
@property (nonatomic,strong)UIButton *canCelButton;
@property (nonatomic,strong)NSString *locatStr;
- (void)getInterDataArrsy ;
- (void)getSearchTextField;

@end

NS_ASSUME_NONNULL_END
