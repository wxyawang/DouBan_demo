//
//  HomeViewController.m
//  My_Instance_project
//
//  Created by bp on 2019/3/18.
//  Copyright © 2019 bp. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeTableViewCell.h"
#import "HomeModel.h"
#import "AFNetworking.h"
#import "UIKit+AFNetworking.h"
#import "LYEmptyView.h"
#import "MJRefresh.h"
#import "Home_DetailsViewController.h"
#import "AccurateSearch_ViewController.h"
#import "CityListViewController.h"
#import "NSString+BPString.h"
#define KWIDTH [UIScreen mainScreen].bounds.size.width
#define KHEIGHT  [UIScreen mainScreen].bounds.size.height
#define HOME_INTERFACE_URL @"https://api.douban.com/v2/movie/in_theaters?"
//https://api.douban.com/v2/movie/in_theaters?city=广州&start=0&count=10
@interface HomeViewController ()< UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,CityListViewDelegate,CLLocationManagerDelegate>
@property (nonatomic,strong)CLLocationManager *locationManager;
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)UITextField *textField;
@property (nonatomic,strong)HomeModel *model;
@property (nonatomic,strong)UIView *searchBgView;
@property (nonatomic,strong)UILabel *label;
@property (nonatomic, assign)int count;
@property (nonatomic,copy)NSString *city;
@property (nonatomic,strong)NSMutableArray *dataArray;//数据源
@end

@implementation HomeViewController

- (CLLocationManager *)locationManager {
    if (_locationManager == nil) {
        _locationManager = [[CLLocationManager alloc]init];
        _locationManager.delegate = self;
    }
    return _locationManager;
}

- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}
- (void)viewWillAppear:(BOOL)animated {
    [self.textField resignFirstResponder];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self locationPosition];
}

- (void)checkNet {
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
    AFNetworkReachabilityManager *manger = [AFNetworkReachabilityManager sharedManager];
    [manger setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        switch (status) {
            case 0:
                [self alercontroller:0];
                break;
            case 1:
                [self alercontroller:1];
                break;
            case 2:
                [self alercontroller:2];
            default:
                break;
        }
    }];
    [manger startMonitoring];
}

- (void)alercontroller:(int)stu {
    if (stu == 0) {
        self.label = [UILabel new];
        self.label.frame = CGRectMake(40, 70 , self.view.frame.size.width - 80, 30);
        self.label.layer.cornerRadius = 12;
        self.label.layer.masksToBounds = YES;
        self.label.text = @"网络请求失败，请检查您的网络";
        self.label.textColor = [UIColor whiteColor];
        self.label.backgroundColor = [UIColor grayColor];
        self.label.font = [UIFont boldSystemFontOfSize:12];
        self.label.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:self.label];
        NSLog(@"没有网络");
    } else if (stu == 1) {
        self.label.hidden = YES;
       // [self getInterDataArrsy];
        [self initTableViewUI];
         [self addRefresh];
        NSLog(@"移动蜂窝网络");
    }else if (stu == 2) {
        self.label.hidden = YES;
        [self initTableViewUI];
        [self addRefresh];
        NSLog(@"wifi网络");
    }
}

- (void)getInterDataArrsy {
    AFHTTPRequestOperationManager *manger = [AFHTTPRequestOperationManager manager];
    NSDictionary *paramDict;
 
    if (self.locatStr == nil) {
        paramDict = @{@"start":@"0",@"count":@(_count)};
        NSLog(@"空");
    }else{
        paramDict = @{@"city":self.locatStr,@"start":@"0",@"count":@(_count)};
        NSLog(@"不空");
    }
    
    manger.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manger GET:HOME_INTERFACE_URL parameters:paramDict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self.dataArray removeAllObjects];
        NSObject *obj  = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        NSArray *subjectsArray = [obj valueForKey:@"subjects"];
        for (NSDictionary *dict in subjectsArray) {
            self.model = [[HomeModel alloc]init];
            self.model.year = dict[@"year"];
            self.model.moivename = dict[@"title"];
            self.model.idpage = dict[@"id"];
            self.model.largeImages = dict[@"images"][@"large"];
            self.model.rating = dict[@"rating"][@"average"];
            NSArray *arry = dict[@"genres"];
            for (NSString *str in arry) {
                self.model.genres = str;
            }
            for (NSObject *obj in dict[@"directors"]) {
                self.model.directorsname = [obj valueForKey:@"name"];
            }
            for (NSObject *obj in dict[@"casts"]) {
                self.model.actorname = [obj valueForKey:@"name"];
            }
            [self.dataArray addObject:self.model];
        }
           [self.tableView.mj_footer endRefreshingWithNoMoreData];
           [self.tableView reloadData];
    
      NSLog(@"访问数据成功的回调");
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
       NSLog(@"访问数据失败的回调");
    }];
}

