//
//  LoginView.h
//  Hey!XuanWu
//
//  Created by Cao JianRong on 14-2-10.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol OutLoginViewDelegate <NSObject>

-(void)outloginInServer:(id)sender;

-(void)outcancleLogin:(id)sender;

-(void)outregisterInService:(NSString *) name WithMobile:(NSString *)mobile;

@end

@interface OutLoginView : UIView <UITextFieldDelegate>
{
    UIImageView *topView;
    UITextField *nameField;
    UITextField *passField;
    id<OutLoginViewDelegate> delegate;
    
    UIView *registerView;
    
}
@property (nonatomic,retain) UITextField *nameField;
@property (nonatomic,retain) UITextField *passField;
@property (nonatomic,assign) id<OutLoginViewDelegate> delegate;
@property (nonatomic,retain) UIView *registerView;

@end
