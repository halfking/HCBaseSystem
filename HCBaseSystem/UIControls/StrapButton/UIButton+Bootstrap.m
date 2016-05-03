//
//  UIButton+Bootstrap.m
//  UIButton+Bootstrap
//
//  Created by Oskur on 2013-09-29.
//  Copyright (c) 2013 Oskar Groth. All rights reserved.
//
#import "UIButton+Bootstrap.h"
#import <QuartzCore/QuartzCore.h>
#import <hccoren/base.h>
#import "UIMLabel.h"
#import "UIMLabelEx.h"
#define COLOR_BS_C         UIColorFromRGB(0xff0000)
#define COLOR_BS_D         UIColorFromRGB(0x277bdd)
#define COLOR_BS_J         UIColorFromRGB(0xcccccc)
//#define FONT_BUTTON             [UIFont fontWithName:@"Arial-BoldMT" size:16]
#define FONT_BS_TEXT           @"ArialMT"
#define FONT_BS_BUTTON_NAME        @"Arial"
@implementation UIButton (Bootstrap)

-(void)bootstrapStyle{
    self.layer.borderWidth = 1;
    self.layer.cornerRadius = 4.0;
    self.layer.masksToBounds = YES;
    [self setAdjustsImageWhenHighlighted:NO];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.titleLabel setFont:[UIFont fontWithName:@"FontAwesome" size:self.titleLabel.font.pointSize]];
}

