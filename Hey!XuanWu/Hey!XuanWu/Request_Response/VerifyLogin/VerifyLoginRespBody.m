//
//  VerifyLoginRespBody.m
//  Hey!XuanWu
//
//  Created by Cao JianRong on 14-3-5.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import "VerifyLoginRespBody.h"

@implementation VerifyLoginRespBody
@synthesize isVerify;

-(void) setValue:(id)value
{
    self.isVerify = value;
}

-(void) dealloc
{
    [isVerify release];
    [super dealloc];
}

@end
