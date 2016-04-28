//
//  ShareView.h
//  maiba
//
//  Created by WangSiyu on 15/12/28.
//  Copyright © 2015年 seenvoice.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MTV.h"
@class OtherUserInfo;
@class ShareView;
@class UserInformation;
@protocol ShareViewDelegate <NSObject>

- (void)shareViewDidCancelClicked:(ShareView *)shareView;

- (void)shareViewDidShareCompleted:(ShareView *)shareView success:(BOOL)success;

//- (MTV*) getCurrentMTV;

@end

@interface ShareView : UIView

@property(nonatomic, weak) id<ShareViewDelegate> delegate;
@property(nonatomic,PP_STRONG) NSString * shareTitle;
- (void)setCurrentMTV:(MTV*)mtv;
- (void)setCurrentUser:(UserInformation *)userInfo;
- (void)setOtherUser:(OtherUserInfo *)userInfo;
- (void)setLinkerShare:(NSString *)urlString title:(NSString *)title image:(NSString *)imageUrlString content:(NSString *)content;
- (void)changeFrame:(CGRect)frame;
@end
