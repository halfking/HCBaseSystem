//
//  OtherUserInfo.h
//  maiba
//
//  Created by Matthew on 16/1/7.
//  Copyright © 2016年 seenvoice.com. All rights reserved.
//

#import "NSEntity.h"
#import <hccoren/base.h>
#import "HCUserSettings.h"
#import "HCUserSummary.h"
#import "PublicEnum.h"
#import "Cover.h"
@class HCRegion;

@interface OtherUserInfo : HCEntity
@property(nonatomic,assign) long UserID;
@property(nonatomic,assign) int LikedCount;
@property(nonatomic,assign) int FansCount;
@property(nonatomic,assign) int FollowingCount;
@property(nonatomic,assign) int IsFollowed; //0 未关注 1已关注
@property(nonatomic,PP_STRONG) NSString * NickName;
@property(nonatomic,PP_STRONG) NSString * HeadPortrait;
@property(nonatomic,assign) int StarID;
@property(nonatomic,assign) int RegionID;
@property(nonatomic,assign) int MtvCount;
@property(nonatomic,assign) HCSexy Sex;
@property(nonatomic,PP_STRONG) NSString * Introduction;//简介
@property (nonatomic, PP_STRONG) NSMutableArray *covers;
@end
