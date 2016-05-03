//
//  CMD_GetUserRelation.h
//  Wutong
//
//  Created by HUANGXUTAO on 15/5/12.
//  Copyright (c) 2015年 HUANGXUTAO. All rights reserved.
//

#import "CMDOP_WT.h"
#import "PublicEnum.h"
@interface CMD_GetUserRelation : CMDOP_WT
{
    HCRelationType  relationType_;
}
@property (nonatomic,assign) int UserID;
@property (nonatomic,assign) int TargetUserID;

- (HCRelationType)relationResult;
@end
