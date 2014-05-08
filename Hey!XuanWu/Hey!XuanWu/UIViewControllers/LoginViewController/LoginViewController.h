//
//  LoginViewController.h
//  Hey!XuanWu
//
//  Created by Cao JianRong on 14-2-10.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import "CommonViewController.h"
#import "LoginView.h"
#import "VerifyLoginReqBody.h"
#import "VerifyLoginRespBody.h"
#import "AddAccountReqBody.h"
#import "AddAccountRespBody.h"

@interface LoginViewController : CommonViewController<LoginViewDelegate>
{
    LoginView *login;
    NSString *nameReg;
}
@end
