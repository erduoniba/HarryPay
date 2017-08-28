//
//  SetViewController.m
//  HarryPay
//
//  Created by Harry.Deng on 15/1/5.
//  Copyright (c) 2015年 Harry.Deng. All rights reserved.
//

#import "SetViewController.h"

#import "ServerHallViewController.h"
#import "ESFWelcomeAnimationView.h"

@interface SetViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *setTView;
STRONG_PROPERTY NSArray *setDataArr;
STRONG_PROPERTY NSArray *setImageArr;

@end

@implementation SetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setBackItemName:@"财富"];
    
    _setDataArr = @[@[@"手机宝令"], @[@"服务大厅", @"关于"]];
    _setImageArr = @[@[@"Icon_OtpPsw"], @[@"Icon_RobotServer", @"Icon_Listabout"]];
}


#pragma mark - viewAction
- (void)safeExit{
    
}


#pragma mark - tableview delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _setDataArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_setDataArr[section] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 15.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 1) {
        return 70;
    }
    return 1.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section == 1) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Main_Size.width, 50)];
        view.backgroundColor = [UIColor clearColor];
        NSLog(@"%f", Main_Size.width);
        UIButton *exitBt = [GlobalMethod BuildButtonWithFrame:CGRectMake(15, 15, Main_Size.width - 30, 40) andOffImg:nil andOnImg:nil withTitle:@"安全退出"];
        [exitBt setBackgroundColor:RGB(220, 50, 70)];
        exitBt.layer.cornerRadius = 4;
        [exitBt addTarget:self action:@selector(safeExit) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:exitBt];
        
        return view;
    }
    
    return nil;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"set_cell" forIndexPath:indexPath];
    cell.textLabel.text = [_setDataArr[indexPath.section] objectAtIndex:indexPath.row];
    cell.imageView.image = GET_IMAGE([_setImageArr[indexPath.section] objectAtIndex:indexPath.row]);
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {
        ESFWelcomeAnimationView *view = [[ESFWelcomeAnimationView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        [self.navigationController.view addSubview:view];
    }else{
        if (indexPath.row == 0) {
            ServerHallViewController *shVC = [ServerHallViewController quickInstance];
            shVC.serverHallUrl = SERVER_HALL_URL;
            shVC.title = @"服务大厅";
            [self.navigationController pushViewController:shVC animated:YES];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
