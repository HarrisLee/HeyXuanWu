//
//  VerifyOutsideLoginReqBody.m
//  Hey!XuanWu
//
//  Created by Cao JianRong on 14-3-5.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import "VerifyOutsideLoginReqBody.h"

@implementation VerifyOutsideLoginReqBody
@synthesize name;
@synthesize password;

-(void) dealloc
{
    [name release];
    [password release];
    [super dealloc];
}
@end
