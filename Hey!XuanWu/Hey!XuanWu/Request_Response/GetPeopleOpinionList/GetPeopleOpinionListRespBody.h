//
//  GetPeopleOpinionListRespBody.h
//  Hey!XuanWu
//
//  Created by Cao JianRong on 14-3-5.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import "RespBody.h"
#import "PeopleOptinModel.h"

@interface GetPeopleOpinionListRespBody : RespBody
{
    NSMutableArray *peopleOptinArray;
}
@property (nonatomic, retain) NSMutableArray *peopleOptinArray;
@end
