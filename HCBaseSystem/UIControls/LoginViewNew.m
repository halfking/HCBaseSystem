//
//  LoginView.m
//  Wutong
//
//  Created by HUANGXUTAO on 15/6/15.
//  Copyright (c) 2015年 HUANGXUTAO. All rights reserved.
//

#import "LoginViewNew.h"
#import "UserManager.h"
#import "UMShareObject.h"
#import <hccoren/base.h>
#import <hccoren/UIView+extension.h>
#import <SMS_SDK/SMSSDK.h>
#import <SMS_SDK/SMSSDKCountryAndAreaCode.h>
#import <SMS_SDK/SMSSDK+DeprecatedMethods.h>
#import <SMS_SDK/SMSSDK+ExtexdMethods.h>
#import <MOBFoundation/MOBFoundation.h>

#import "UIButton+Bootstrap.h"
#import <QuartzCore/QuartzCore.h>
#import "CMD_Login.h"
#import "CMD_ChangeUserAvatar.h"
#import "UDManager(Helper).h"
#import "SNAlterView.h"
#import "HWindowStack.h"
#import "HWindowStack(Open).h"

#import "HttpServerManager.h"

@implementation LoginViewNew
- (id)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        stag_ = 0;
        smallCoverViewHeight_ = 262;
        smallCoverViewWidth_ = 262;
        needCloseHttpServer_ = NO;
        
        UMShareObject * share = [UMShareObject shareObject];
        if(![share isInstalled:HCLoginTypeQQ])
        {
            NSLog(@"no---hide qq login----");
            hasQQ_ = NO;
        }
        else
        {
            hasQQ_ = YES;
        }
        if(![share isInstalled:HCLoginTypeWeixin])
        {
            hasWX_ = NO;
        }
        else
        {
            hasWX_ = YES;
        }
        if(![share isInstalled:HCLoginTypeSinaWeibo])
        {
            hasWB_ = NO;
        }
        else
        {
            hasWB_ = YES;
        }
        if(hasWB_==NO && hasQQ_ == NO && hasWX_==NO)
        {
            stag_ =1;
        }
        
        //        [self setupUI];
    }
    return self;
}
- (void)layoutSubviews
{
    [self setupUI];
    [super layoutSubviews];
}
- (id)init
{
    if(self = [super init])
    {
        stag_ = 0;
        
        UMShareObject * share = [UMShareObject shareObject];
        if(![share isInstalled:HCLoginTypeQQ])
        {
            NSLog(@"no---hide qq login----");
            hasQQ_ = NO;
        }
        else
        {
            hasQQ_ = YES;
        }
        if(![share isInstalled:HCLoginTypeWeixin])
        {
            hasWX_ = NO;
        }
        else
        {
            hasWX_ = YES;
        }
        if(![share isInstalled:HCLoginTypeSinaWeibo])
        {
            hasWB_ = NO;
        }
        else
        {
            hasWB_ = YES;
        }
        if(hasWB_==NO && hasQQ_ == NO && hasWX_==NO)
        {
            stag_ =1;
        }
        
    }
    return self;
}
- (void)setupUI
{
    //    self.layer.cornerRadius = 10;
    
    self.backgroundColor = [UIColor clearColor];
    
    //    //提交的时候要注释掉
    stag_ = 0;
    //    hasWX_=YES;
    //    hasQQ_ = YES;
    //    hasWB_ = YES;
    if(closeBtn_) return;
    
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    
    
    //    CGFloat smallCoverViewWidth = 262;
    //    CGFloat smallCoverViewHeight = 262;
    
    CGFloat btnWidth = 60.0,btnHeight =60.0;
    
    CGFloat top = (height-smallCoverViewHeight_)/2;
    CGFloat left = (width-smallCoverViewWidth_)/2;
    //background
    UIViewController * vc = [self traverseResponderChainForUIViewController];
    
    {
        //        bgCover_=[[UIView alloc]initWithFrame:self.bounds];
        //        bgCover_.backgroundColor = [UIColor blackColor];
        //        bgCover_.alpha = 0.6;
        //
        //        [self addSubview:bgCover_];
        //        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(LoginCancel:)];
        //        [bgCover_ addGestureRecognizer:tap];
        //        PP_RELEASE(tap);
    }
    
    //smallCoverView
    {
        coverView_ = [[UIView alloc]initWithFrame:CGRectMake(left, top, smallCoverViewWidth_, smallCoverViewHeight_)];
        coverView_.backgroundColor = [UIColor whiteColor];
        coverView_.alpha = 1;
        coverView_.layer.cornerRadius = 10;
        [self addSubview:coverView_];
    }
    {
        closeBtn_ = PP_RETAIN([UIButton buttonWithType:UIButtonTypeCustom]);
        closeBtn_.frame = CGRectMake(left + smallCoverViewWidth_ - 22,top -22 , 44, 44);
        [closeBtn_ setImage:[UIImage imageNamed:@"close_icon.png"] forState:UIControlStateNormal];
        [closeBtn_ addTarget:self action:@selector(LoginCancel:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:closeBtn_];
    }
    
    //stag = 0带图标的情况
    {
        top+=31;
        //Label:欢迎登录
        {
            
            UIFont * font = [UIFont systemFontOfSize:15];
            NSString * title = @"登录麦爸";
            CGSize textSize = [title sizeWithAttributes:@{NSFontAttributeName:font}];
            
            WelcomeLabel_ =[[UILabel alloc]initWithFrame:CGRectMake(left , top, smallCoverViewWidth_, textSize.height +1)];
            WelcomeLabel_.text = title;
            WelcomeLabel_.textColor = COLOR_CF;
            WelcomeLabel_.textAlignment = NSTextAlignmentCenter;
            WelcomeLabel_.font = [UIFont systemFontOfSize:15];
            WelcomeLabel_.backgroundColor = [UIColor clearColor];
            {
                UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(33 ,  textSize.height/2-0.5, 62, 0.5)];
                line1.backgroundColor = COLOR_CA;
                [WelcomeLabel_ addSubview:line1];
                
                UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(smallCoverViewWidth_ - 33 - 62, textSize.height/2-0.5, 62, 0.5)];
                line2.backgroundColor = COLOR_CA;
                [WelcomeLabel_ addSubview:line2];
                
            }
            [self addSubview:WelcomeLabel_];
            if(stag_!=0)
            {
                WelcomeLabel_.hidden = YES;
                
            }
            top +=38 + textSize.height;
        }
        
        //buttons
        CGRect centerFrame = CGRectMake((self.bounds.size.width- btnWidth)/2.0f, top, btnWidth, btnHeight);//???
        
        if(hasQQ_){
            qqLogin_ = PP_RETAIN([UIButton buttonWithType:UIButtonTypeCustom]);
            qqLogin_.frame = centerFrame;
            [qqLogin_ setImage:[UIImage imageNamed:@"qqlogin_icon.png"] forState:UIControlStateNormal];
            [qqLogin_ addTarget:self action:@selector(loginByQQ:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:qqLogin_];
            if(stag_!=0)
                qqLogin_.hidden =YES;
        }
        centerFrame.origin.x = 25;
        if(hasWX_){
            wxLogin_ = PP_RETAIN([UIButton buttonWithType:UIButtonTypeCustom]);
            wxLogin_.frame = centerFrame;
            [wxLogin_ setImage:[UIImage imageNamed:@"wechatlogin_icon.png"] forState:UIControlStateNormal];
            [wxLogin_ addTarget:self action:@selector(LoginViaWeixin:) forControlEvents:UIControlEventTouchUpInside];
            
            [self addSubview:wxLogin_];
            if(stag_!=0)
                wxLogin_.hidden =YES;
        }
        centerFrame.origin.x = self.bounds.size.width - 25 - btnWidth;
        if(hasWB_)
        {
            wbLogin_ = PP_RETAIN([UIButton buttonWithType:UIButtonTypeCustom]);
            wbLogin_.frame = centerFrame;
            [wbLogin_ setImage:[UIImage imageNamed:@"sinalogin_icon.png"] forState:UIControlStateNormal];
            [wbLogin_ addTarget:self action:@selector(LoginViaWeibo:) forControlEvents:UIControlEventTouchUpInside];
            
            [self addSubview:wbLogin_];
            if(stag_!=0)
                wbLogin_.hidden =YES;
        }
        //重新设定button的位置。
        [self setButtonsSpace:self.bounds];
        
        
        centerFrame.origin.y += 27 + 60;
        centerFrame.size.height = 24;
        centerFrame.size.width = 110;
        centerFrame.origin.x = (self.bounds.size.width - centerFrame.size.width)/2.0f;//水平居中。
        {
            NSString * text = @"手机号登录";
            mobileLogin_ = PP_RETAIN([UIButton buttonWithType:UIButtonTypeSystem]);
            CGRect tFrame = CGRectMake(0, centerFrame.origin.y,smallCoverViewWidth_ - 25 * 2, 40);
            tFrame.origin.x = (self.bounds.size.width - tFrame.size.width)/2.0f;
            mobileLogin_.frame = tFrame;
            [self addSubview:mobileLogin_];
            
            [mobileLogin_ defaultStyleWithColorN:COLOR_BA bgColor:COLOR_E];
            [mobileLogin_ setTitle:text forState:UIControlStateNormal];
            [mobileLogin_ setTitleColor:COLOR_CG forState:UIControlStateNormal];
            [mobileLogin_ setTitleColor:COLOR_CG forState:UIControlStateHighlighted];
            mobileLogin_.backgroundColor = COLOR_BA;
            
            
            //            mobileLogin_ = PP_RETAIN([UIButton buttonWithType:UIButtonTypeSystem]);
            //            mobileLogin_.frame = centerFrame;
            //            [mobileLogin_ setTitle:text forState:UIControlStateNormal];
            //            [mobileLogin_ setTitleColor:COLOR_BA forState:UIControlStateHighlighted];
            //            [mobileLogin_ setTitleColor:COLOR_BA forState:UIControlStateNormal];
            //            mobileLogin_.titleLabel.font = [UIFont systemFontOfSize:10];
            //            mobileLogin_.titleLabel.textAlignment = NSTextAlignmentCenter;
            //            mobileLogin_.layer.borderColor = COLOR_BA.CGColor;
            //            mobileLogin_.layer.borderWidth = 1;
            //            [mobileLogin_.layer setCornerRadius:3.0];
            [mobileLogin_ addTarget:self action:@selector(changeToMobile:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:mobileLogin_];
            if(stag_!=0)
                mobileLogin_.hidden =YES;
        }
        centerFrame.origin.y +=50;
        
        UIFont * font = [UIFont systemFontOfSize:12];
        {
            
            centerFrame.size.width = [@"登录或注册表示我同意《麦爸使用协议》" sizeWithAttributes:@{NSFontAttributeName:font}].width + 4;
            centerFrame.origin.x = (self.bounds.size.width - centerFrame.size.width)/2.0f ;//水平居中。
        }
        //Label:同意用户协议
        {
            CGFloat leftWidth = [@"登录或注册表示我同意" sizeWithAttributes:@{NSFontAttributeName:font}].width+2;
            CGRect leftFrame = CGRectMake(centerFrame.origin.x -10, centerFrame.origin.y, leftWidth+10, centerFrame.size.height);
            
            agreenLC_ = [[UILabel alloc]initWithFrame:leftFrame];
            agreenLC_.text = @"登录或注册表示我同意";
            agreenLC_.textColor = COLOR_R;
            agreenLC_.textAlignment = NSTextAlignmentRight;
            agreenLC_.font = font;
            [self addSubview:agreenLC_];
            
            centerFrame.origin.x += leftWidth;
            centerFrame.size.width -= leftWidth -20;
        }
        {
            UILabel *label = [[UILabel alloc]initWithFrame:centerFrame];
            label.text = @"《麦爸使用协议》";
            label.textColor = COLOR_G;
            label.textAlignment = NSTextAlignmentLeft;
            label.font = font;
            [self addSubview:label];
            
            UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showULC:)];
            [label addGestureRecognizer:tap];
            label.userInteractionEnabled = YES;
            tap = nil;
            
            agreeLabel_ = label;
        }
    }
    
    // stag =1
    {
        top = (height-smallCoverViewHeight_)/2 +30;
        left = (width - smallCoverViewWidth_)/2 +25;
        
        CGFloat textHeight = 40.0;
        CGRect tempFrame = CGRectMake(left,top, smallCoverViewWidth_ - 25 * 2, textHeight);
        {
            nicknameText_ = [[UIPlaceHolderTextField alloc]initWithFrame:tempFrame];
            nicknameText_.frame = tempFrame;
            nicknameText_.placeholderString = @"请输入昵称";
            nicknameText_.placeholderColor = COLOR_CE;
            nicknameText_.placeholderFont = [UIFont systemFontOfSize:12.0f];
            nicknameText_.delegate = (id<UITextFieldDelegate>)vc;
            nicknameText_.layer.borderWidth = 1;
            nicknameText_.layer.cornerRadius = 4.0;
            nicknameText_.layer.masksToBounds = YES;
            nicknameText_.layer.borderColor = [COLOR_F CGColor];
            nicknameText_.keyboardType = UIKeyboardTypeDefault;
            nicknameText_.returnKeyType = UIReturnKeyNext;
            UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
            nicknameText_.leftView = paddingView;
            nicknameText_.leftViewMode = UITextFieldViewModeAlways;
            nicknameText_.tag = 701;
            
            nicknameText_.backgroundColor = COLOR_CA;
            
            [self addSubview:nicknameText_];
            if(stag_==0)
                nicknameText_.hidden = YES;
            
        }
        tempFrame.origin.y += 15 + 40;
        //        tempFrame.size.width = 120;
        {
            mobileText_ = [[UIPlaceHolderTextField alloc]initWithFrame:tempFrame];
            mobileText_.frame = tempFrame;
            mobileText_.placeholderString = @"请输入手机号";
            mobileText_.placeholderColor = COLOR_CE;
            mobileText_.placeholderFont = [UIFont systemFontOfSize:12.0f];
            mobileText_.delegate = (id<UITextFieldDelegate>)vc;
            mobileText_.layer.borderWidth = 1;
            mobileText_.layer.cornerRadius = 4.0;
            mobileText_.layer.masksToBounds = YES;
            mobileText_.layer.borderColor = [COLOR_F CGColor];
            mobileText_.keyboardType = UIKeyboardTypeNumberPad;
            mobileText_.returnKeyType = UIReturnKeyNext;
            UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
            mobileText_.leftView = paddingView;
            mobileText_.leftViewMode = UITextFieldViewModeAlways;
            mobileText_.tag = 702;
            
            mobileText_.backgroundColor = COLOR_CA;
            
            [self addSubview:mobileText_];
            if(stag_==0)
                mobileText_.hidden = YES;
        }
        tempFrame.origin.y += 15 + 40;
        {
            pwdBtn_ = PP_RETAIN([UIButton buttonWithType:UIButtonTypeCustom]);
            pwdBtn_.frame = CGRectMake(tempFrame.origin.x + tempFrame.size.width - 120, tempFrame.origin.y, 120, tempFrame.size.height);
            [self addSubview:pwdBtn_];
            
            [pwdBtn_ defaultStyleWithColorN:COLOR_BA bgColor:COLOR_E];
            [pwdBtn_ setTitle:@"  获取验证码  " forState:UIControlStateNormal];
            [pwdBtn_ setTitleColor:COLOR_CG forState:UIControlStateNormal];
            [pwdBtn_ setTitleColor:COLOR_CG forState:UIControlStateHighlighted];
            pwdBtn_.titleLabel.textAlignment = NSTextAlignmentCenter;
            pwdBtn_.backgroundColor = COLOR_BA;
            pwdBtn_.titleLabel.font = [UIFont systemFontOfSize:13];
            [pwdBtn_ addTarget:self action:@selector(sendSMS:) forControlEvents:UIControlEventTouchUpInside];
            
            if(stag_ ==0)
                pwdBtn_.hidden = YES;
        }
        //        tempFrame.origin.y +=55;
        tempFrame.size.width -= 120 + 10;
        {
            passwordText_ = [[UIPlaceHolderTextField alloc]initWithFrame:tempFrame];
            passwordText_.frame = tempFrame;
            passwordText_.placeholderString = @"请输入验证码";
            passwordText_.placeholderFont = [UIFont systemFontOfSize:12.0f];
            passwordText_.backgroundColor = COLOR_CA;
            passwordText_.placeholderColor = COLOR_CE;
            passwordText_.layer.borderWidth = 1;
            passwordText_.layer.cornerRadius = 4.0;
            passwordText_.layer.masksToBounds = YES;
            passwordText_.layer.borderColor = [COLOR_F CGColor];
            passwordText_.keyboardType = UIKeyboardTypeNumberPad;
            passwordText_.returnKeyType = UIReturnKeyDone;
            
            UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
            passwordText_.leftView = paddingView;
            passwordText_.leftViewMode = UITextFieldViewModeAlways;
            
            passwordText_.delegate = (id<UITextFieldDelegate>)vc;
            passwordText_.tag = 703;
            [self addSubview:passwordText_];
            if(stag_ ==0)
                passwordText_.hidden = YES;
        }
        
        tempFrame.size.width+= 120+10;
        tempFrame.origin.y += 55;
        //        tempFrame.origin.x = (self.bounds.size.width - 60)/2.0f;
        {
            loginBtn_ = PP_RETAIN([UIButton buttonWithType:UIButtonTypeSystem]);
            loginBtn_.frame = tempFrame;
            [self addSubview:loginBtn_];
            
            [loginBtn_ defaultStyleWithColorN:COLOR_BA bgColor:COLOR_E];
            [loginBtn_ setTitle:@"登 录" forState:UIControlStateNormal];
            [loginBtn_ setTitleColor:COLOR_CG forState:UIControlStateNormal];
            [loginBtn_ setTitleColor:COLOR_CG forState:UIControlStateHighlighted];
            loginBtn_.backgroundColor = COLOR_BA;
            
            //            loginBtn_.enabled = NO;
            [loginBtn_ addTarget:self action:@selector(LoginViaMobile:) forControlEvents:UIControlEventTouchUpInside];
            if(stag_ ==0)
                loginBtn_.hidden = YES;
        }
        [self resetFrame:self.bounds];
        
    }
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(orientationChanged:)
                                                 name:UIApplicationDidChangeStatusBarOrientationNotification
                                               object:nil];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissKeyboard:)];
    [self addGestureRecognizer:tap];
    PP_RELEASE(tap);
    
    
    //    [[NSNotificationCenter defaultCenter] addObserver:self
    //                                             selector:@selector(userChanged:)
    //                                                 name:NT_USERINFOCHANGED object:nil];
    //    [[NSNotificationCenter defaultCenter] addObserver:self
    //                                             selector:@selector(userChanged:)
    //                                                 name:NT_USERIDCHANGED object:nil];
    
    if(!hasQQ_ && !hasWB_ && !hasWX_)
    {
        [self setSTag:1];
    }
}
- (void)showULC:(id)sender
{
    NSLog(@"show user ageen license.");
    needCloseHttpServer_ = YES;
    [[HttpServerManager shareObject]startHttpServer];
    NSString * urlString = [[HttpServerManager shareObject]buildUrlForResource:@"agreement.html"];
    [[HWindowStack shareObject]openWindow:[self traverseResponderChainForUIViewController] urlString:urlString shouldOpenWeb:YES];
}
- (void)agreeClicked:(id)sender
{
    //    [agreenLC_ setSelected:agreenLC_.isSelected];
}
- (BOOL)checkAgreement
{
    //    if(agreenLC_.selected == NO)
    //    {
    //        SNAlertView * alertView = [[SNAlertView alloc]initWithTitle:@"提示"
    //                                                            message:@"请同意用户协议后再进行后继操作。"
    //                                                           delegate:nil
    //                                                  cancelButtonTitle:EDIT_IKNOWN
    //                                                  otherButtonTitles:nil];
    //        [alertView show];
    //        alertView = nil;
    //        return NO;
    //    }
    return YES;
}
- (void)dismissKeyboard:(UIGestureRecognizer *)gestureRecognizer {
    //此method会将self.view里所有的subview的first responder都resign掉
    //    [self endEditing:YES];
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];//关闭键盘
}
- (void)orientationChanged:(id)sender
{
    [self resetFrame:self.bounds];
}
- (void)resetFrame:(CGRect)frame
{
    if(frame.size.width == self.frame.size.width && frame.size.height == self.frame.size.height)
    {
        if((WelcomeLabel_.hidden && stag_ ==1) || (WelcomeLabel_.hidden == NO && stag_==0))
        {
            return;
        }
    }
    
    CGFloat width = frame.size.width;
    CGFloat height = frame.size.height;
    
    
    //    CGFloat smallCoverViewWidth = 262;
    //    CGFloat smallCoverViewHeight = 262;
    
    CGFloat btnWidth = 60.0,btnHeight =60.0;
    
    CGFloat top = (height-smallCoverViewHeight_)/2;
    CGFloat left = (width-smallCoverViewWidth_)/2;
    
    
    //smallCoverView
    coverView_.frame =CGRectMake(left, top, smallCoverViewWidth_, smallCoverViewHeight_);
    closeBtn_.frame = CGRectMake(left + smallCoverViewWidth_ - 22,top - 22, 44, 44);
    
    
    if(stag_==0)
    {
        top+=31;
        //Label:欢迎登录
        {
            CGRect textFrame = WelcomeLabel_.frame;
            textFrame.origin.x = left;
            textFrame.origin.y = top;
            
            WelcomeLabel_.frame = textFrame;
            WelcomeLabel_.hidden = NO;
            top +=38 + textFrame.size.height-1;
        }
        
        //buttons
        CGRect centerFrame = CGRectMake((self.bounds.size.width- btnWidth)/2.0f, top, btnWidth, btnHeight);//???
        
        if(hasQQ_){
            
            qqLogin_.frame = centerFrame;
            qqLogin_.hidden = NO;
        }
        centerFrame.origin.x = 25;
        if(hasWX_){
            
            wxLogin_.frame = centerFrame;
            wxLogin_.hidden =NO;
        }
        centerFrame.origin.x = self.bounds.size.width - 25 - btnWidth;
        if(hasWB_)
        {
            wbLogin_.frame = centerFrame;
            wbLogin_.hidden = NO;
        }
        
        
        centerFrame.origin.y += 40 + 64;
        centerFrame.size.height = 24;
        centerFrame.size.width = 110;
        centerFrame.origin.x = (self.bounds.size.width - centerFrame.size.width)/2.0f;//水平居中。
        {
            mobileLogin_.frame = centerFrame;
            mobileLogin_.hidden = NO;
        }
        //Label:同意用户协议
        {
            centerFrame.origin.y +=30;
            
            CGRect leftFrame = agreenLC_.frame;
            leftFrame.origin.y = centerFrame.origin.y;
            agreenLC_.frame = leftFrame;
            
            CGRect rightFrame = agreeLabel_.frame;
            rightFrame.origin.y = centerFrame.origin.y;
            agreeLabel_.frame = rightFrame;
        }
        
        nicknameText_.hidden = YES;
        mobileText_.hidden = YES;
        passwordText_.hidden = YES;
        pwdBtn_.hidden = YES;
        loginBtn_.hidden = YES;
        
    }
    else
    {
        WelcomeLabel_.hidden = YES;
        wxLogin_.hidden = YES;
        qqLogin_.hidden = YES;
        wbLogin_.hidden = YES;
        mobileLogin_.hidden = YES;
        //        agreeLabel_.hidden = YES;
        
        nicknameText_.hidden = NO;
        mobileText_.hidden = NO;
        passwordText_.hidden = NO;
        pwdBtn_.hidden = NO;
        loginBtn_.hidden = NO;
        
        
        
        top = (height-smallCoverViewHeight_)/2 +30 -5;
        left = (width - smallCoverViewWidth_)/2 +25;
        
        CGFloat textHeight = 40.0;
        CGRect tempFrame = CGRectMake(left,top, smallCoverViewWidth_ - 25 * 2, textHeight);
        nicknameText_.frame = tempFrame;
        
        tempFrame.origin.y += 15 + 40;
        mobileText_.frame = tempFrame;
        tempFrame.origin.y += 15 + 40;
        
        pwdBtn_.frame = CGRectMake(tempFrame.origin.x + tempFrame.size.width - 120, tempFrame.origin.y, 120, tempFrame.size.height);
        
        //        tempFrame.origin.y +=55;
        tempFrame.size.width -= 120 + 10;
        
        passwordText_.frame = tempFrame;
        
        tempFrame.size.width+= 120+10;
        tempFrame.origin.y += 55;
        
        loginBtn_.frame = tempFrame;
        
        //Label:同意用户协议
        {
            
            tempFrame.origin.y +=40;
            
            CGRect leftFrame = agreenLC_.frame;
            leftFrame.origin.y = tempFrame.origin.y;
            agreenLC_.frame = leftFrame;
            
            CGRect rightFrame = agreeLabel_.frame;
            rightFrame.origin.y = tempFrame.origin.y;
            agreeLabel_.frame = rightFrame;
        }
        
        
    }
    [self setNeedsDisplay];
}

