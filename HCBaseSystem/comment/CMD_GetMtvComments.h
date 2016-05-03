//
//  CMD_GetMtvComments.h
//  Wutong
//
//  Created by HUANGXUTAO on 15/5/30.
//  Copyright (c) 2015年 HUANGXUTAO. All rights reserved.
//

#import "CMDOP_WT.h"

@interface CMD_GetMtvComments : CMDOP_WT

@property(assign,nonatomic) long ObjectID;
@property(assign,nonatomic) long ObjectType;
@property(assign,nonatomic) long Durance;
@property(assign,nonatomic) long QAID;//唯一表示
@property(assign,nonatomic) int PageSize;
@property(assign,nonatomic) int PageIndex;

/** 
 CreateDate_DESC = 0,//默认
 CreateDate_ASC = 1,
 Durance_DESC = 2,
 */
@property (nonatomic,assign) int OrderType; // 排序方式
@end
