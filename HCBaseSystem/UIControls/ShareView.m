//
//  ShareView.m
//  maiba
//
//  Created by WangSiyu on 15/12/28.
//  Copyright © 2015年 seenvoice.com. All rights reserved.
//

#import "ShareView.h"
#import "DeviceConfig.h"
#import "UMSocial.h"
#import "UMShareObject.h"
#import "UIImage-Extension.h"
#import "SDWebImageManager.h"
#import "OtherUserInfo.h"

//#define FULLSCREEN_WIDTH    (self.bounds.size.width)
//#define FULLSCREEN_HEIGHT   (self.bounds.size.height)
#import "UserManager.h"

@implementation ShareView
{
    MTV *currentMTV_;
    UserInformation * currentUserInfo_;
    OtherUserInfo * otherUserInfo_;
    BOOL isBuilded_;
    HCObjectType shareObjectType_;
    NSString * objectUrlString_;
    NSString * objectShareTitle_;
    NSString * objectImageUrl_;
    NSString * objectContent_;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        //        [self setupUI];
        isBuilded_ = NO;
    }
    return self;
}

- (void)setDelegate:(id<ShareViewDelegate>)delegate
{
    _delegate = delegate;
    //    currentMTV_ = [self.delegate getCurrentMTV];
}
- (void)setCurrentMTV:(MTV *)mtv
{
    PP_RELEASE(currentMTV_);
    currentMTV_ = PP_RETAIN(mtv);
    shareObjectType_ = HCObjectTypeMTV;
    [self setupUI];
}
- (void)setCurrentUser:(id)userInfo
{
    PP_RELEASE(currentUserInfo_);
    PP_RELEASE(otherUserInfo_);
    currentUserInfo_ = PP_RETAIN(userInfo);
    shareObjectType_ = HCObjectTypeUser;
    [self setupUI];
}
- (void)setOtherUser:(OtherUserInfo *)userInfo
{
    PP_RELEASE(currentUserInfo_);
    PP_RELEASE(otherUserInfo_);
    otherUserInfo_ = PP_RETAIN(userInfo);
    shareObjectType_ = HCObjectTypeUser;
    [self setupUI];
}
- (void)setLinkerShare:(NSString *)urlString title:(NSString *)title image:(NSString *)imageUrlString content:(NSString *)content
{
    shareObjectType_ = HCObjectTypeActivity;
    objectUrlString_ = urlString;
    objectShareTitle_ = title?title:@"";
    objectImageUrl_ = imageUrlString?imageUrlString:@"";
    objectContent_ = content?content:@"";
    [self setupUI];
}
- (void)setupUI
{
    if(isBuilded_) return;
    
    CGFloat width = self.frame.size.width;
    
    UMShareObject * umShare = [UMShareObject shareObject];
    NSMutableArray *imageList = [NSMutableArray new];
    NSMutableArray *selectorList = [NSMutableArray new];
    if([umShare isInstalled:HCLoginTypeSinaWeibo])
    {
        [imageList addObject:@"sina_icon"];//index：0
        [selectorList addObject:@"shareViaWeibo:"];//index：1
    }
    if([umShare isInstalled:HCLoginTypeWeixin])//index：2
    {
        [imageList addObject:@"wechat_icon"];//index：0
        [imageList addObject:@"friends_icon"];//index：0
        [selectorList addObject:@"shareViaWechat:"];//index：1
        [selectorList addObject:@"shareViaFrends:"];//index：1
    }
    if([umShare isInstalled:HCLoginTypeQQ])
    {
        [imageList addObject:@"qq_icon"];//index：0
        [imageList addObject:@"qzone_icon"];//index：0
        [selectorList addObject:@"shareViaQQ:"];//index：1
        [selectorList addObject:@"shareViaQzone:"];//index：1
    }
    [imageList addObject:@"link_icon"];//index：0
    [selectorList addObject:@"shareViaLink:"];//index：1
    
    self.backgroundColor = [UIColor whiteColor];
    
    CGFloat top = 0;
    {
        UIFont * font = [UIFont boldSystemFontOfSize:15];
        NSString * title = @"分享到";
        CGSize textSize = [title sizeWithAttributes:@{NSFontAttributeName:font}];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake((width - textSize.width) / 2, (50 - textSize.height)/2.0f, textSize.width, textSize.height)];
        titleLabel.text =title;
        titleLabel.textColor = [UIColor blackColor];
        titleLabel.font = font;
        [self addSubview:titleLabel];
        
        UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(0, top + 50, width, 0.5)];
        line1.backgroundColor = COLOR_CA;
        [self addSubview:line1];
        
        top += 50;
    }
    CGFloat left = 50;
    CGFloat space = width >=480?(width - 100 - 60 * imageList.count)/(imageList.count-1):(width - 100 - 3 * 60)/2;
    space = floor(space);
    space = (int)space;
    top += 25;
    for(int i =0;i<imageList.count;i++)
    {
        UIButton *iconButton = [[UIButton alloc] initWithFrame:CGRectMake(left , top, 60, 60)];
        [iconButton setImage:[UIImage imageNamed:[imageList objectAtIndex:i]]
                    forState:UIControlStateNormal];
        iconButton.tag = 789321 + i;
        [iconButton addTarget:self
                       action:NSSelectorFromString([selectorList objectAtIndex:i])
             forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:iconButton];
        left += 60 +space;
        if(left + 60 + 50 >=width+3)
        {
            top += 60+25;
            left = 50;
        }
    }
    //    {
    //        NSUInteger row = imageList.count / countPerRow;
    //        NSUInteger colomn = imageList.count % countPerRow;
    //        int i,j;
    //        for (i = 0; i < row; i ++) {
    //            for (j = 0; j < countPerRow; j ++) {
    //                UIButton *iconButton = [[UIButton alloc] initWithFrame:CGRectMake((width - 280) / 2 + j * 110 , 75 + i * 85, 60, 60)];
    //                [iconButton setImage:[UIImage imageNamed:[imageList objectAtIndex:i * 3 + j]] forState:UIControlStateNormal];
    //                iconButton.tag = 789321 + i * 3 + j;
    //                [iconButton addTarget:self action:NSSelectorFromString([selectorList objectAtIndex:i * 3 + j]) forControlEvents:UIControlEventTouchUpInside];
    //                [self addSubview:iconButton];
    //            }
    //        }
    //        for (j = 0; j < colomn; j ++) {
    //            UIButton *iconButton = [[UIButton alloc] initWithFrame:CGRectMake((width - 280) / 2 + j * 110 , 75 + i * 85, 60, 60)];
    //            [iconButton setImage:[UIImage imageNamed:[imageList objectAtIndex:i * 3 + j]] forState:UIControlStateNormal];
    //            iconButton.tag = 789321 + i * 3 + j;
    //            [iconButton addTarget:self action:NSSelectorFromString([selectorList objectAtIndex:i * 3 + j]) forControlEvents:UIControlEventTouchUpInside];
    //            [self addSubview:iconButton];
    //        }
    //    }
    
    top = self.frame.size.height - 50;
    {
        UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(0, top, width, 0.5)];
        line2.backgroundColor = COLOR_CA;
        [self addSubview:line2];
        line2.tag = 110091;
        
        top += 12.5;
        
        UIButton *cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(0, top, width, 25)];
        cancelButton.titleLabel.font = [UIFont boldSystemFontOfSize:13];
        cancelButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        [cancelButton setTitle:@"取 消" forState:UIControlStateNormal];
        [cancelButton setTitleColor:COLOR_BA forState:UIControlStateNormal];
        [cancelButton addTarget:self action:@selector(didCancel:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:cancelButton];
        cancelButton.tag = 110092;
        
    }
    isBuilded_ = YES;
}
- (void)changeFrame:(CGRect)frame
{
    if(!isBuilded_) return;
    
    CGFloat width = frame.size.width;
    
    UMShareObject * umShare = [UMShareObject shareObject];
    NSMutableArray *imageList = [NSMutableArray new];
    NSMutableArray *selectorList = [NSMutableArray new];
    if([umShare isInstalled:HCLoginTypeSinaWeibo])
    {
        [imageList addObject:@"sina_icon"];//index：0
        [selectorList addObject:@"shareViaWeibo:"];//index：1
    }
    if([umShare isInstalled:HCLoginTypeWeixin])//index：2
    {
        [imageList addObject:@"wechat_icon"];//index：0
        [imageList addObject:@"friends_icon"];//index：0
        [selectorList addObject:@"shareViaWechat:"];//index：1
        [selectorList addObject:@"shareViaFrends:"];//index：1
    }
    if([umShare isInstalled:HCLoginTypeQQ])
    {
        [imageList addObject:@"qq_icon"];//index：0
        [imageList addObject:@"qzone_icon"];//index：0
        [selectorList addObject:@"shareViaQQ:"];//index：1
        [selectorList addObject:@"shareViaQzone:"];//index：1
    }
    [imageList addObject:@"link_icon"];//index：0
    [selectorList addObject:@"shareViaLink:"];//index：1
    
    CGFloat top = 50;
    
    CGFloat left = 50;
    CGFloat space = width >=480?(width - 100 - 60 * imageList.count)/(imageList.count-1):(width - 100 - 3 * 60)/2;
    space = (int)space;
    
    top += 25;
    for(int i =0;i<imageList.count;i++)
    {
        UIButton *iconButton = (UIButton *)[self viewWithTag:789321 + i];
        iconButton.frame =  CGRectMake(left , top, 60, 60);
        left += 60 +space;
        if(left +60 +space >=width+10)
        {
            top += 60+25;
            left = 50;
        }
    }
    
    top = frame.size.height - 50;
    {
        
        UIView *line2 = [self viewWithTag:110091];
        if(line2)
            line2.frame = CGRectMake(0, top, width, 0.5);
        top +=12.5;
        UIButton * cancelButton = (UIButton*)[self viewWithTag:110092];
        cancelButton.frame = CGRectMake(0, top,width, 25);
    }
    
}
- (void)shareViaWeibo:(id)sender
{
    NSLog(@"shareViaWeibo clicked");
    [self doShare:HCLoginTypeSinaWeibo];
}

