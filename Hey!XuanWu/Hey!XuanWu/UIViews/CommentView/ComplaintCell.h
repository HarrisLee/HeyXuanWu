//
//  ComplaintCell.h
//  Hey!XuanWu
//
//  Created by Cao JianRong on 14-3-10.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ComplaintCell : UITableViewCell
{
    UILabel *nameLabel;
    UILabel *timeLabel;
    UILabel *contentLable;
}
@property (nonatomic, retain) UILabel *nameLabel;
@property (nonatomic, retain) UILabel *timeLabel;
@property (nonatomic, retain) UILabel *contentLable;

-(void) setContent:(CGFloat)height;

-(void) setContent:(CGFloat)height withNothing:(BOOL)flag;

@end
