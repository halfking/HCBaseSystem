//
//  CMD_Comment.m
//  Wutong
//
//  Created by HUANGXUTAO on 15/5/12.
//  Copyright (c) 2015年 HUANGXUTAO. All rights reserved.
//

#import "CMD_Comment.h"
#import <hccoren/base.h>
#import <hccoren/JSON.h>
#import "HCCallResultForWT.h"
#import "HCDBHelper(WT).h"
@implementation CMD_Comment
@synthesize commentItem;
- (id)init
{
    if(self = [super init])
    {
        CMDID_ = 16;
        useHttpSender_ = YES;
    }
    return self;
}
- (BOOL)calcArgsAndCacheKey
{
    NSLog(@"A_1_13_0_16_用户评论");
    DeviceConfig * info = [DeviceConfig Instance];
    NSDictionary * dic = [NSDictionary dictionaryWithObjectsAndKeys:
                          //                          info.UDI,@"ClientID",
                          //#ifdef IS_MANAGERCONSOLE
                          //                          @([SystemConfiguration sharedSystemConfiguration].loginUserID),@"UserID",
                          //#else
                          @([self userID]),@"userid",
                          [commentItem toJson],@"data",
                          //#endif
                          @"1.13.0",@"scode",
                          info.IPAddress,@"ip",
                          nil];
    if(args_) PP_RELEASE(args_);
    args_ = PP_RETAIN([dic JSONRepresentationEx]);
    if(argsDic_) PP_RELEASE(argsDic_);
    argsDic_ = PP_RETAIN(dic);
    NSLog(@"args:%@",args_);
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
    
    if([result objectForKey:@"qaid"])
    {
        ret.ObjectID = [[result objectForKey:@"qaid"]longValue];
        self.commentItem.QAID = ret.ObjectID;
    }
    
    return PP_AUTORELEASE(ret);
}

- (NSObject*)parseData:(NSDictionary *)result
{
    return nil;
//    NSArray * musics = [result objectForKey:@"list"];
//    if(!musics ) return nil;
//    //PARSEDATA(funDic, fun, Music);
//    PARSEDATAARRAY(musicObjects,musics,Music);
//    
//    return PP_AUTORELEASE(musicObjects);
}
@end