- (void)shareViaWechat:(id)sender
{
    NSLog(@"shareViaWechat clicked");
    [self doShare:HCLoginTypeWeixin];
}

- (void)shareViaFrends:(id)sender
{
    NSLog(@"shareViaFrends clicked");
    [self doShare:HCLoginTypeSession];
}

- (void)shareViaQQ:(id)sender
{
    NSLog(@"shareViaQQ clicked");
    [self doShare:HCLoginTypeQQ];
}

- (void)shareViaQzone:(id)sender
{
    NSLog(@"shareViaQzone clicked");
    [self doShare:HCLoginTypeQZone];
}

- (void)shareViaLink:(id)sender
{
    NSLog(@"shareViaLink clicked");
    NSString * shareUrl = nil;
    if(shareObjectType_ == HCObjectTypeUser)
    {
        if(currentUserInfo_ && currentUserInfo_.UserID>0)
        {
            shareUrl = [NSString stringWithFormat:SHAREURL_USER,currentUserInfo_.UserID];
        }
        else if(otherUserInfo_)
        {
            shareUrl = [NSString stringWithFormat:SHAREURL_USER,otherUserInfo_.UserID];
        }
    }
    else if(shareObjectType_==HCObjectTypeActivity)
    {
        shareUrl = objectUrlString_;
    }
    else
    {
        shareUrl = currentMTV_.ShareUrl && currentMTV_.ShareUrl.length>0?currentMTV_.ShareUrl:[currentMTV_ getKey];
    }
    //    NSString * shareUrl = currentMTV_.ShareUrl && currentMTV_.ShareUrl.length>0?currentMTV_.ShareUrl:[currentMTV_ getKey];
    if (shareUrl)
    {
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        if([shareUrl hasPrefix:@"http://"])
        {
            NSLog(@"share url:%@",shareUrl);
        }
        else //此时，URL可能是Key
        {
            shareUrl = [NSString stringWithFormat:SHAREURL,shareUrl,0,currentMTV_.SampleID,currentMTV_.MTVID];//?
        }
        pasteboard.string = shareUrl;
        [self.delegate shareViewDidShareCompleted:self success:YES];
    }
    else
        [self.delegate shareViewDidShareCompleted:self success:NO];
}

