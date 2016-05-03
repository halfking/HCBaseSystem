//
//  CMD_DeleteComment.m
//  maiba
//
//  Created by seentech_5 on 16/1/22.
//  Copyright © 2016年 seenvoice.com. All rights reserved.
//

#import "CMD_DeleteComment.h"
#import <hccoren/JSON.h>
@implementation CMD_DeleteComment
@synthesize QAID;

//2.29.0 5411
- (id)init
{
    if(self = [super init])
    {
        CMDID_ = 5411;
        useHttpSender_ = YES;
    }
    return self;
}

- (BOOL)calcArgsAndCacheKey
{
    NSLog(@"A_2_29_0_1_删除评论");
    DeviceConfig * info = [DeviceConfig Instance];
    NSString * currentVersion = info.Version;
    if(!currentVersion) currentVersion = @"";
    NSDictionary * dic = [NSDictionary dictionaryWithObjectsAndKeys:
                          @([self userID]),@"userid",
                          @(self.QAID),@"qaid",
                          currentVersion,@"ver",    //当前APP版本号
                          @"2.29.0",@"scode", nil];
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
        
        
    }
    
    return PP_AUTORELEASE(ret);
}

- (NSObject*)parseData:(NSDictionary *)result
{
    
    return result;
}
@end
