//
//  AddGoodRespBody.m
//  Hey!XuanWu
//
//  Created by Cao JianRong on 14-3-5.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import "AddGoodRespBody.h"

@implementation AddGoodRespBody
@synthesize result;

-(void) setValue:(id)value
{
    self.result = value;
}

-(void) dealloc
{
    [result release];
    [super dealloc];
}

@end
