//
//  UIButton+Bootstrap.h
//  UIButton+Bootstrap
//
//  Created by Oskar Groth on 2013-09-29.
//  Copyright (c) 2013 Oskar Groth. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSString+FontAwesome.h"

@interface UIButton (Bootstrap)
- (void)addAwesomeIcon:(FAIcon)icon beforeTitle:(BOOL)before;
- (void)addImageIcon:(UIImage *)image beforeTitle:(BOOL)before;
- (void)addImageIcon:(UIImage *)image fontSize:(CGFloat)fontsize beforeTitle:(BOOL)before;
- (void)addImageIcon:(UIImage *)image text:(NSString *)text fontSize:(CGFloat)fontsize textcolor:(UIColor*)textcolor beforeTitle:(BOOL)before;
- (void)addImageIconEx:(UIImage *)image text:(NSString *)text fontSize:(CGFloat)fontsize textcolor:(UIColor*)textcolor beforeTitle:(BOOL)before useHtml:(BOOL)useHtml;
- (void)addImageIconEx:(UIImage *)image text:(NSString *)text
              fontSize:(CGFloat)fontsize textcolor:(UIColor*)textcolor
           beforeTitle:(BOOL)before
               useHtml:(BOOL)useHtml
                 isBar:(BOOL)isBar;
- (void)addImageIconEx:(UIImage *)image text:(NSString *)text fontName:(NSString *)fontName
              fontSize:(CGFloat)fontsize textcolor:(UIColor*)textcolor
           beforeTitle:(BOOL)before
               useHtml:(BOOL)useHtml
                 isBar:(BOOL)isBar
         numberOfLines:(int)numberOfLines;
-(void)bootstrapStyle;
-(void)defaultStyle;
-(void)bookingStyle;
-(void)darkTransferStyle;
-(void)cancelStyle;
-(void)primaryStyle;
-(void)successStyle;
-(void)infoStyle;
-(void)warningStyle;
-(void)dangerStyle;
-(void)grayStyle;
-(void)barButtonStyle;
-(void)OKFilterStyle;

-(void)infoStyleNoBG;
-(void)infoNoBorderNoBG;

- (void)changeBorderColor:(UIColor*)color;
- (void)defaultStyleWithColorN:(UIColor * )color bgColor:(UIColor *)bgColor;

-(void)setButtonText:(NSString*)text color:(UIColor*)color;
@end
