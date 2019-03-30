//
//  Home_DetailsViewController.m
//  My_Instance_project
//
//  Created by bp on 2019/3/20.
//  Copyright © 2019 bp. All rights reserved.
//

#import "Home_DetailsViewController.h"
#import "AFNetworking.h"
#import "UIKit+AFNetworking.h"
#import "LYEmptyView.h"
#import "MJRefresh.h"

#define URL_DETAILS  @"https://api.douban.com/v2/movie/subject/"
#define KWIDTH [UIScreen mainScreen].bounds.size.width
#define KHEIGHT  [UIScreen mainScreen].bounds.size.height
@interface Home_DetailsViewController ()
@property (nonatomic,strong)NSMutableArray *dataArray;
@property (nonatomic,strong)UIWebView *webView;
@property (nonatomic,strong)NSString *str;
@end

@implementation Home_DetailsViewController

- (void)viewDidLoad {
    self.view.backgroundColor = [UIColor whiteColor];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self getNetwork];
}

- (void)getUI{
    
}
- (void)getWebView {
    self.webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 64,KWIDTH,KHEIGHT - 64)];
    NSURL *remoteURL = [NSURL URLWithString:self.str];
    NSURLRequest *request =[NSURLRequest requestWithURL:remoteURL];
    [self.webView loadRequest:request];
    [self.view addSubview:self.webView];
}

- (void)getNetwork {
        AFHTTPRequestOperationManager *manger = [AFHTTPRequestOperationManager manager];
        manger.responseSerializer = [AFHTTPResponseSerializer serializer];
        NSString *url = [NSString stringWithFormat:@"%@%@",URL_DETAILS,self.id_page];
        [manger GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [self.dataArray removeAllObjects];
            NSObject *obj  = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
            self.str = [obj valueForKey:@"alt"];
            NSLog(@"str:%@",self.str);
            [self getWebView];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             NSLog(@"访问数据失败的回调");
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
