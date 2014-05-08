//
//  OutLoginViewController.h
//  Hey!XuanWu
//
//  Created by Cao JianRong on 14-3-7.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import "CommonViewController.h"
#import "OutLoginView.h"
#import "AddPeopleAccountReqBody.h"
#import "AddPeopleAccountRespBody.h"
#import "VerifyOutsideLoginReqBody.h"
#import "VerifyOutsideLoginRespBody.h"

@interface OutLoginViewController : CommonViewController<OutLoginViewDelegate>
{
    OutLoginView *login;
    NSString *nameReg;
}
@end
