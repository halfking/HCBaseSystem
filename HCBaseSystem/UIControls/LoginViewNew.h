//
//  LoginViewNew.h
//  maiba
//
//  Created by WangSiyu on 15/12/31.
//  Copyright © 2015年 seenvoice.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HCBase.h"
#import "UIPlaceHolderTextField.h"
//#import <SMS_SDK/SMS_SDK.h>
#import <SMS_SDK/SMSSDK.h>
#import <SMS_SDK/SMSSDKCountryAndAreaCode.h>
#import <SMS_SDK/SMSSDK+DeprecatedMethods.h>
#import <SMS_SDK/SMSSDK+ExtexdMethods.h>
#import <MOBFoundation/MOBFoundation.h>

#import "UDManager.h"

@class LoginViewNew;

@protocol LoginViewNewDelegate<NSObject>

-(void)LoginView:(LoginViewNew *)view didLogin:(BOOL) completed;
-(void)LoginView:(LoginViewNew *)view didCancel:(BOOL)completed;

@end

@interface LoginViewNew : UIView<UDDelegate>
{
    UIView * bgCover_;
    UIButton * closeBtn_;
    
    UIButton * qqLogin_;
    UIButton * wbLogin_;
    UIButton * wxLogin_;
    UILabel * WelcomeLabel_;
    
    UIButton * mobileLogin_;
    UILabel * agreenLC_;
    
    int stag_;
    
    BOOL hasQQ_;
    BOOL hasWX_;
    BOOL hasWB_;
    
    UIPlaceHolderTextField * nicknameText_;
    UIPlaceHolderTextField * mobileText_;
    UIPlaceHolderTextField * passwordText_;
    UIButton * pwdBtn_;
    UIButton * loginBtn_;
    
    NSMutableArray * areaArray_;
    
    int secondsRemain_;
    NSTimer * cTimer_;
    
    CGFloat smallCoverViewWidth_;
    CGFloat smallCoverViewHeight_;
    UIView * coverView_;
    UILabel * agreeLabel_;
    
    NSString * uploadAvatarKey_;
    
    BOOL needCloseHttpServer_;
}
@property(nonatomic,PP_WEAK) id<LoginViewNewDelegate> delegate;

- (void)setSTag:(int)stag;
- (void)resetFrame:(CGRect)frame;
- (UIPlaceHolderTextField *) mobileTextField;
- (UIPlaceHolderTextField *) passwordTextField;

@end
