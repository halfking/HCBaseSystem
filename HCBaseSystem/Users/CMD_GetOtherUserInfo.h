//
//  CMD_GetOtherUserInfo.h
//  maiba
//
//  Created by Matthew on 16/1/7.
//  Copyright © 2016年 seenvoice.com. All rights reserved.
//
#import "CMDOP_WT.h"

@interface CMD_GetOtherUserInfo : CMDOP_WT
@property (nonatomic,assign) long UserID;
@property (nonatomic, assign) long TargetUserID;
@end