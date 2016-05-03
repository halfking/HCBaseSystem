//
//  CMD_LikeOrNot.h
//  Wutong
//
//  Created by HUANGXUTAO on 15/5/12.
//  Copyright (c) 2015年 HUANGXUTAO. All rights reserved.
//

#import "CMDOP_WT.h"

@interface CMD_LikeOrNot : CMDOP_WT
@property(nonatomic,assign) long MtvID;
@property(nonatomic,assign) int ObjectType;
@property(nonatomic,assign) BOOL IsLike;
@property(nonatomic,assign) long ObjectUserID;

@end
