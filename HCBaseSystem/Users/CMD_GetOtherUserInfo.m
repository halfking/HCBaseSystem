//
//  CMD_GetOtherUserInfo.m
//  maiba
//
//  Created by Matthew on 16/1/7.
//  Copyright © 2016年 seenvoice.com. All rights reserved.
//

#import "CMD_GetOtherUserInfo.h"
#import <hccoren/base.h>
#import "OtherUserInfo.h"
//#import "HCBase.h"
//#import "DeviceConfig.h"
#import "HCCallResultForWT.h"
#import "HCDBHelper(WT).h"
#import "UserInformation.h"
#import "UserInfo-Extend.h"
#import "HCUserSettings.h"
#import "HCUserSummary.h"

@implementation CMD_GetOtherUserInfo
@synthesize UserID;
@synthesize TargetUserID;

- (id)init
{
    if(self = [super init])
    {
        CMDID_ = 5401;
        useHttpSender_ = YES;
        isPost_=NO;
    }
    return self;
}
- (BOOL)calcArgsAndCacheKey
{
    NSLog(@"A_2_2_0_32_获取用户信息");
    //    DeviceConfig * info = [DeviceConfig Instance];
    NSDictionary * dic = [NSDictionary dictionaryWithObjectsAndKeys:
                          @(UserID),@"userid",
                          @(TargetUserID),@"targetuserid",
                          @"2.28.0",@"scode",
                          nil];
    if(args_) PP_RELEASE(args_);
    args_ = PP_RETAIN([dic JSONRepresentationEx]);
    if(argsDic_) PP_RELEASE(argsDic_);
    argsDic_ = PP_RETAIN(dic);
    return YES;
    
}

#pragma mark - query from db
//取原来存在数据库中的数据，当需要快速响应或者网络不通时
- (NSObject *) queryDataFromDB:(NSDictionary *)params
{
    return nil;
}

#pragma mark - parse
- (HCCallbackResult *) parseResult:(NSDictionary *)result
{
    //
    //需要在子类中处理这一部分内容
    //
    HCCallResultForWT * ret = [[HCCallResultForWT alloc]initWithArgs:argsDic_?argsDic_ : [self.args JSONValueEx]
                                                            response:result];
    ret.DicNotParsed = result;
    
    if(ret.Code ==0)
    {
        ret.Data = (HCEntity *)[self parseData:result];
    }
    
    return PP_AUTORELEASE(ret);
}

- (OtherUserInfo*)parseData:(NSDictionary *)result
{
    NSDictionary * userData = [result objectForKey:@"data"];
    OtherUserInfo * user = nil;
    if(userData )
    {
        user = [[OtherUserInfo alloc]initWithDictionary:[result objectForKey:@"data"]];
        if(user.UserID <=0)
            PP_RELEASE(user);
    }
    return PP_AUTORELEASE(user);
}

@end
