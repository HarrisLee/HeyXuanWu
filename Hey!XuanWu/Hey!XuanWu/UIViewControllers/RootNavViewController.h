//
//  RootNavViewController.h
//  Hey!XuanWu
//
//  Created by Melo on 13-6-13.
//  Copyright (c) 2013年 Melo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IndexViewController.h"
#import "WelcomeViewController.h"
#import "UINavigationBar+Customer.h"

@interface RootNavViewController : UINavigationController {
    WelcomeViewController  *welcomeController;
}

+(RootNavViewController*)shareInstance;

@end
