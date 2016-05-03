//
//  CMD_GetUserRelation.m
//  Wutong
//
//  Created by HUANGXUTAO on 15/5/12.
//  Copyright (c) 2015年 HUANGXUTAO. All rights reserved.
//

#import "CMD_GetUserRelation.h"
#import <hccoren/base.h>
#import "HCCallResultForWT.h"
#import "HCDBHelper(WT).h"
#import "HCUserFriend.h"

@implementation CMD_GetUserRelation
@synthesize UserID,TargetUserID;
- (id)init
{
    if(self = [super init])
    {
        CMDID_ = 35;
        useHttpSender_ = YES;
        relationType_ = HCRelationUnkown;
    }
    return self;
}
- (BOOL)calcArgsAndCacheKey
{
    NSLog(@"A_2_5_0_35_获取用户关系");
//    DeviceConfig * info = [DeviceConfig Instance];
    NSDictionary * dic = [NSDictionary dictionaryWithObjectsAndKeys:
                          //                          info.UDI,@"ClientID",
                          //#ifdef IS_MANAGERCONSOLE
                          //                          @([SystemConfiguration sharedSystemConfiguration].loginUserID),@"UserID",
                          //#else
                          @(UserID<=0?[self userID]:UserID),@"userid",
                          @(TargetUserID),@"targetuserid",
                          @([self userID]),@"currentuserid",
                          //#endif
                          @"2.5.0",@"scode",
//                          info.IPAddress,@"IP",
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
//    NSMutableArray * result = [[NSMutableArray alloc]init];
//    
//    DBHelper * db = [DBHelper sharedDBHelper];
////    FW_UserID;
////    @property(nonatomic,assign) int FW_FellowUserID;
//    NSString * sql = [NSString stringWithFormat:@"select * from userfellows where fw_userid=%d and fw_fellowuserid = %d;",
//                      UserID,TargetUserID];
//    if([db open])
//    {
//        [db execWithArray:result class:NSStringFromClass([MTV class]) sql:sql];
//        [db close];
//    }
//    
//    if(result.count>0)
//        return PP_AUTORELEASE(result);
//    else
//        PP_RELEASE(result);
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
        NSDictionary * dic =[result objectForKey:@"data"];
        if(dic && [dic objectForKey:@"fellowtype"])
        {
            relationType_ = (HCRelationType)[[dic objectForKey:@"fellowtype"]intValue];
        }
        else if([result objectForKey:@"fellowtype"])
        {
            relationType_ = (HCRelationType)[[result objectForKey:@"fellowtype"]intValue];
        }
    }
    
    
    
    return PP_AUTORELEASE(ret);
}

- (NSObject*)parseData:(NSDictionary *)result
{
    return nil;
}
- (HCRelationType)relationResult
{
    return relationType_;
}
@end