- (void)setButtonsSpace:(CGRect)frame
{
    int buttons = 0;
    
    CGFloat btnWidth = 60;
    if(hasQQ_) buttons++;
    if(hasWX_) buttons++;
    if(hasWB_) buttons++;
    
    if(buttons==0) return;
    //    DeviceConfig * config = [DeviceConfig config];
    CGFloat margin = 0;//config.Height >=568? config.Height / 5:30; //用来校正一些值？
    
    //    CGFloat vSpace = (frame.size.width - btnWidth * buttons - margin*2)/(buttons+1);
    
    CGFloat vSpace = (smallCoverViewWidth_ - btnWidth * buttons - margin*2)/(buttons+1);
    
    CGFloat left = (frame.size.width - smallCoverViewWidth_)/2.0f + margin +vSpace;
    
    if(hasWX_)
    {
        CGRect frame = wxLogin_.frame;
        frame.origin.x = left;
        wxLogin_.frame = frame;
        left += btnWidth+vSpace;
    }
    //    else
    //    {
    //        left = margin +vSpace;
    //    }
    
    if(hasQQ_)
    {
        CGRect frame = qqLogin_.frame;
        frame.origin.x = left;
        qqLogin_.frame = frame;
        left += btnWidth+vSpace;
    }
    if(hasWB_)
    {
        CGRect frame = wbLogin_.frame;
        frame.origin.x = left;
        wbLogin_.frame = frame;
    }
    
}
- (void)setSTag:(int)stag
{
    if(stag_ == stag) return;
    stag_ = stag;
    if(stag==1)
    {
        [self resetFrame:self.bounds];
    }
    else if(stag==0)
    {
        [self resetFrame:self.bounds];
    }
    
}

