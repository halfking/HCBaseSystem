//
//  SNAlterView.h
//  maiba
//
//  Created by HUANGXUTAO on 16/1/14.
//  Copyright © 2016年 seenvoice.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <hccoren/base.h>
@class SNAlertView;
@protocol SNAlertViewDelegate <NSObject>
- (void)snAlertView:(nullable SNAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;
//- (void)alertView:(SNAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
@end

@interface SNAlertView : UIView
@property (nonatomic,assign) NSInteger cancelButtonIndex;

- (nullable instancetype)initWithTitle:(nullable NSAttributedString *)title
                      message:(nonnull NSAttributedString *)message
                     delegate:(nullable id <SNAlertViewDelegate>)delegate
                       titles:(nonnull NSArray *)titles;

- (nullable instancetype)initWithTitle:(nullable NSString *)title
                      message:(nonnull NSString *)message
                         delegate:(nullable id<SNAlertViewDelegate>)delegate
                cancelButtonTitle:(nonnull NSString *)cancelButtonTitle
                otherButtonTitles:(nullable NSString *)otherButtonTitles, ...;
- (void) show;
- (void) show:(nonnull UIView *)superView;
@end
