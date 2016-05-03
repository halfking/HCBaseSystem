//
//  Comment.h
//  Wutong
//
//  Created by HUANGXUTAO on 15/4/30.
//  Copyright (c) 2015年 HUANGXUTAO. All rights reserved.
//

#import "NSEntity.h"
#import "PublicEnum.h"
#import "HCImageSet.h"
typedef enum : NSUInteger {
    CommentTypeText = 0,
    CommentTypeImage = 1,
    CommentTypeAudio = 2,
    CommentTypeMTV = 3,
} CommentType;

@interface Comment : HCEntity
{
    NSMutableArray * subComments_;
}
@property (nonatomic, assign) CommentType type; //0 文字 1图片 2 声音 3 MTV
@property (nonatomic, strong) NSString *attributes;
@property (nonatomic, strong) NSString *audioURL;
@property (nonatomic, strong) NSString *imgURL;
@property (nonatomic, assign) long UserID; //评论类型为3（MTV）时的内容的UserID，指评论的源对像数据的UserID
@property (nonatomic, assign) long MTVID; //评论类型为3（MTV）时的内容的MTVID
@property (nonatomic, strong) NSString *MTVCover;
@property (nonatomic, assign) long lastReplyID;
@property (nonatomic,assign) long QAID;//唯一表示
@property (nonatomic,assign) short ObjectType;////评价对象type
@property (nonatomic,assign) int ObjectID;////评价对象id
@property (nonatomic,retain) NSString * ObjectName;//评论的对象名称
@property (nonatomic,assign) long QuestionID;/////
@property (nonatomic,assign) long ParentQAID;////
@property (nonatomic,assign) long ParentUserID;////
@property (nonatomic,retain) NSString * ParentUserName;///内容

@property (nonatomic,retain) NSString * Content;///内容
@property (nonatomic,retain) NSString * DateCreated;///创建时间

@property (nonatomic,retain) NSString * UserName;//评论人的ID
@property (nonatomic,retain) NSString * HeadPortrait;//评论人的头像
@property (nonatomic,assign) BOOL IsLiked;
@property (nonatomic,assign) int LikeCount;

@property (nonatomic,retain) NSString * Logo;//Json      object头像
@property (nonatomic,assign) float  ScoreValue;//评分

@property (nonatomic,assign) long CreateUser;///创建人id
@property (nonatomic,assign) short DataStatus;//隐藏显示
@property (nonatomic,assign) CGFloat DuranceForWhen; //评论时的播放时间

@property (nonatomic,assign) BOOL IsSending;// 正在上传或发送状态，成功后要刷新状态

/**********   以下为不太重要的信息或者暂时用不上的      ***********/
@property (nonatomic,retain) NSMutableArray * Replies; //回复

@property (nonatomic,retain) HCImageSet * ImageItems; //图片解析
@property (nonatomic,retain) NSArray * ReplyItem;
@property (nonatomic,retain) NSString * Additions;
@property (nonatomic,retain,readonly,getter = get_subComments)NSMutableArray * subComments;
@property (nonatomic,assign) QuestionType QuestionType; //HCQuestionType
@property (nonatomic,assign) int SupportCount;
@property (nonatomic,assign) int AgainstCount;
@property (nonatomic,assign) int ReplyCount;//回复数量
@property (nonatomic,assign) long LastQAID;//恢复的最后一个ID
@property (nonatomic,retain) NSString * Reason;////////用户头像（
@property (nonatomic,assign) CGFloat RowHeight;

@property (nonatomic,strong) NSString *Scoresyntax;
@property (nonatomic,retain) NSString * IPAddress;//
@property (nonatomic,retain) NSString * Tags;//关键字
@property (nonatomic,retain) NSString * Qa_Identity; //问题唯一标识，用于自动保存时自动找到问题
@property (nonatomic,retain) NSString * Images;////
@property (nonatomic,retain) NSString * Title;///标题
@property (nonatomic,assign) long ParentObjectID;////这个评价的附属于哪个订单
@property (nonatomic,assign) int ParentObjectType;

//@property (nonatomic,retain) NSArray * subComments;
- (void) addReply:(Comment *)item;
- (void) resetSubComments;

@end
