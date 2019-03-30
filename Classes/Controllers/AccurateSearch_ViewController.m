//
//  AccurateSearch_ViewController.m
//  My_Instance_project
//
//  Created by bp on 2019/3/22.
//  Copyright © 2019 bp. All rights reserved.
//

#import "AccurateSearch_ViewController.h"
#import "HomeViewController.h"
#import "HomeTableViewCell.h"
#import "HomeModel.h"
#import "AFNetworking.h"
#import "UIKit+AFNetworking.h"
#import "LYEmptyView.h"
#import "MJRefresh.h"
#import "Home_DetailsViewController.h"
#import "CityListViewController.h"
#import "NSString+BPString.h"
#define KWIDTH [UIScreen mainScreen].bounds.size.width
#define KHEIGHT  [UIScreen mainScreen].bounds.size.height

#define SEARCH_URL @"https://api.douban.com/v2/movie/search?"
// https://api.douban.com/v2/movie/search?q=神秘巨星&start=0&count=10
//https://api.douban.com/v2/movie/search?tag=喜剧&start=0&count=10
//https://api.douban.com/v2/movie/in_theaters?city=广州&start=0&count=10
@interface AccurateSearch_ViewController ()< UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,copy)NSString *typeMoive;
@property (nonatomic,strong)UITextField *textField;
@property (nonatomic,strong)HomeModel *model;
@property (nonatomic,strong)UILabel *label;
@property (nonatomic, assign)int count;
@property (nonatomic,copy)NSString *city;
@property (nonatomic,strong)UIView *searchBgView;
@property (nonatomic,strong)NSMutableArray *dataArray;//数据源
@end

@implementation AccurateSearch_ViewController

- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}
- (void)viewWillAppear:(BOOL)animated {
    [self.textField becomeFirstResponder];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initTableViewUI];
    [self bgView];
}

- (void)getInterDataArrsy {
    AFHTTPRequestOperationManager *manger = [AFHTTPRequestOperationManager manager];
    NSDictionary *paramDict;
    
    if (self.typeMoive == nil) {
        paramDict = @{@"start":@"0",@"count":@(_count)};
        NSLog(@"空");
    }if (self.typeMoive != nil) {
        paramDict = @{@"q":self.typeMoive,@"start":@"0",@"count":@(_count)};
        NSLog(@"不空");
    }
    
    manger.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manger GET:SEARCH_URL parameters:paramDict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self.dataArray removeAllObjects];
        NSObject *obj  = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        NSArray *subjectsArray = [obj valueForKey:@"subjects"];
        NSLog(@"subjects:%@",subjectsArray);
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
            
            NSLog(@"self.dataArray:%@",self.dataArray);
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
    self.count +=20;
    [self getInterDataArrsy];
    NSLog(@"上拉加载更多");
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC));
    dispatch_after(time, dispatch_get_main_queue(), ^{
        [self.tableView.mj_footer endRefreshing];
    });
}
- (void)initTableViewUI {
    self.navigationItem.leftBarButtonItem = nil;
    [self.navigationItem setHidesBackButton:YES];
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
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
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
#pragma mark ---searchBar delegate

- (void)bgView {
    self.searchBgView = [[UIView alloc]init];
    self.searchBgView.frame = CGRectMake(0, 0, KHEIGHT, 64);
    self.searchBgView.backgroundColor = [UIColor colorWithRed:41.0/255.0 green:174.0/255.0 blue:140.0/255.0 alpha:1.0];
     [self getSearchTextField];
    [self rightBarButton];
   // [self.view addSubview:self.searchBgView];
    self.navigationItem.titleView = self.searchBgView;
}

- (void)getSearchTextField {
    self.textField = [[UITextField alloc]initWithFrame:CGRectMake(5,0, KWIDTH - 60, 30)];
    self.textField.delegate = self;
    NSString *holderText = @"🔍搜索你想要的资源";
    self.textField.leftView = [[UIView alloc]initWithFrame:CGRectMake(self.textField.frame.origin.x, self.textField.frame.origin.y, 8, 0)];
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
    [self.textField setTintColor:[UIColor grayColor]];
    self.textField.enablesReturnKeyAutomatically = YES;
    self.textField.returnKeyType = UIReturnKeySearch;
    self.textField.attributedPlaceholder = placeholder;
    self.textField.keyboardType = UIKeyboardTypeDefault;
    [self.textField setBackgroundColor:[UIColor whiteColor]];
    self.textField.layer.cornerRadius = 5;
    [self.textField addTarget:self action:@selector(clickTextField) forControlEvents:UIControlEventTouchDown];
    [self.searchBgView addSubview:self.textField];
   
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    self.typeMoive = self.textField.text;
    [self initTableViewUI];
    [self addRefresh];
    return YES;
}
- (void)clickTextField {
    self.typeMoive = self.textField.text;
}

- (void)rightBarButton {
    self.canCelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.canCelButton setTitle:@"取消" forState:UIControlStateNormal];
    self.canCelButton.frame = CGRectMake( KWIDTH - 60, 0, 40, 30);
    self.canCelButton.titleLabel.font = [UIFont systemFontOfSize: 14.0];
    self.canCelButton.contentHorizontalAlignment=UIControlContentHorizontalAlignmentRight;
    self.canCelButton.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    [self.canCelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.canCelButton addTarget:self action:@selector(rightItemCancelClick) forControlEvents:UIControlEventTouchUpInside];
    //self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.canCelButton];
    [self.searchBgView addSubview:self.canCelButton];
    
}

- (void)rightItemCancelClick {
    [self.navigationController popViewControllerAnimated:YES];
    //[self dismissViewControllerAnimated:YES completion:nil];
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