-(void)defaultStyle{
    [self bootstrapStyle];
    [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    self.backgroundColor = [UIColor whiteColor];
    self.layer.borderColor = [[UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1] CGColor];
    [self setBackgroundImage:[self buttonImageFromColor:[UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1]] forState:UIControlStateHighlighted];
}
-(void)grayStyle{
    [self bootstrapStyle];
    [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    self.backgroundColor = [UIColor lightGrayColor];
    self.layer.borderColor = [[UIColor colorWithRed:100/255.0 green:100/255.0 blue:100/255.0 alpha:1] CGColor];
    [self setBackgroundImage:[self buttonImageFromColor:[UIColor colorWithRed:110/255.0 green:110/255.0 blue:110/255.0 alpha:1]] forState:UIControlStateHighlighted];
}
-(void)primaryStyle{
    [self bootstrapStyle];
    self.backgroundColor = [UIColor colorWithRed:66/255.0 green:139/255.0 blue:202/255.0 alpha:1];
    self.layer.borderColor = [[UIColor colorWithRed:53/255.0 green:126/255.0 blue:189/255.0 alpha:1] CGColor];
    [self setBackgroundImage:[self buttonImageFromColor:[UIColor colorWithRed:51/255.0 green:119/255.0 blue:172/255.0 alpha:1]] forState:UIControlStateHighlighted];
}

-(void)successStyle{
    [self bootstrapStyle];
    self.backgroundColor = [UIColor colorWithRed:92/255.0 green:184/255.0 blue:92/255.0 alpha:1];
    self.layer.borderColor = [[UIColor colorWithRed:76/255.0 green:174/255.0 blue:76/255.0 alpha:1] CGColor];
    [self setBackgroundImage:[self buttonImageFromColor:[UIColor colorWithRed:69/255.0 green:164/255.0 blue:84/255.0 alpha:1]] forState:UIControlStateHighlighted];
}
-(void)bookingStyle{
    [self bootstrapStyle];
    self.backgroundColor = [UIColor colorWithRed:87/255.0 green:158/255.0 blue:217/255.0 alpha:1];
    self.layer.borderColor = [[UIColor colorWithRed:80/255.0 green:150/255.0 blue:210/255.0 alpha:1] CGColor];
    [self setBackgroundImage:[self buttonImageFromColor:[UIColor colorWithRed:59/255.0 green:134/255.0 blue:200/255.0 alpha:1]] forState:UIControlStateHighlighted];
}
-(void)darkTransferStyle
{
    [self bootstrapStyle];
    self.backgroundColor = [UIColor colorWithRed:56/255.0f green:56/255.0f blue:56/255.0f alpha:0.8];
    self.layer.borderColor = [[UIColor colorWithRed:50/255.0 green:50/255.0 blue:50/255.0 alpha:1] CGColor];
    [self setBackgroundImage:[self buttonImageFromColor:[UIColor colorWithRed:55/255.0 green:55/255.0 blue:55/255.0 alpha:0.8]] forState:UIControlStateHighlighted];
}
-(void)barButtonStyle
{
    [self setAdjustsImageWhenHighlighted:NO];
    //    [self bootstrapStyle];
    //    self.backgroundColor = [UIColor colorWithRed:200/255.0f green:200/255.0f blue:200/255.0f alpha:0.2];
    //    self.layer.borderColor = [[UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:0.2] CGColor];
    //    [self setBackgroundImage:[self buttonImageFromColor:[UIColor colorWithRed:195/255.0 green:195/255.0 blue:195/255.0 alpha:0.2]] forState:UIControlStateHighlighted];
}
-(void)cancelStyle
{
    [self bootstrapStyle];
    self.backgroundColor = [UIColor colorWithRed:87/255.0 green:158/255.0 blue:217/255.0 alpha:1];
    self.layer.borderColor = [[UIColor colorWithRed:80/255.0 green:150/255.0 blue:210/255.0 alpha:1] CGColor];
    [self setBackgroundImage:[self buttonImageFromColor:[UIColor colorWithRed:59/255.0 green:134/255.0 blue:200/255.0 alpha:1]] forState:UIControlStateHighlighted];
    
}
-(void)infoStyle{
    [self bootstrapStyle];
    self.backgroundColor = [UIColor colorWithRed:91/255.0 green:192/255.0 blue:222/255.0 alpha:1];
    self.layer.borderColor = [[UIColor colorWithRed:70/255.0 green:184/255.0 blue:218/255.0 alpha:1] CGColor];
    [self setBackgroundImage:[self buttonImageFromColor:[UIColor colorWithRed:57/255.0 green:180/255.0 blue:211/255.0 alpha:1]] forState:UIControlStateHighlighted];
}

-(void)warningStyle{
    [self bootstrapStyle];
    self.backgroundColor = [UIColor colorWithRed:240/255.0 green:173/255.0 blue:78/255.0 alpha:1];
    self.layer.borderColor = [[UIColor colorWithRed:238/255.0 green:162/255.0 blue:54/255.0 alpha:1] CGColor];
    [self setBackgroundImage:[self buttonImageFromColor:[UIColor colorWithRed:237/255.0 green:155/255.0 blue:67/255.0 alpha:1]] forState:UIControlStateHighlighted];
}

-(void)dangerStyle{
    [self bootstrapStyle];
    self.backgroundColor = [UIColor colorWithRed:217/255.0 green:83/255.0 blue:79/255.0 alpha:1];
    self.layer.borderColor = [[UIColor colorWithRed:212/255.0 green:63/255.0 blue:58/255.0 alpha:1] CGColor];
    [self setBackgroundImage:[self buttonImageFromColor:[UIColor colorWithRed:210/255.0 green:48/255.0 blue:51/255.0 alpha:1]] forState:UIControlStateHighlighted];
}
-(void)infoStyleNoBG{
    [self bootstrapStyle];
    self.backgroundColor = [UIColor clearColor];//[UIColor colorWithRed:91/255.0 green:192/255.0 blue:222/255.0 alpha:1];
    self.layer.borderColor = [[UIColor colorWithRed:70/255.0 green:184/255.0 blue:218/255.0 alpha:1] CGColor];
    [self setBackgroundImage:[self buttonImageFromColor:[UIColor colorWithRed:57/255.0 green:180/255.0 blue:211/255.0 alpha:0.6]] forState:UIControlStateHighlighted];
}
-(void)OKFilterStyle{
    [self bootstrapStyle];
    self.backgroundColor = COLOR_BS_C;
    self.layer.borderColor = [COLOR_BS_D CGColor];
    [self setBackgroundImage:[self buttonImageFromColor:COLOR_BS_C] forState:UIControlStateHighlighted];
}
-(void)infoNoBorderNoBG
{
    self.backgroundColor = [UIColor clearColor];//[UIColor colorWithRed:91/255.0 green:192/255.0 blue:222/255.0 alpha:1];
    //    self.layer.borderColor = [[UIColor colorWithRed:70/255.0 green:184/255.0 blue:218/255.0 alpha:1] CGColor];
    [self setBackgroundImage:[self buttonImageFromColor:COLOR_BS_J] forState:UIControlStateHighlighted];
    
}
- (void)changeBorderColor:(UIColor*)color
{
    self.layer.borderColor = [color CGColor];
}
-(void)defaultStyleWithColorN:(UIColor *)color bgColor:(UIColor *)bgColor
{
    [self bootstrapStyle];
    
    self.backgroundColor = [UIColor clearColor];
    if(color)
    {
        self.backgroundColor = color;
        self.layer.borderColor = [color CGColor];
        self.layer.borderWidth = 0.5;
    }
    else
    {
        self.backgroundColor = [UIColor clearColor];
    }
    if(bgColor)
    {
        [self setBackgroundImage:[self buttonImageFromColor:bgColor] forState:UIControlStateHighlighted];
    }
}
- (void)addAwesomeIcon:(FAIcon)icon beforeTitle:(BOOL)before
{
    NSString *iconString = [NSString stringFromAwesomeIcon:icon];
    self.titleLabel.font = [UIFont fontWithName:@"FontAwesome"
                                           size:self.titleLabel.font.pointSize];
    
    NSString *title = [NSString stringWithFormat:@"%@", iconString];
    
    if(self.titleLabel.text) {
        if(before)
            title = [title stringByAppendingFormat:@" %@", self.titleLabel.text];
        else
            title = [NSString stringWithFormat:@"%@  %@", self.titleLabel.text, iconString];
    }
    
    [self setTitle:title forState:UIControlStateNormal];
}
- (void)addImageIcon:(UIImage *)image beforeTitle:(BOOL)before
{
    [self addImageIcon:image fontSize:18 beforeTitle:before];
}
- (void)addImageIcon:(UIImage *)image fontSize:(CGFloat)fontsize beforeTitle:(BOOL)before
{
    [self addImageIconEx:image
                    text:self.titleLabel?self.titleLabel.text:@""
                fontSize:fontsize
               textcolor:self.titleLabel?self.titleLabel.textColor:[UIColor whiteColor]
             beforeTitle:before
                 useHtml:NO];
}
- (void)addImageIcon:(UIImage *)image text:(NSString *)text fontSize:(CGFloat)fontsize
           textcolor:(UIColor*)textcolor beforeTitle:(BOOL)before
{
    [self addImageIconEx:image text:text fontSize:fontsize
               textcolor:textcolor beforeTitle:before useHtml:NO isBar:NO];
}
- (void)addImageIconEx:(UIImage *)image text:(NSString *)text
              fontSize:(CGFloat)fontsize textcolor:(UIColor*)textcolor
           beforeTitle:(BOOL)before
               useHtml:(BOOL)useHtml
{
    [self addImageIconEx:image text:text fontSize:fontsize
               textcolor:textcolor beforeTitle:before useHtml:useHtml isBar:NO];
}
- (void)addImageIconEx:(UIImage *)image text:(NSString *)text
              fontSize:(CGFloat)fontsize textcolor:(UIColor*)textcolor
           beforeTitle:(BOOL)before
               useHtml:(BOOL)useHtml
                 isBar:(BOOL)isBar
{
    if(isBar)
    {
        [self addImageIconEx:image text:text fontName:FONT_BS_TEXT
                    fontSize:fontsize textcolor:textcolor beforeTitle:before
                     useHtml:useHtml isBar:isBar numberOfLines:1];
    }
    else
    {
        [self addImageIconEx:image text:text fontName:FONT_BS_BUTTON_NAME
                    fontSize:fontsize textcolor:textcolor beforeTitle:before
                     useHtml:useHtml isBar:isBar numberOfLines:1];
    }
}
- (void)addImageIconEx:(UIImage *)image text:(NSString *)text fontName:(NSString *)fontName
              fontSize:(CGFloat)fontsize textcolor:(UIColor*)textcolor
           beforeTitle:(BOOL)before
               useHtml:(BOOL)useHtml
                 isBar:(BOOL)isBar
         numberOfLines:(int)numberOfLines
{
    CGFloat left = isBar?0: 5;
    CGFloat top = isBar?0:2;
    CGFloat width  = self.frame.size.width - 2*left;
    CGFloat height = self.frame.size.height - 2* top;
    CGFloat iconWidth = image?image.size.width:0;
    CGFloat iconHeight = image?image.size.height:0;
    UIImageView * imageTemp = nil;
    
    if(image)
    {
        CGFloat scale = [DeviceConfig config].Scale;
        if(isBar && scale>1.1)
        {
            iconHeight /= scale;
            iconWidth /= scale;
        }
        if(!before)
            left = width - iconWidth;
        //add image views;
        CGRect cframe = CGRectMake(left, top + (height - iconHeight)/2.0f,iconWidth, iconHeight);
        UIImageView * imageView = [[UIImageView alloc]initWithFrame:cframe];
        imageView.image = image;
        imageView.backgroundColor = [UIColor clearColor];
        [self addSubview:imageView];
        imageTemp = imageView;
        PP_RELEASE(imageView);
        
        width -= iconWidth +2;
        if(!before)
            left = 5;
        else
            left += iconWidth+2;
    }
    {
        UIMLabelEx * iconLabel = [[UIMLabelEx alloc]initWithFrame:CGRectMake(left, top, width, height)];
        iconLabel.text = text;
        iconLabel.textColor = textcolor;
        iconLabel.fontName = fontName;
        iconLabel.fontSize = fontsize;
        iconLabel.minFontSize = 8;
        iconLabel.backgroundColor = [UIColor clearColor];
        if(image && before)
            iconLabel.textAlignment = NSTextAlignmentLeft;
        else if(image && !before)
        {
            iconLabel.textAlignment = NSTextAlignmentRight;
        }
        else
            iconLabel.textAlignment = NSTextAlignmentCenter;
        
        iconLabel.autoChangeSize = YES;
        iconLabel.horizonCenter = YES;
        iconLabel.alignByCenter = YES;
        iconLabel.useHtml = useHtml;
        iconLabel.lineDiffMin = 2;
        iconLabel.lineHeight = height;
        iconLabel.autoIncNumberOfLines = NO;
        iconLabel.isRowHeightFlexible = YES;
        iconLabel.numberOfLines = numberOfLines;
        if([text hasPrefix:@"Menu List"])
            NSLog(@"begin track");
        CGSize size0 = [iconLabel fillOrginalSize];
        [iconLabel setNeedsDisplay];
        [self addSubview:iconLabel];
        
        self.titleLabel.hidden = YES;
        self.titleLabel.text = @"";
        [self.titleLabel removeFromSuperview];
        
        //center labels
        if(imageTemp)
        {
            CGFloat deltaWidth = (self.frame.size.width - (size0.width + iconWidth + 4)-(5 *2))/2.0f;
            if(deltaWidth!=0)
            {
                if(before)
                {
                    CGFloat innerLeft = deltaWidth +5;
                    //                    if(imageTemp)
                    {
                        CGRect frame1 =imageTemp.frame;
                        //                        if(!before) //让文字与图片有点距离
                        //                            frame1.origin.x += deltaWidth +2;
                        //                        else
                        frame1.origin.x = innerLeft-2;
                        imageTemp.frame = frame1;
                        innerLeft += iconWidth+2;
                    }
                    {
                        CGRect frame2 = iconLabel.frame;
                        frame2.origin.x = innerLeft;
                        
                        iconLabel.frame = frame2;
                    }
                }
                else
                {
                    CGFloat innerLeft = deltaWidth +5;
                    {
                        CGRect frame2 = iconLabel.frame;
                        frame2.origin.x = innerLeft - (iconLabel.frame.size.width -size0.width);//文字前面有空档
                        iconLabel.frame = frame2;
                        innerLeft += size0.width+2;
                    }
                    //                    if(imageTemp)
                    {
                        CGRect frame1 =imageTemp.frame;
                        frame1.origin.x = innerLeft;
                        imageTemp.frame = frame1;
                    }
                    
                }
            }
        }
        PP_RELEASE(iconLabel);
    }
}
- (UIImage *) buttonImageFromColor:(UIColor *)color {
    CGRect rect = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    UIImage * img = nil;
    
//    UIGraphicsBeginImageContextWithOptions(rect.size, NO,0);

    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    if(context)
    {
        CGContextSetFillColorWithColor(context, [color CGColor]);
        CGContextFillRect(context, rect);
        img = UIGraphicsGetImageFromCurrentImageContext();
    }
    else
    {
        NSLog(@"strapButton draw image with color failure,请检查Size(%@)是否正确.",NSStringFromCGRect(rect));
    }
    UIGraphicsEndImageContext();

    return img;
    
}
-(void)setButtonText:(NSString*)text color:(UIColor *)color
{
    UIMLabel * label1 = nil;
    UIMLabelEx * label2 = nil;
    for (UIView * v in self.subviews) {
        if([v isKindOfClass:[UIMLabel class]])
        {
            label1 = (UIMLabel*)v;
            break;
        }
        else if([v isKindOfClass:[UIMLabelEx class]])
        {
            label2 = (UIMLabelEx *)v;
            break;
        }
    }
    if(label2)
    {
        label2.text = text;
        if(color)
        {
            label2.textColor = color;
        }
        [label2 fillOrginalSize];
        [label2 setNeedsDisplay];
    }
    else if(label1)
    {
        label1.text = text;
        if(color)
            label1.textColor = color;
        [label1 autoFillSize];
        [label1 setNeedsDisplay];
    }
}
@end
