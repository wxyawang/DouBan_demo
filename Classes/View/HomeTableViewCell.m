//
//  HomeTableViewCell.m
//  My_Instance_project
//
//  Created by bp on 2019/3/19.
//  Copyright © 2019 bp. All rights reserved.
//

#import "HomeTableViewCell.h"
#import "UIView+MJExtension.h"

#define KWIDTH [UIScreen mainScreen].bounds.size.width
#define KHEIGHT  [UIScreen mainScreen].bounds.size.height

#define isiPhone5or5sor5c ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

#define isiPhone6or6sor7 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)

#define isiPhone6plusor6splusor7plusor8plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)

#define isiPhoneXorXs ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

#define isiPhoneXr ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) : NO)

#define isiPhoneXSMax ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) : NO)
@implementation HomeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
}
/**
 *  构造方法(在初始化对象的时候会调用)
 *  一般在这个方法中添加需要显示的子控件
 */
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        _largeImages = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5,100, 120)];
       //_largeImages.contentMode = UIViewContentModeScaleAspectFit;
        
        _moivename = [[UILabel alloc]initWithFrame:CGRectMake(110, 10, 200, 10)];
        [_moivename setFont:[UIFont systemFontOfSize:15]];
        [_moivename setTextColor:[UIColor colorWithRed:41.0/255.0 green:174.0/255.0 blue:140.0/255.0 alpha:1.0]];
        
        _rating = [[UILabel alloc]initWithFrame:CGRectMake(KWIDTH - 40, 10, 30, 15)];
        _rating.textAlignment = NSTextAlignmentCenter;
        _rating.layer.cornerRadius = 5.0f;
        _rating.layer.masksToBounds = true;
        [_rating setBackgroundColor:[UIColor colorWithRed:41.0/255.0 green:174.0/255.0 blue:140.0/255.0 alpha:1.0]];
        [_rating setFont:[UIFont systemFontOfSize:13]];
        [_rating setTextColor:[UIColor whiteColor]];
        
        _genres = [[UILabel alloc]initWithFrame:CGRectMake(110, 35, 200, 10)];
        [_genres setFont:[UIFont systemFontOfSize:13]];
        [_genres setTextColor:[UIColor colorWithRed:41.0/255.0 green:174.0/255.0 blue:140.0/255.0 alpha:1.0]];
        
        _directorsname = [[UILabel alloc]initWithFrame:CGRectMake(110, 60, 200, 10)];
        [_directorsname setFont:[UIFont systemFontOfSize:13]];
        [_directorsname setTextColor:[UIColor colorWithRed:41.0/255.0 green:174.0/255.0 blue:140.0/255.0 alpha:1.0]];
        
        _actorname = [[UILabel alloc]initWithFrame:CGRectMake(110, 85, 200, 10)];
        [_actorname setFont:[UIFont systemFontOfSize:13]];
        [_actorname setTextColor:[UIColor colorWithRed:41.0/255.0 green:174.0/255.0 blue:140.0/255.0 alpha:1.0]];
        
        _year = [[UILabel alloc]initWithFrame:CGRectMake(110, 110  , 200, 10)];
        [_year setFont:[UIFont systemFontOfSize:13]];
        [_year setTextColor:[UIColor colorWithRed:41.0/255.0 green:174.0/255.0 blue:140.0/255.0 alpha:1.0]];
        
        [self.contentView addSubview:_genres];
        [self.contentView addSubview:_moivename];
        [self.contentView addSubview:_directorsname];
        [self.contentView addSubview:_actorname];
        [self.contentView addSubview:_largeImages];
        [self.contentView addSubview:_rating];
        [self.contentView addSubview:_year];

        return self;
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