- (void)addRefresh {
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(upFreshLoadMoreData)];
    [self.tableView.mj_footer beginRefreshing];
}
- (void)downFreshloadData {

    [self getInterDataArrsy];
   NSLog(@"下拉加载更多");
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC));
    dispatch_after(time, dispatch_get_main_queue(), ^{
        [self.tableView.mj_header endRefreshing];
    });
}
- (void)upFreshLoadMoreData {
    self.count +=10;
    [self getInterDataArrsy];
    NSLog(@"上拉加载更多");
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC));
    dispatch_after(time, dispatch_get_main_queue(), ^{
        [self.tableView.mj_footer endRefreshing];
    });
}
- (void)initTableViewUI {
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64,KWIDTH,KHEIGHT - 64) style:UITableViewStylePlain];
    [self cellLineMoveLeft];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[HomeTableViewCell class] forCellReuseIdentifier:@"homeCell"];
    [self.view addSubview:self.tableView];
    
}
- (void)cellLineMoveLeft {
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([self.tableView  respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView  setLayoutMargins:UIEdgeInsetsZero];
    }
}
#pragma mark - UitableviewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 130;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"homeCell";
    HomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell  == nil) {
        cell  = [[HomeTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    cell .selectionStyle = UITableViewCellSelectionStyleNone;
    self.model = self.dataArray[indexPath.row];
    cell.moivename.text = self.model.moivename;
    cell.year.text = [NSString stringWithFormat:@"%@年作品",self.model.year];
    cell.directorsname.text = [NSString stringWithFormat:@"导演 : %@",self.model.directorsname];
    cell.genres.text = [NSString stringWithFormat:@"类型 : %@",self.model.genres];
    cell.rating.text = [NSString stringWithFormat:@"%.1f",[ [self.model.rating stringValue] floatValue]];;
    cell.actorname.text = [NSString stringWithFormat:@"演员 : %@",self.model.actorname];
    if (self.tableView.dragging == NO && self.tableView.decelerating == NO)
    {
        [cell.largeImages setImageWithURL:[NSURL URLWithString:self.model.largeImages]];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Home_DetailsViewController *hvc = [[Home_DetailsViewController alloc]init];
    HomeModel *model = self.dataArray[indexPath.row];
    hvc.id_page = model.idpage;
    [self.navigationController pushViewController:hvc animated:YES];
}

- (void)bgView{
    self.searchBgView = [[UIView alloc]init];
    self.searchBgView.frame = CGRectMake(0, 0, KHEIGHT, 64);
    self.searchBgView.backgroundColor = [UIColor colorWithRed:41.0/255.0 green:174.0/255.0 blue:140.0/255.0 alpha:1.0];
    [self getSearchTextField];
    [self leftBarButton];
    self.navigationItem.titleView = self.searchBgView;
}

-(void)getSearchTextField {
    self.textField = [[UITextField alloc]initWithFrame:CGRectMake(40, 0, KWIDTH - 55, 30)];
    self.textField.delegate = self;
    NSString *holderText = @" 🔍搜索电视剧/电影/演员";
    self.textField.leftView = [[UIView alloc]initWithFrame:CGRectMake(self.textField.frame.origin.x, self.textField.frame.origin.y, 10, 0)];
    self.textField.leftView.userInteractionEnabled = NO;
    self.textField.leftViewMode = UITextFieldViewModeAlways;
    self.textField.textAlignment = NSTextAlignmentLeft;
    NSMutableAttributedString *placeholder = [[NSMutableAttributedString alloc] initWithString:holderText];
    [placeholder addAttribute:NSForegroundColorAttributeName
                        value:[UIColor grayColor]
                        range:NSMakeRange(0, holderText.length)];
    [placeholder addAttribute:NSFontAttributeName
                        value:[UIFont boldSystemFontOfSize:14.0]
                        range:NSMakeRange(0, holderText.length)];
    self.textField.attributedPlaceholder = placeholder;
    self.textField.keyboardType = UIKeyboardTypeDefault;
    [self.textField setBackgroundColor:[UIColor whiteColor]];
    self.textField.layer.cornerRadius = 5;
    [self.textField addTarget:self action:@selector(clickTextField) forControlEvents:UIControlEventTouchDown];
    [self.searchBgView addSubview:self.textField];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.textField resignFirstResponder];
    return YES;
}
- (void)leftBarButton {
    self.locatButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.locatButton.titleLabel setFont:[UIFont systemFontOfSize:12.0]];
    self.locatButton.frame = CGRectMake(0, 0, 40, 30);
    [self.locatButton setTitle:self.locatStr forState:UIControlStateNormal];
    NSLog(@"self.locatSt:%@",self.locatStr);
    [self.locatButton setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];
    [self.locatButton addTarget:self action:@selector(leftBlick) forControlEvents:UIControlEventTouchDown];
    [self.searchBgView addSubview:self.locatButton];
}

- (void)leftBlick {
 
    CityListViewController *cityListView = [[CityListViewController alloc]init];
    cityListView.delegate = self;
    //热门城市列表
    cityListView.arrayHotCity = [NSMutableArray arrayWithObjects:@"广州",@"北京",@"天津",@"厦门",@"重庆",@"福州",@"泉州",@"济南",@"深圳",@"长沙",@"无锡", nil];
    //历史选择城市列表
    cityListView.arrayHistoricalCity = [NSMutableArray arrayWithObjects:@"福州",@"厦门",@"泉州", nil];
    //定位城市列表
    cityListView.arrayLocatingCity   = [NSMutableArray arrayWithObjects:self.locatStr, nil];
    
    [self presentViewController:cityListView animated:YES completion:nil];
}

- (void)clickTextField {
    AccurateSearch_ViewController *avc = [[AccurateSearch_ViewController alloc]init];
    [self.navigationController pushViewController:avc animated:YES];
}

- (void)didClickedWithCityName:(NSString*)cityName {
    self.locatStr = cityName;
    [self.locatButton setTitle:self.locatStr forState:UIControlStateNormal];
}

- (void)locationPosition {
    
    //横向移动多少距离后更新位置信息(米)
    self.locationManager.distanceFilter = 1000;
    
    /*
     desiredAccuracy:位置的精度属性
     
     kCLLocationAccuracyBest                精确度最佳
     kCLLocationAccuracynearestTenMeters    精确度10m以内
     kCLLocationAccuracyHundredMeters       精确度100m以内
     kCLLocationAccuracyKilometer           精确度1000m以内
     kCLLocationAccuracyThreeKilometers     精确度3000m以内
     */
    self.locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers;
    
    //开启位置更新
    [self.locationManager startUpdatingLocation];
    
    NSLog(@"开始定位");
    
    
    //停止位置更新
    //    [self.locationManager stopUpdatingLocation];
    
}

#pragma mark - 定位代理失败回调
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"%@", error);
}

