//
//  TreasureViewController.m
//  HarryPay
//
//  Created by Harry.Deng on 14/12/30.
//  Copyright (c) 2014年 Harry.Deng. All rights reserved.
//

#import "TreasureViewController.h"

#import "HPBaseModel.h"

/******************
 *  财富界面对象
 ******************/
/******************************************************************************************************************************/
@interface TreasureViewObj : HPBaseModel

STRONG_PROPERTY NSString    *tvo_title;
STRONG_PROPERTY NSString    *tvo_detailTitle;
STRONG_PROPERTY NSString    *tvo_imageUrl;
STRONG_PROPERTY NSString    *tvo_defaultImageName;

+ (instancetype)initWithTitle:(NSString *)title
                  detailTitle:(NSString *)detailTitle
             defaultImageName:(NSString *)defaultImageName;

+ (instancetype)initWithTitle:(NSString *)title
                  detailTitle:(NSString *)detailTitle
             defaultImageName:(NSString *)defaultImageName
                     imageUrl:(NSString *)imageUrl;

@end

@implementation TreasureViewObj

+ (instancetype)initWithTitle:(NSString *)title
                  detailTitle:(NSString *)detailTitle
             defaultImageName:(NSString *)defaultImageName
{
    return [self initWithTitle:title detailTitle:detailTitle defaultImageName:defaultImageName imageUrl:nil];
}

+ (instancetype)initWithTitle:(NSString *)title
                  detailTitle:(NSString *)detailTitle
             defaultImageName:(NSString *)defaultImageName
                     imageUrl:(NSString *)imageUrl
{
    TreasureViewObj *tvo = [[TreasureViewObj alloc] init];
    tvo.tvo_title = title;
    tvo.tvo_detailTitle = detailTitle;
    tvo.tvo_defaultImageName = defaultImageName;
    tvo.tvo_imageUrl = imageUrl;
    return tvo;
}

@end
/******************************************************************************************************************************/



@interface TreasureViewController () <UITableViewDataSource, UITableViewDelegate>
{
    NSArray     *identifierArr;
}

WEAK_PROPERTY IBOutlet UITableView    *treasureTView;
STRONG_PROPERTY NSMutableArray *treasureDataArr;

@end

@implementation TreasureViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    identifierArr = @[@"account_cell", @"right_detail_cell", @"basi_detail_cell", @"basi_detail_cell", @"basi_detail_cell"];

    _treasureDataArr = [NSMutableArray arrayWithArray:
                        @[@[[TreasureViewObj initWithTitle:@"黎蓓" detailTitle:@"328418417@qq.com" defaultImageName:@"account_default_image" imageUrl:@""]],
                          @[[TreasureViewObj initWithTitle:@"账户余额" detailTitle:@"43.12" defaultImageName:@"account_balance"],
                            [TreasureViewObj initWithTitle:@"我的银行卡" detailTitle:@"5 张" defaultImageName:@"my_bankCart"]],
                          @[[TreasureViewObj initWithTitle:@"余额宝" detailTitle:@"" defaultImageName:@"balance_precious"]],
                          @[[TreasureViewObj initWithTitle:@"我的保障" detailTitle:@"" defaultImageName:@"my_safeguard"]],
                          @[[TreasureViewObj initWithTitle:@"爱心捐赠" detailTitle:@"" defaultImageName:@"love_donation"]]]];
    
}


#pragma mark - tableview delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _treasureDataArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_treasureDataArr[section] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 80.0;
    }
    
    return 50.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 15.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1.0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierArr[indexPath.section]];
    TreasureViewObj *tvo = [_treasureDataArr[indexPath.section] objectAtIndex:indexPath.row];
    cell.textLabel.text = tvo.tvo_title;
    cell.detailTextLabel.text = tvo.tvo_detailTitle;
    cell.imageView.image = GET_IMAGE(tvo.tvo_defaultImageName);
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
