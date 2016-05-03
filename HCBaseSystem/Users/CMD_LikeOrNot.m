//
//  CMD_LikeOrNot.m
//  Wutong
//
//  Created by HUANGXUTAO on 15/5/12.
//  Copyright (c) 2015年 HUANGXUTAO. All rights reserved.
//

#import "CMD_LikeOrNot.h"
#import <hccoren/base.h>
//#import "HCBase.h"
//#import "DeviceConfig.h"
//#import "UserStars.h"
#import "HCCallResultForWT.h"

#import "HCDBHelper(WT).h"
@implementation CMD_LikeOrNot
@synthesize MtvID,IsLike;
@synthesize ObjectType,ObjectUserID;
- (id)init
{
    if(self = [super init])
    {
        CMDID_ = 12;
        useHttpSender_ = YES;
        isPost_ = NO;
        ObjectType = HCObjectTypeMTV;
    }
    return self;
}
- (BOOL)calcArgsAndCacheKey
{
    NSLog(@"A_1_12_0_12_记录音乐操作（喜欢或取消/收藏或取消）");
    
    NSMutableDictionary * dic = [[NSMutableDictionary alloc]init];
    
    [dic setObject:@"1.12.0" forKey:@"scode"];
    
//    favType,objecttype,objectid,operate,userid
    [dic setObject:@"like" forKey:@"favtypestr"];
    [dic setObject:[NSNumber numberWithInt:8] forKey:@"favtype"];
//    operate:0为取消，1为喜欢
    
    [dic setObject:[NSNumber numberWithInt:ObjectType] forKey:@"objecttype"];
    [dic setObject:[NSNumber numberWithLong:ObjectUserID] forKey:@"objectuserid"];
    [dic setObject:[NSNumber numberWithLong:MtvID] forKey:@"objectid"];
    [dic setObject:[NSNumber numberWithInt:(IsLike?1:0)] forKey:@"operate"];
    [dic setObject:[NSNumber numberWithLong:[self userID]] forKey:@"userid"];
    
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
    //
    //需要在子类中处理这一部分内容
    //
//    NSMutableArray * result = [[NSMutableArray alloc]init];
//    
//    DBHelper * db = [DBHelper sharedDBHelper];
//    
//    NSString * sql = [NSString stringWithFormat:@"select * from starts order by BeginMonthDay ASC;"];
//    if([db open])
//    {
//        [db execWithArray:result class:NSStringFromClass([UserStars class]) sql:sql];
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
    
    return PP_AUTORELEASE(ret);
}
- (NSObject*)parseData:(NSDictionary *)result
{
    return nil;
}
@end
