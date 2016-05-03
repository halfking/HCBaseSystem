//
//  CMD_GetUserSummary.m
//  Wutong
//
//  Created by HUANGXUTAO on 15/5/12.
//  Copyright (c) 2015年 HUANGXUTAO. All rights reserved.
//

#import "CMD_GetUserSummary.h"
#import "HCBase.h"
#import "DeviceConfig.h"
#import "HCCallResultForWT.h"
#import "HCDBHelper(WT).h"
#import "HCUserSummary.h"

@implementation CMD_GetUserSummary
@synthesize UserID;


- (id)init
{
    if(self = [super init])
    {
        CMDID_ = 33;
        useHttpSender_ = YES;
    }
    return self;
}
- (BOOL)calcArgsAndCacheKey
{
    NSLog(@"A_2_3_0_33_获取用户汇总信息");
    //    DeviceConfig * info = [DeviceConfig Instance];
    NSDictionary * dic = [NSDictionary dictionaryWithObjectsAndKeys:
                          @(UserID),@"userid",
                          @"2.3.0",@"scode",
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
    
    if(ret.Code ==0 && ret.IsFromDB == NO)
    {
        ret.Data = (HCEntity *)[self parseData:result];
    }
    
    return PP_AUTORELEASE(ret);
}

- (HCUserSummary*)parseData:(NSDictionary *)result
{
    NSDictionary * userData = [result objectForKey:@"data"];

    HCUserSummary * summary = nil;
    if(userData )
    {
        summary = [[HCUserSummary alloc]initWithDictionary:[result objectForKey:@"summary"]];
        if(summary.UserID <=0) PP_RELEASE(summary);
    }
      return PP_AUTORELEASE(summary);
}

@end
