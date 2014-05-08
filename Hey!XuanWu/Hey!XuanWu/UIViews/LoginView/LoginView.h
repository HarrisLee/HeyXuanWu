//
//  LoginView.h
//  Hey!XuanWu
//
//  Created by Cao JianRong on 14-2-10.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LoginViewDelegate <NSObject>

-(void)loginInServer:(id)sender;

-(void)cancleLogin:(id)sender;

-(void)registerInService:(NSString *) name WithPwd:(NSString *)pwd WithRureName:(NSString *)tname WithJob:(NSString *)job WithMobile:(NSString *)mobile;

@end

@interface LoginView : UIView <UITextFieldDelegate>
{
    UIImageView *topView;
    UITextField *nameField;
    UITextField *passField;
    id<LoginViewDelegate> delegate;
    
    UIView *registerView;
    
}
@property (nonatomic,retain) UITextField *nameField;
@property (nonatomic,retain) UITextField *passField;
@property (nonatomic,assign) id<LoginViewDelegate> delegate;
@property (nonatomic,retain) UIView *registerView;

@end
