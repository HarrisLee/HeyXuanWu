//
//  GetImgListRespBody.h
//  Hey!XuanWu
//
//  Created by Cao JianRong on 14-3-5.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import "RespBody.h"
#import "ImageModel.h"

@interface GetImgListRespBody : RespBody
{
    NSMutableArray *imageList;
}
@property (nonatomic, retain) NSMutableArray *imageList;
@end
