//
//  CMD_GetMtvComments.m
//  Wutong
//
//  Created by HUANGXUTAO on 15/5/30.
//  Copyright (c) 2015年 HUANGXUTAO. All rights reserved.
//

#import "CMD_GetMtvComments.h"
#import <hccoren/base.h>
#import "HCCallResultForWT.h"
#import "Comment.h"
#import "HCDBHelper(WT).h"

@implementation CMD_GetMtvComments

@synthesize ObjectID,ObjectType,Durance,QAID;
@synthesize PageIndex,PageSize;
@synthesize OrderType;

- (id)init
{
    if(self = [super init])
    {
        CMDID_ = 17;
        useHttpSender_ = YES;
    }
    return self;
}
- (BOOL)calcArgsAndCacheKey
{
    NSLog(@"A_1_10_0_获取MTV评论");
    NSDictionary * dic = [NSDictionary dictionaryWithObjectsAndKeys:
                          @([self userID]),@"userid",
                          @(ObjectID),@"objectid",
                          @(ObjectType),@"objecttype",
                          @(Durance),@"Durance",
                          @(QAID),@"QAID",
                          @(OrderType),@"ordertype",
                          @(PageIndex),@"pageindex",
                          @(PageSize),@"pagesize",
                          @"1.10.0",@"Scode",
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
//    
//    NSString * sql = [NSString stringWithFormat:@"select * from comments order by MTVID Desc limit %d,%d;",
//                      0,10000];
//    if([db open])
//    {
//        [db execWithArray:result class:NSStringFromClass([Comment class]) sql:sql];
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
        if([result objectForKey:@"totalcount"])
        {
            ret.TotalCount = [[result objectForKey:@"totalcount"]intValue];
        }
        ret.List = (NSArray *)[self parseData:result];
        if(ret.List && ret.IsFromDB ==NO)
        {
            dispatch_async([DBHelper_WT getDBQueue], ^{
            [[DBHelper sharedDBHelper]insertDataArray:ret.List forceUpdate:YES];
            });
            //            [[DBHelper sharedDBHelper]insertDataArray:ret.List needOpenDB:YES forceUpdate:YES];
        }
    }
    
    
    
    return PP_AUTORELEASE(ret);
}

- (NSObject*)parseData:(NSDictionary *)result
{
    NSArray * comments = [result objectForKey:@"list"];
    if(!comments ) return nil;

    PARSEDATAARRAY(musicObjects,comments,Comment);
    
    return PP_AUTORELEASE(musicObjects);
}

@end
