//
//  HomeTableViewCell.h
//  My_Instance_project
//
//  Created by bp on 2019/3/19.
//  Copyright © 2019 bp. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomeTableViewCell : UITableViewCell
@property (nonatomic,strong)UILabel *moivename;
@property (nonatomic,strong)UILabel *year;
@property (nonatomic,strong)UIImageView *largeImages;
@property (nonatomic,strong)UILabel *rating;
@property (nonatomic,strong)UILabel *directorsname;
@property (nonatomic,strong)UILabel *genres;
@property (nonatomic,strong)UILabel *actorname;
@end

NS_ASSUME_NONNULL_END
