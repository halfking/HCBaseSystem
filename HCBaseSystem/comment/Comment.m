//
//  Comment.m
//  Wutong
//
//  Created by HUANGXUTAO on 15/4/30.
//  Copyright (c) 2015年 HUANGXUTAO. All rights reserved.
//

#import "Comment.h"
#import "JSON.h"

@implementation Comment
@synthesize QAID;
@synthesize ObjectType;
@synthesize ObjectID;
@synthesize ObjectName;
@synthesize ParentObjectID;
@synthesize ParentObjectType;
@synthesize QuestionID;
@synthesize ParentQAID;
@synthesize Title;
@synthesize Content;

@synthesize DateCreated;
@synthesize Images;
@synthesize UserName;
@synthesize HeadPortrait;
@synthesize IPAddress;
@synthesize Tags;
@synthesize ScoreValue;
@synthesize Scoresyntax;

@synthesize Qa_Identity; //问题唯一标识，用于自动保存时自动找到问题
@synthesize Logo;//json
@synthesize CreateUser;
@synthesize DataStatus;
@synthesize QuestionType;

@synthesize SupportCount;
@synthesize AgainstCount;
@synthesize ReplyCount;
@synthesize LastQAID;
@synthesize Reason;
@synthesize RowHeight;
@synthesize Replies;
@synthesize ImageItems = _ImageItems;
@synthesize ReplyItem;
@synthesize Additions;
@synthesize DuranceForWhen;
@synthesize type;
@synthesize audioURL;
@synthesize imgURL;
@synthesize MTVID,UserID;
@synthesize MTVCover;
@synthesize lastReplyID;
@synthesize IsLiked;
@synthesize LikeCount;
@synthesize attributes;
@synthesize ParentUserID;
@synthesize ParentUserName;
@synthesize IsSending;

- (Comment *)init
{
    self = [super init];
    self.QuestionType = QuestionUserComment;
    self.TableName = @"comments";
    self.KeyName = @"QAID";
    return self;
}
- (void)addReply:(Comment *)item
{
    if(self.Replies==nil)
        self.Replies = PP_AUTORELEASE([[NSMutableArray alloc]init]);
    if(self.Replies!=nil)
        [self.Replies addObject:item];
}
-(void)resetSubComments
{
    @synchronized(self)
    {
        if(subComments_)
        {
            PP_RELEASE(subComments_);
        }
    }
}
-(NSMutableArray *)get_subComments
{
    
    if(!subComments_)
    {
        @synchronized(self)
        {
            @autoreleasepool {
                if(self.Additions && self.Additions.length>0)
                {
                    subComments_ = [[NSMutableArray alloc]init];
                    NSArray * array = [self.Additions JSONValueEx];
                    for (id object in array) {
                        Comment * comment = nil;
                        if([object isKindOfClass:[NSString class]])
                        {
                            NSDictionary * dic = [((NSString*)object)JSONValueEx];
                            comment = [[Comment alloc]initWithDictionary:dic];
                        }
                        else if([object isKindOfClass:[NSDictionary class]])
                        {
                            comment = [[Comment alloc]initWithDictionary:(NSDictionary*)object];
                        }
                        if(comment)
                        {
                            [subComments_ addObject:comment];
                            PP_RELEASE(comment);
                        }
                    }
                }
            }
        }
    }
    return subComments_;
}
-(id)initWithDictionary:(NSDictionary *)dic
{
    self = [super initWithDictionary:dic];
    if(self)
    {
        @autoreleasepool {
            if(self.Additions)
            {
                //                if([hcg.Additions isKindOfClass:[NSArray class]])
                //                {
                //                    hcg.Additions = [((NSArray*)hcg.Additions)JSONRepresentationEx];
                //                }
                //                else
                if([self.Additions isKindOfClass:[NSNull class]])
                {
                    self.Additions = nil;
                }
            }
            if(self.Replies)
            {
                if([self.Replies isKindOfClass:[NSString class]])
                {
                    NSArray * array = [((NSString*)self.Replies)JSONValueEx];
                    self.Replies = PP_AUTORELEASE([[NSMutableArray alloc]init]);
                    if(array)
                    {
                        for(NSDictionary * dic in array)
                        {
                            Comment * reply = [[Comment alloc]initWithDictionary:dic];
                            [self.Replies addObject:reply];
                            PP_RELEASE(reply);
                        }
                    }
                }
                else if([self.Replies isKindOfClass:[NSArray class]])
                {
                    NSArray * array = (NSArray *)self.Replies;
                    self.Replies = PP_AUTORELEASE([[NSMutableArray alloc]init]);
                    for(id dic in array)
                    {
                        if([dic isKindOfClass:[NSDictionary class]])
                        {
                            Comment * reply = [[Comment alloc]initWithDictionary:dic];
                            [self.Replies addObject:reply];
                            PP_RELEASE(reply);
                        }
                        else if([dic isKindOfClass:[Comment class]])
                        {
                            [self.Replies addObject:dic];
                        }
                    }
                }
            }
            if(self.ReplyItem)
            {
                if([self.ReplyItem isKindOfClass:[NSString class]])
                {
                    NSArray * array = [((NSString*)self.ReplyItem)JSONValueEx];
                    self.Replies = PP_AUTORELEASE([[NSMutableArray alloc]init]);
                    if(array)
                    {
                        for(NSDictionary * dic in array)
                        {
                            Comment * reply = [[Comment alloc]initWithDictionary:dic];
                            [self.Replies addObject:reply];
                            PP_RELEASE(reply);
                        }
                    }
                    self.ReplyItem = nil;
                }
                else if([self.ReplyItem isKindOfClass:[NSArray class]])
                {
                    NSArray * array = (NSArray *)self.ReplyItem;
                    self.Replies = PP_AUTORELEASE([[NSMutableArray alloc]init]);
                    for(id dic in array)
                    {
                        if([dic isKindOfClass:[NSDictionary class]])
                        {
                            Comment * reply = [[Comment alloc]initWithDictionary:dic];
                            [self.Replies addObject:reply];
                            PP_RELEASE(reply);
                        }
                        else if([dic isKindOfClass:[Comment class]])
                        {
                            [self.Replies addObject:dic];
                        }
                    }
                    self.ReplyItem = nil;
                }
            }
        }
    }
    return self;
}
-(void)dealloc
{
    self.ObjectName = nil;
    self.Title = nil;
    self.Content = nil;
    self.DateCreated = nil;
    self.Images = nil;
    self.Tags = nil;
    self.UserName = nil;
    self.IPAddress = nil;
    
    self.Qa_Identity = nil;
    self.Logo = nil;

    
    self.Replies = nil;
    self.ImageItems = nil;
    self.Reason = nil;
    self.ReplyItem = nil;
    self.Additions = nil;
    self.Scoresyntax = nil;
    if(subComments_)
    {
        PP_RELEASE(subComments_);
    }
    
    
    PP_SUPERDEALLOC;
}
@end
