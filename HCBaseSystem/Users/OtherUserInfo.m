//
//  OtherUserInfo.m
//  maiba
//
//  Created by Matthew on 16/1/7.
//  Copyright © 2016年 seenvoice.com. All rights reserved.
//

#import "OtherUserInfo.h"

@implementation OtherUserInfo
@synthesize UserID;
@synthesize LikedCount;
@synthesize FansCount;
@synthesize FollowingCount;
@synthesize IsFollowed;
@synthesize NickName;
@synthesize HeadPortrait;
@synthesize StarID;
@synthesize RegionID;
@synthesize Sex;
@synthesize Introduction;
@synthesize covers;
@synthesize MtvCount;
-(id)init
{
    self = [super init];
    if(self)
    {
        self.covers = [NSMutableArray new];
    }
    return self;
}

- (id)initWithDictionary:(NSDictionary *)dic
{
    if (self = [super initWithDictionary:dic]) {
        NSMutableArray *newCovers = [NSMutableArray new];
        for (NSDictionary *dic in self.covers) {
            Cover *cover = [[Cover alloc] initWithDictionary:dic];
            [newCovers addObject:cover];
        }
        self.covers = newCovers;
    }
    return self;
}

- (void)setFollowingCount:(int)followingCount
{
    FollowingCount = followingCount;
}

- (id)initWithJSON:(NSString *)json
{
    if (self = [super initWithJSON:json]) {
        if (!Introduction) {
            Introduction = @"";
        }
        NSMutableArray *newCovers = [NSMutableArray new];
        for (NSDictionary *dic in self.covers) {
            Cover *cover = [[Cover alloc] initWithDictionary:dic];
            [newCovers addObject:cover];
        }
        self.covers = newCovers;
    }
    return self;
}

#pragma mark dealloc
- (void)dealloc
{
    PP_RELEASE(NickName);
    PP_RELEASE(HeadPortrait);
    PP_RELEASE(Introduction);
    PP_SUPERDEALLOC;
}
@end
