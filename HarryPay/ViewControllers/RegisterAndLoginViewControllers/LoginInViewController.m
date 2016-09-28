//
//  RegisterViewController.m
//  HarryPay
//
//  Created by Harry on 15/1/6.
//  Copyright (c) 2015年 Harry. All rights reserved.
//

#import "LoginInViewController.h"

#import "UIViewController+Harry.h"
#import "UIButton+Harry.h"
#import "UIView+Harry.h"

#import "FindPasswordViewController.h"
#import "RegisterViewController.h"

#import "ESFWelcomeAnimationView.h"

LoginInViewController *loginVC;

@interface LoginInViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *platIView;
@property (weak, nonatomic) IBOutlet UIView *loginInView;
@property (weak, nonatomic) IBOutlet UITextField *accountTField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTField;
@property (weak, nonatomic) IBOutlet UIButton *SecureBt;
@property (weak, nonatomic) IBOutlet UIButton *loginBt;
@property (weak, nonatomic) IBOutlet UIButton *platChangeBt;
@property (weak, nonatomic) IBOutlet UIButton *forgetPsBt;
@property (weak, nonatomic) IBOutlet UIButton *registerBt;

@end

@implementation LoginInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (!_isTaoBaoLogin) {
        loginVC = self;
    }
}

- (void)loadView{
    [super loadView];
    
    [self embellishUI];
}

- (void)embellishUI{
    if (_isTaoBaoLogin) {
        _platIView.image = GET_IMAGE(@"taobao_head");
        _accountTField.placeholder = @"手机号/邮箱/会员号";
        _passwordTField.placeholder = @"淘宝登录密码";
        [_platChangeBt setTitle:@"支付宝账户登录" forState:UIControlStateNormal];
        _forgetPsBt.hidden = YES;
        _registerBt.hidden = YES;
    }
    
    _loginInView.layer.cornerRadius = 3;
    _loginInView.layer.borderColor = RGBS(119).CGColor;
    _loginInView.layer.borderWidth = 0.5;
    
    _loginBt.layer.cornerRadius = 3;
    _loginBt.layer.borderWidth = 0.5;
    _loginBt.layer.borderColor = RGB(61, 127, 239).CGColor;
    
    _registerBt.layer.cornerRadius = 3;
    _registerBt.layer.borderWidth = 0.5;
    _registerBt.layer.borderColor = RGB(61, 127, 239).CGColor;
    
    _platIView.layer.cornerRadius = 45;
    _platIView.layer.masksToBounds = YES;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyBoard)];
    [self.view addGestureRecognizer:tap];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - viewAction
- (void)hideKeyBoard{
    [_accountTField resignFirstResponder];
    [_passwordTField resignFirstResponder];
}

- (IBAction)secureChangeAction {
    UIImage *secureOnImage = GET_IMAGE(@"eye_1");       //密文图片
    UIImage *secureOffImage = GET_IMAGE(@"eye_2");      //明文图片
    if (_SecureBt.isSelect) {
        [_SecureBt setImage:secureOnImage forState:UIControlStateNormal];
        _passwordTField.secureTextEntry = YES;
    }else{
        [_SecureBt setImage:secureOffImage forState:UIControlStateNormal];
        _passwordTField.secureTextEntry = NO;
    }
    _SecureBt.isSelect = !_SecureBt.isSelect;
}

- (IBAction)loginInAction {
    if ( (![GlobalMethod isValidateEmail:_accountTField.text]) && (![GlobalMethod isValidateMobile:_accountTField.text]) && (![GlobalMethod isValidateNickName:_accountTField.text]) ) {
        [self.view showHUDAtDelayTimeOnlyLabel:[@"账户名是电子邮箱或是手机号码" localize]];
        return ;
    }
    
    if ( ![GlobalMethod isValidatePassword:_passwordTField.text] ) {
        [self.view showHUDAtDelayTimeOnlyLabel:@"密码错误"];
        return ;
    }
    
    if (_isTaoBaoLogin) {
        [self dismissViewControllerAnimated:NO completion:^{
            [loginVC dismissViewControllerAnimated:YES completion:Nil];
        }];
    }else{
        [self dismissViewControllerAnimated:YES completion:Nil];
    }
}

- (IBAction)platChangeAction:(UIButton *)sender {
    if ([[sender titleForState:UIControlStateNormal] isEqualToString:@"淘宝账户登录"]) {
        LoginInViewController *taobaoLoginVC = GET_STORYBOARD_VC(@"Main", @"LoginInViewController");
        taobaoLoginVC.isTaoBaoLogin = YES;
        taobaoLoginVC.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        [self presentViewController:taobaoLoginVC animated:YES completion:Nil];
    }else{
        [self dismissViewControllerAnimated:YES completion:Nil];
    }
}

- (IBAction)forgetPsAction {
    FindPasswordViewController *fpVC = [FindPasswordViewController quickInstance];
    fpVC.webViewUrl = FIND_PASSWORD_URL;
    UINavigationController *nfpVC = [[UINavigationController alloc] initWithRootViewController:fpVC];
    nfpVC.navigationBar.barStyle = UIBarStyleBlack;
    [self presentViewController:nfpVC animated:NO completion:Nil];
}

- (IBAction)registerAction {
    RegisterViewController *rVC = [RegisterViewController quickInstance];
    rVC.webViewUrl = REGISTER_URL;
    UINavigationController *nrVC = [[UINavigationController alloc] initWithRootViewController:rVC];
    nrVC.navigationBar.barStyle = UIBarStyleBlack;
    [self presentViewController:nrVC animated:NO completion:Nil];
}


#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField == _accountTField) {
        if ( ([GlobalMethod isValidateNickName:_accountTField.text]) || ([GlobalMethod isValidateEmail:_accountTField.text]) || ([GlobalMethod isValidateMobile:_accountTField.text]) ) {
            _platIView.image = GET_IMAGE(STRING_FORMAT(@"mi%d", rand()%3 + 1));
        }else if ([textField.text isEqualToString:@""]){
            if (_isTaoBaoLogin) {
                _platIView.image = GET_IMAGE(@"taobao_head");
            }else{
                _platIView.image = GET_IMAGE(@"alipay_head");
            }
        }
    }
}

@end