#pragma mark - events
//- (void)setButtonsEnable:(BOOL)enable
//{
//    dispatch_async(dispatch_get_main_queue(), ^{
//
//        if(qqLogin_)
//        {
//            qqLogin_.enabled = enable;
//        }
//        if(wxLogin_)
//        {
//            wxLogin_.enabled = enable;
//        }
//        if(wbLogin_)
//        {
//            wbLogin_.enabled = enable;
//        }
//        if(mobileLogin_)
//        {
//            mobileLogin_.enabled = enable;
//        }
//    });
//}

- (void)loginByQQ:(id)sender
{
    if(![self checkAgreement]) return ;
    //    [self setButtonsEnable:NO];
    UMShareObject * share = [UMShareObject shareObject];
    UIViewController * vc = [self traverseResponderChainForUIViewController];
    [share login:vc loginType:HCLoginTypeQQ completed:^(HCLoginType loginType,BOOL success)
     {
         [self loginDone:0 success:success];
         //         [self setButtonsEnable:YES];
     }];
}

- (void)LoginViaWeixin:(id)sender {
    
    if(![self checkAgreement]) return ;
    //    [self setButtonsEnable:NO];
    UMShareObject * share = [UMShareObject shareObject];
    UIViewController *vc = [self traverseResponderChainForUIViewController];
    [share login:vc loginType:HCLoginTypeWeixin completed:^(HCLoginType loginType,BOOL success)
     {
         [self loginDone:0 success:success];
         //         [self setButtonsEnable:YES];
     }];
    
}