#pragma mark - 定位代理更新位置成功回调

-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    switch (status)
    {case kCLAuthorizationStatusNotDetermined:
        {if ([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
            [self.locationManager requestAlwaysAuthorization];
            [self.locationManager requestWhenInUseAuthorization];
            NSLog(@"用户已经授权");
            
        }
            NSLog(@"用户还未决定授权");
            break;
            
        }case kCLAuthorizationStatusRestricted:
        {
            NSLog(@"访问受限");
            break;
            
        }
        case kCLAuthorizationStatusDenied:
        {// 类方法，判断是否开启定位服务
            if ([CLLocationManager locationServicesEnabled])
            {
                NSLog(@"定位服务开启，被拒绝");
                
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"定位服务未开启" message:@"请在系统设置中开启定位服务" preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction *okButton = [UIAlertAction actionWithTitle:@"去设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                    
                    NSString* phoneVersion = [[UIDevice currentDevice] systemVersion];
                    if (phoneVersion.floatValue < 10.0) {
                        //iOS10 以前使用
                        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"App-Prefs:root=Privacy&path=LOCATION"]];
                    }
                    else {
                        //iOS10 以后使用
                        if (@available(iOS 10.0, *)) {
                            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"App-Prefs:root=Privacy&path=LOCATION"]
                                                               options:@{}
                                                     completionHandler:nil];
                        } else {
                            
                        }
                    }
                    
                }];
                UIAlertAction *cancelButton = [UIAlertAction actionWithTitle:@"暂不" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                    // Do something after clicking Cancel button
                }];
                [alert addAction:okButton];
                [alert addAction:cancelButton];
                
                [self presentViewController:alert animated:YES completion:nil];
                
            }
            else {
                NSLog(@"定位服务关闭，不可用");
                
            }
            break;
            
        }
        case kCLAuthorizationStatusAuthorizedAlways:
        {
            NSLog(@"获得前后台授权");
            break;
            
        }case kCLAuthorizationStatusAuthorizedWhenInUse:
        {
            NSLog(@"获得前台授权");
            break;
            
        }
        default:
            break;
            
    }}
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    //防止定位多次被调用
    [manager stopUpdatingLocation];
    manager.delegate = nil;
    
    CLGeocoder * geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:[locations lastObject] completionHandler:^(NSArray *placemarks, NSError *error) {
        if (error || placemarks.count==0) {
            NSLog(@"%@",error);
        }else{
            //取出获取的地理信息数组中的第一个
            CLPlacemark *firstPlacemark = [placemarks firstObject];
            self.locatStr = [[firstPlacemark.addressDictionary objectForKey:@"City"] getStringWithPattern:@"(.*)市$"];
            NSLog(@"self.locatStr:%@",self.locatStr);
            
            [self bgView];
            [self getInterDataArrsy];
            [self checkNet];
           
            
            //                        NSString *Country = [firstPlacemark.addressDictionary objectForKey:@"Country"];
            //                        NSLog(@"Country:%@",Country);
            //
            //                        NSString *CountryCode = [firstPlacemark.addressDictionary objectForKey:@"CountryCode"];
            //                        NSLog(@"CountryCode:%@",CountryCode);
            //
            //                        NSString *FormattedAddressLines = [firstPlacemark.addressDictionary objectForKey:@"FormattedAddressLines"];
            //                        NSLog(@"FormattedAddressLines:%@",FormattedAddressLines);
            //
            //                        NSString *Name = [firstPlacemark.addressDictionary objectForKey:@"Name"];
            //                        NSLog(@"Name:%@",Name);
            //
            //                        NSString *State = [firstPlacemark.addressDictionary objectForKey:@"State"];
            //                        NSLog(@"State:%@",State);
            //
            //                        NSString *Street = [firstPlacemark.addressDictionary objectForKey:@"Street"];
            //                        NSLog(@"Street:%@",Street);
            //
            //                        NSString *SubLocality = [firstPlacemark.addressDictionary objectForKey:@"SubLocality"];
            //                        NSLog(@"SubLocality:%@",SubLocality);
            //
            //                        NSString *SubThoroughfare = [firstPlacemark.addressDictionary objectForKey:@"SubThoroughfare"];
            //                        NSLog(@"SubThoroughfare:%@",SubThoroughfare);
            //
            //                        NSString *Thoroughfare = [firstPlacemark.addressDictionary objectForKey:@"Thoroughfare"];
            //                        NSLog(@"Thoroughfare:%@",Thoroughfare);
            //
            
        }
        
    }];
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