- (void)doShare:(HCLoginType)loginType {
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    
    UMShareObject * share = [UMShareObject shareObject];
    NSString * url = nil;
    NSString * userName = nil;
    NSString * title = nil;
    NSString * content = nil;
    NSString * imgUrl = nil;
    if(shareObjectType_ == HCObjectTypeUser)
    {
        if(currentUserInfo_ && currentUserInfo_.UserID>0)
        {
            url = [NSString stringWithFormat:SHAREURL_USER,currentUserInfo_.UserID];
            userName = [[UserManager sharedUserManager]currentUser].NickName;
            title = [NSString stringWithFormat:@"快来查看 %@ 的专属音乐封面！",userName];//,currentUserInfo_.Signature];
            content = @"";//@"快到碗里来~";
            imgUrl = [HCImageItem urlWithWH:currentUserInfo_.HeadPortrait width:width height:height - 40 mode:2];
        }
        else if(otherUserInfo_)
        {
            url = [NSString stringWithFormat:SHAREURL_USER,otherUserInfo_.UserID];
            userName = otherUserInfo_.NickName;
            title = [NSString stringWithFormat:@"快来查看 %@ 的专属音乐封面！",userName];//,currentUserInfo_.Signature];
            content = @"";//@"快到碗里来~";
            imgUrl = [HCImageItem urlWithWH:otherUserInfo_.HeadPortrait width:width height:height - 40 mode:2];
        }
    }
    else if(shareObjectType_==HCObjectTypeActivity)
    {
        url = objectUrlString_;
        userName = [[UserManager sharedUserManager]currentUser].NickName;
        title = objectShareTitle_;
        content = objectContent_;
        imgUrl = [HCImageItem urlWithWH:objectImageUrl_ width:width height:height - 40 mode:2];
    }
    else
    {
        url = currentMTV_.ShareUrl && currentMTV_.ShareUrl.length>0?currentMTV_.ShareUrl:nil;//[currentMTV_ getKey];
        if(!url || url.length<2)
        {
            url = [NSString stringWithFormat:SHAREURL,[currentMTV_ getKey],loginType,currentMTV_.SampleID,currentMTV_.MTVID];
        }
        if (currentMTV_.MtvType == 3) // 录制视频
        {
            if (currentMTV_.UserID == [UserManager sharedUserManager].currentUser.UserID) {
                title = @"心情美美哒，我刚制作了一个MV，分享给你哦~";
            } else {
                title = @"好东西不能独享，我刚发现了一个有趣的视频，分享给你哦~";
            }
            content = (currentMTV_.Memo && currentMTV_.Memo.length > 0) ? currentMTV_.Memo : @"猛戳查看视频，心情一整天都美美哒~";
        }
        else
        {
            userName = currentMTV_.Author && currentMTV_.Author.length>0?currentMTV_.Author:@"某个昵名用户";
            if(self.shareTitle && self.shareTitle.length>2)
            {
                title = self.shareTitle;
                content = @"";
            }
            else
            {
                title = [NSString stringWithFormat:@"\"%@\"为你改编了一首《%@》",userName,currentMTV_.Title];
                content = @"快到碗里来~";
            }
        }
        
        imgUrl = [HCImageItem urlWithWH:currentMTV_.CoverUrl width:width height:height - 40 mode:2];
    }
    if([imgUrl hasPrefix:@"http://"]|| [imgUrl hasPrefix:@"https://"])
    {
        SDWebImageManager * manager = [SDWebImageManager sharedManager];
        [manager downloadImageWithURL:[NSURL URLWithString:imgUrl] options:SDWebImageHighPriority progress:
         ^(NSInteger receivedSize,NSInteger expectedSize)
         {
             NSLog(@"download image :%f",receivedSize * 1.0f/expectedSize);
         }
                            completed:
         ^(UIImage * image,NSError * error,SDImageCacheType cacheType,BOOL finished,NSURL * imageURL)
         {
             [share shareListVC:(UIViewController *)self.delegate loginType:loginType url:url shareTitle:title shareContent:content shareImg:image imgUrlString:imgUrl completed:^(BOOL success,NSString * message)
              {
                  [self.delegate shareViewDidShareCompleted:self success:success];
              }];
         }];
    }
    else
    {
        imgUrl = [CommonUtil checkPath:imgUrl];
        UIImage * image = nil;
        if([imgUrl hasPrefix:@"/"])
        {
            image = [UIImage imageWithContentsOfFile:imgUrl];
        }
        else
        {
            image = [UIImage imageNamed:imgUrl];
        }
        if(image)
        {
            CGRect rect = [CommonUtil rectFitWithScale:image.size rectMask:CGSizeMake(width, height)];
            
            image = [image imageAtRect:rect];
            image = [image imageByScalingToSize:CGSizeMake(width, height)];
            [share shareListVC:(UIViewController *)self.delegate loginType:loginType url:url shareTitle:title shareContent:content shareImg:image imgUrlString:imgUrl completed:^(BOOL success,NSString * message)
             {
                 [self.delegate shareViewDidShareCompleted:self success:success];
             }];
        }
        else
        {
            image = [UIImage imageNamed:@"New_logowithtext.png"];
            [share shareListVC:(UIViewController *)self.delegate loginType:loginType url:url shareTitle:title shareContent:content shareImg:image imgUrlString:imgUrl completed:^(BOOL success,NSString * message)
             {
                 [self.delegate shareViewDidShareCompleted:self success:success];
             }];
        }
    }
}

- (void)didCancel:(id)sender
{
    [self.delegate shareViewDidCancelClicked:self];
}

@end