- (void)LoginViaWeibo:(id)sender {
    
    if(![self checkAgreement]) return ;
    //    [self setButtonsEnable:NO];
    UMShareObject * share = [UMShareObject shareObject];
    UIViewController *vc = [self traverseResponderChainForUIViewController];
    [share login:vc loginType:HCLoginTypeSinaWeibo completed:^(HCLoginType loginType,BOOL success)
     {
         [self loginDone:0 success:success];
         //         [self setButtonsEnable:YES];
     }];
    
}
- (void)changeToMobile:(id)sender
{
    [self setSTag:1];
    
}
- (void)LoginViaMobile:(id)sender
{
    if(![self checkAgreement]) return ;
    NSString * regionCode = @"+86";
    NSString * telNumber = [mobileText_.text trimWhitespace];
    
    if(!nicknameText_.text||nicknameText_.text.length<2)
    {
        UIAlertView* alert=[[UIAlertView alloc] initWithTitle:MSG_PROMPT
                                                      message:@"昵称不能少于2个字符，请重新输入"
                                                     delegate:self
                                            cancelButtonTitle:EDIT_OK
                                            otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    
    if(!mobileText_.text || mobileText_.text.length < 8 || passwordText_.text.length!=4)
    {
        UIAlertView* alert=[[UIAlertView alloc] initWithTitle:MSG_PROMPT
                                                      message:MSG_INVALIDMBINPUT
                                                     delegate:self
                                            cancelButtonTitle:EDIT_OK
                                            otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    else
    {
        //demo account
        if([mobileText_.text isEqual:@"12345678901"])
        {
            [[UserManager sharedUserManager]demoUserLogin:mobileText_.text loginType:HCLoginTypeMobile password:passwordText_.text completed:^(BOOL completed)
             {
                 [self loginDone:HCLoginTypeMobile success:YES];
             }];
        }
        else
        {
            //[[SMS_SDK sharedInstance] commitVerifyCode:self.verifyCodeField.text];
            [SMSSDK commitVerificationCode:passwordText_.text phoneNumber:telNumber zone:regionCode result:^(NSError *error) {
                //            [SMSSDK commitVerifyCode:passwordText_.text result:^(enum SMS_ResponseState state) {
                //                if (1==state)
                if(!error)
                {
                    NSLog(@"验证成功");
                    NSString * userName = nil;
                    if(nicknameText_.text && nicknameText_.text.length>0)
                    {
                        userName = nicknameText_.text;
                    }
                    else
                    {
                        userName = [NSString stringWithFormat:@"%@ %@",[regionCode stringByReplacingOccurrencesOfString:@"+" withString:@""],telNumber];
                        if(userName.length>5)
                        {
                            userName = [NSString stringWithFormat:@"%@****%@",
                                        [userName substringToIndex:4],
                                        [userName substringFromIndex:userName.length-4]];
                        }
                        else
                        {
                            userName = [NSString stringWithFormat:@"%@****4531",userName];
                        }
                    }
                    [[UserManager sharedUserManager]userLogin:userName
                                                       userid:[NSString stringWithFormat:@"%@%@",regionCode,telNumber]
                                                         icon:nil
                                                 accessTocken:passwordText_.text
                                                       source:HCLoginTypeMobile completed:^(BOOL completed)
                     {
                         [self loginDone:0 success:YES];
                     }];
                    
                    
                }
                else //if(0==state)
                {
                    //[NSString stringWithFormat:@"%@",[error.userInfo objectForKey:@"commitVerificationCode"]]
                    NSLog(@"验证失败");
                    UIAlertView* alert=[[UIAlertView alloc] initWithTitle:MSG_PROMPT
                                                                  message:MSG_VERFYCODEERROR
                                                                 delegate:self
                                                        cancelButtonTitle:EDIT_IKNOWN
                                                        otherButtonTitles:nil, nil];
                    [alert show];
                    if(!cTimer_)
                    {
                        secondsRemain_ = 0;
                        [self showTimerForBtn:nil];
                    }
                }
            }];
        }
    }
}
- (void)userChanged:(NSNotification *)notification
{
    //    if(!notification || !notification.object) return;
    if([[UserManager sharedUserManager]isLogin])
    {
        UserInformation * user = [[UserManager sharedUserManager]currentUser];
        [self loginDone:(int)user.LoginType success:YES];
    }
    
}
- (void)loginDone:(int)type success:(BOOL)success
{
    if(cTimer_)
    {
        [cTimer_ invalidate];
        PP_RELEASE(cTimer_);
    }
    if(needCloseHttpServer_)
    {
        [[HttpServerManager shareObject]stopHttpServer];
    }
    //    [[NSNotificationCenter defaultCenter]postNotificationName:NT_USERIDCHANGED object:nil];
    __weak __typeof(self)weakSelf = self;
    if(self.delegate)
    {
        [self.delegate LoginView:weakSelf didLogin:success];
    }
    if(success)
    {
        //        [self getUserAvatarThirdPart];
        [[NSNotificationCenter defaultCenter]removeObserver:self];
    }
    
}
- (void)LoginCancel:(id)sender
{
    if(cTimer_)
    {
        [cTimer_ invalidate];
        PP_RELEASE(cTimer_);
    }
    //    if(stag_==1)
    //    {
    //        [self setSTag:0];
    //        return;
    //    }
    
    if(needCloseHttpServer_)
    {
        [[HttpServerManager shareObject]stopHttpServer];
    }
    
    __weak __typeof(self)weakSelf = self;
    if(self.delegate)
    {
        [self.delegate LoginView:weakSelf didCancel:YES];
    }
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

#pragma mark - sendsms
//暂时只支持中国 +86
-(void)sendSMS:(id)sender
{
    
    if(secondsRemain_ >1) return;
    
    //    [self didSended:nil];
    //    return;
    
    int compareResult = 0;
    NSString * regionCode = @"+86";
    NSString * telNumber = [mobileText_.text trimWhitespace];
    
    for (int i=0; i<areaArray_.count; i++)
    {
        NSDictionary* dict1=[areaArray_ objectAtIndex:i];
        NSString* code1=[dict1 valueForKey:@"zone"];
        
        if ([code1 isEqualToString:[regionCode stringByReplacingOccurrencesOfString:@"+" withString:@""]])
        {
            compareResult=1;
            NSString* rule1=[dict1 valueForKey:@"rule"];
            NSPredicate* pred=[NSPredicate predicateWithFormat:@"SELF MATCHES %@",rule1];
            BOOL isMatch=[pred evaluateWithObject:telNumber];
            if (!isMatch)
            {
                //手机号码不正确
                UIAlertView* alert=[[UIAlertView alloc] initWithTitle:MSG_PROMPT
                                                              message:MSG_INVALIDMOBILE
                                                             delegate:self
                                                    cancelButtonTitle:EDIT_IKNOWN
                                                    otherButtonTitles:nil, nil];
                [alert show];
                return;
            }
            break;
        }
    }
    
    if (!compareResult)
    {
        if (telNumber.length!=11)
        {
            //手机号码不正确
            UIAlertView* alert=[[UIAlertView alloc] initWithTitle:MSG_PROMPT
                                                          message:MSG_INVALIDMOBILE
                                                         delegate:self
                                                cancelButtonTitle:EDIT_IKNOWN
                                                otherButtonTitles:nil, nil];
            [alert show];
            return;
        }
    }
    
    //send
    
    pwdBtn_.enabled = NO;
    pwdBtn_.layer.borderColor = [COLOR_E CGColor];
    pwdBtn_.backgroundColor = COLOR_E;
    
    
    //    [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:self.telField.text
    //                                   zone:str2
    //                       customIdentifier:nil
    //                                 result:^(NSError *error)
    //
    [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:telNumber
                                   zone:@"86"    //[regionCode stringByReplacingOccurrencesOfString:@"+" withString:@""]
                       customIdentifier:nil
                                 result:^(NSError *error)
     {
         if (!error)
         {
             //显示按钮，并倒计时
             [self didSended:nil];
         }
         else
         {
             //             UIAlertView* alert=[[UIAlertView alloc] initWithTitle:MSG_SENDERROR
             //                                                           message:[NSString stringWithFormat:@"状态码：%zi ,错误描述：%@",error.code,[error localizedDescription]]
             //                                                          delegate:self
             //                                                 cancelButtonTitle:EDIT_IKNOWN
             //                                                 otherButtonTitles:nil, nil];
             
             UIAlertView* alert=[[UIAlertView alloc] initWithTitle:MSG_SENDERROR
                                                           message:@"获取验证失败，请检查号码是否正确或者操作过于频繁。"
                                                          delegate:self
                                                 cancelButtonTitle:EDIT_IKNOWN
                                                 otherButtonTitles:nil, nil];
             [alert show];
             
             pwdBtn_.layer.borderColor = [COLOR_BUTTON CGColor];
             pwdBtn_.backgroundColor = COLOR_BA;
             pwdBtn_.enabled = YES;
         }
         
     }];
    
}
- (void)didSended:(id)sender
{
    secondsRemain_ = 60;
    pwdBtn_.enabled = NO;
    pwdBtn_.layer.borderColor = [COLOR_E CGColor];
    pwdBtn_.backgroundColor = COLOR_E;
    if(cTimer_)
    {
        [cTimer_ invalidate];
        PP_RELEASE(cTimer_);
    }
    cTimer_ = PP_RETAIN([NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(showTimerForBtn:) userInfo:nil repeats:YES]);
}
- (void)showTimerForBtn:(NSTimer *)timer
{
    secondsRemain_ --;
    if(secondsRemain_ >0)
        pwdBtn_.titleLabel.text = [NSString stringWithFormat:@"%d秒重新获取",secondsRemain_];
    else
    {
        [cTimer_ invalidate];
        PP_RELEASE(cTimer_);
        pwdBtn_.titleLabel.text = @"  获取验证码  ";
        pwdBtn_.layer.borderColor = [COLOR_BUTTON CGColor];
        pwdBtn_.backgroundColor = COLOR_BA;
        pwdBtn_.enabled = YES;
    }
}
#pragma mark - getData
- (void)loadData
{
    //    areaArray_= [NSMutableArray new];
    
    PP_RELEASE(areaArray_);
    //设置本地区号
    [self setTheLocalAreaCode];
    
    NSString *saveTimeString = [[NSUserDefaults standardUserDefaults] objectForKey:@"saveDate"];
    
    NSDateComponents *dateComponents = nil;
    
    if (saveTimeString.length != 0) {
        
        dateComponents = [self compareTwoDays:saveTimeString];
        
    }
    
    if (dateComponents.day >= 1 || saveTimeString.length == 0) { //day = 0 ,代表今天，day = 1  代表昨天  day >= 1 表示至少过了一天  saveTimeString.length == 0表示从未进行过缓存
        
        
        [SMSSDK getCountryZone:^(NSError *error, NSArray *zonesArray) {
            
            if (!error) {
                
                NSLog(@"get the area code sucessfully");
                PP_RELEASE(areaArray_);
                areaArray_=[[NSMutableArray alloc]initWithArray:zonesArray];
                
                //获取到国家列表数据后对进行缓存
                [[MOBFDataService sharedInstance] setCacheData:areaArray_ forKey:@"countryCodeArray" domain:nil];
                //设置缓存时间
                NSDate *saveDate = [NSDate date];
                [[NSUserDefaults standardUserDefaults] setObject:[MOBFDate stringByDate:saveDate withFormat:@"yyyy-MM-dd"] forKey:@"saveDate"];
                
                //            NSLog(@"_areaArray_%@",areaArray_);
            }
            else
            {
                NSLog(@"failed to get the area code _%@",[error.userInfo objectForKey:@"getZone"]);
            }
        }];
    }
    else
    {
        areaArray_ = [[MOBFDataService sharedInstance] cacheDataForKey:@"countryCodeArray" domain:nil];
    }
    //    //获取支持的地区列表
    //    [SMSSDK getZone:^(enum SMSResponseState state, NSArray *array)
    //     {
    //         if (1 == state)
    //         {
    //             NSLog(@"get the area code sucessfully");
    //             //区号数据
    //             PP_RELEASE(areaArray_);
    //             areaArray_=[[NSMutableArray alloc]initWithArray:array];
    //         }
    //         else if (0 == state)
    //         {
    //             NSLog(@"failed to get the area code");
    //         }
    //
    //     }];
    
}
/**
 *  计算两个日期的天数差
 *
 *  @param dateString 待计算日期
 *
 *  @return 返回NSDateComponents,通过属性day,可以判断待计算日期和当前日期的天数差
 */
- (NSDateComponents*)compareTwoDays:(NSString *)dateString
{
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    [gregorian setFirstWeekday:2];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *fromDate;
    NSDate *toDate;
    [gregorian rangeOfUnit:NSCalendarUnitDay startDate:&fromDate interval:NULL forDate:[dateFormatter dateFromString:dateString]];
    [gregorian rangeOfUnit:NSCalendarUnitDay startDate:&toDate interval:NULL forDate:[NSDate date]];
    NSDateComponents *dayComponents = [gregorian components:NSCalendarUnitDay | NSWeekdayCalendarUnit fromDate:fromDate toDate:toDate options:0];
    
    return dayComponents;
}
-(void)setTheLocalAreaCode
{
    //    NSLocale *locale = [NSLocale currentLocale];
    //
    //    [NSDictionary dictionaryWithObjectsAndKeys:@"972", @"IL",
    //     @"93", @"AF", @"355", @"AL", @"213", @"DZ", @"1", @"AS",
    //     @"376", @"AD", @"244", @"AO", @"1", @"AI", @"1", @"AG",
    //     @"54", @"AR", @"374", @"AM", @"297", @"AW", @"61", @"AU",
    //     @"43", @"AT", @"994", @"AZ", @"1", @"BS", @"973", @"BH",
    //     @"880", @"BD", @"1", @"BB", @"375", @"BY", @"32", @"BE",
    //     @"501", @"BZ", @"229", @"BJ", @"1", @"BM", @"975", @"BT",
    //     @"387", @"BA", @"267", @"BW", @"55", @"BR", @"246", @"IO",
    //     @"359", @"BG", @"226", @"BF", @"257", @"BI", @"855", @"KH",
    //     @"237", @"CM", @"1", @"CA", @"238", @"CV", @"345", @"KY",
    //     @"236", @"CF", @"235", @"TD", @"56", @"CL", @"86", @"CN",
    //     @"61", @"CX", @"57", @"CO", @"269", @"KM", @"242", @"CG",
    //     @"682", @"CK", @"506", @"CR", @"385", @"HR", @"53", @"CU",
    //     @"537", @"CY", @"420", @"CZ", @"45", @"DK", @"253", @"DJ",
    //     @"1", @"DM", @"1", @"DO", @"593", @"EC", @"20", @"EG",
    //     @"503", @"SV", @"240", @"GQ", @"291", @"ER", @"372", @"EE",
    //     @"251", @"ET", @"298", @"FO", @"679", @"FJ", @"358", @"FI",
    //     @"33", @"FR", @"594", @"GF", @"689", @"PF", @"241", @"GA",
    //     @"220", @"GM", @"995", @"GE", @"49", @"DE", @"233", @"GH",
    //     @"350", @"GI", @"30", @"GR", @"299", @"GL", @"1", @"GD",
    //     @"590", @"GP", @"1", @"GU", @"502", @"GT", @"224", @"GN",
    //     @"245", @"GW", @"595", @"GY", @"509", @"HT", @"504", @"HN",
    //     @"36", @"HU", @"354", @"IS", @"91", @"IN", @"62", @"ID",
    //     @"964", @"IQ", @"353", @"IE", @"972", @"IL", @"39", @"IT",
    //     @"1", @"JM", @"81", @"JP", @"962", @"JO", @"77", @"KZ",
    //     @"254", @"KE", @"686", @"KI", @"965", @"KW", @"996", @"KG",
    //     @"371", @"LV", @"961", @"LB", @"266", @"LS", @"231", @"LR",
    //     @"423", @"LI", @"370", @"LT", @"352", @"LU", @"261", @"MG",
    //     @"265", @"MW", @"60", @"MY", @"960", @"MV", @"223", @"ML",
    //     @"356", @"MT", @"692", @"MH", @"596", @"MQ", @"222", @"MR",
    //     @"230", @"MU", @"262", @"YT", @"52", @"MX", @"377", @"MC",
    //     @"976", @"MN", @"382", @"ME", @"1", @"MS", @"212", @"MA",
    //     @"95", @"MM", @"264", @"NA", @"674", @"NR", @"977", @"NP",
    //     @"31", @"NL", @"599", @"AN", @"687", @"NC", @"64", @"NZ",
    //     @"505", @"NI", @"227", @"NE", @"234", @"NG", @"683", @"NU",
    //     @"672", @"NF", @"1", @"MP", @"47", @"NO", @"968", @"OM",
    //     @"92", @"PK", @"680", @"PW", @"507", @"PA", @"675", @"PG",
    //     @"595", @"PY", @"51", @"PE", @"63", @"PH", @"48", @"PL",
    //     @"351", @"PT", @"1", @"PR", @"974", @"QA", @"40", @"RO",
    //     @"250", @"RW", @"685", @"WS", @"378", @"SM", @"966", @"SA",
    //     @"221", @"SN", @"381", @"RS", @"248", @"SC", @"232", @"SL",
    //     @"65", @"SG", @"421", @"SK", @"386", @"SI", @"677", @"SB",
    //     @"27", @"ZA", @"500", @"GS", @"34", @"ES", @"94", @"LK",
    //     @"249", @"SD", @"597", @"SR", @"268", @"SZ", @"46", @"SE",
    //     @"41", @"CH", @"992", @"TJ", @"66", @"TH", @"228", @"TG",
    //     @"690", @"TK", @"676", @"TO", @"1", @"TT", @"216", @"TN",
    //     @"90", @"TR", @"993", @"TM", @"1", @"TC", @"688", @"TV",
    //     @"256", @"UG", @"380", @"UA", @"971", @"AE", @"44", @"GB",
    //     @"1", @"US", @"598", @"UY", @"998", @"UZ", @"678", @"VU",
    //     @"681", @"WF", @"967", @"YE", @"260", @"ZM", @"263", @"ZW",
    //     @"591", @"BO", @"673", @"BN", @"61", @"CC", @"243", @"CD",
    //     @"225", @"CI", @"500", @"FK", @"44", @"GG", @"379", @"VA",
    //     @"852", @"HK", @"98", @"IR", @"44", @"IM", @"44", @"JE",
    //     @"850", @"KP", @"82", @"KR", @"856", @"LA", @"218", @"LY",
    //     @"853", @"MO", @"389", @"MK", @"691", @"FM", @"373", @"MD",
    //     @"258", @"MZ", @"970", @"PS", @"872", @"PN", @"262", @"RE",
    //     @"7", @"RU", @"590", @"BL", @"290", @"SH", @"1", @"KN",
    //     @"1", @"LC", @"590", @"MF", @"508", @"PM", @"1", @"VC",
    //     @"239", @"ST", @"252", @"SO", @"47", @"SJ", @"963", @"SY",
    //     @"886", @"TW", @"255", @"TZ", @"670", @"TL", @"58", @"VE",
    //     @"84", @"VN", @"1", @"VG", @"1", @"VI", nil];
    //
    //    NSString* tt=[locale objectForKey:NSLocaleCountryCode];
    //    NSString* defaultCode=[dictCodes objectForKey:tt];
    //    _areaCodeField.text=[NSString stringWithFormat:@"+%@",defaultCode];
    //
    //    NSString* defaultCountryName=[locale displayNameForKey:NSLocaleCountryCode value:tt];
    //    _defaultCode=defaultCode;
    //    _defaultCountryName=defaultCountryName;
}

#pragma mark - dealloc
- (UIPlaceHolderTextField *) mobileTextField
{
    return mobileText_;
}

- (UIPlaceHolderTextField *) passwordTextField
{
    return passwordText_;
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    
    PP_RELEASE(qqLogin_);
    PP_RELEASE(wbLogin_);
    PP_RELEASE(wxLogin_);
    PP_RELEASE(bgCover_);
    PP_RELEASE(mobileLogin_);
    PP_RELEASE(areaArray_);
    
    PP_RELEASE(closeBtn_);
    
    PP_RELEASE(pwdBtn_);
    PP_RELEASE(passwordText_);
    PP_RELEASE(mobileText_);
    PP_RELEASE(loginBtn_);
    
    if(cTimer_)
    {
        [cTimer_ invalidate];
        PP_RELEASE(cTimer_);
    }
    
    PP_SUPERDEALLOC;
}
@end
