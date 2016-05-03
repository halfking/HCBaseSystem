//
//  SevenSwitch
//
//  Created by Benjamin Vogelzang on 6/10/13.
//  Copyright (c) 2013 Ben Vogelzang. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

#import "SevenSwitch.h"
#import <QuartzCore/QuartzCore.h>

@interface SevenSwitch ()  {
    UIView *background;
    UIView *knob;
    UIView *onImageView;
    UIView *offImageView;
    double startTime;
    BOOL isAnimating;
    CGFloat maxTextWidth;
    BOOL hasSteup_;
}

- (void)showOn:(BOOL)animated;
- (void)showOff:(BOOL)animated;
//- (void)setup;

@end


@implementation SevenSwitch

@synthesize inactiveColor, activeColor, onColor;
@synthesize borderColor, knobColor, shadowColor;
@synthesize onImage, offImage;
@synthesize isRounded;
@synthesize on;
@synthesize knobImage;
@synthesize backgroundImage;
@synthesize onText,offText,textFont,onTextColor,offTextColor;

#pragma mark init Methods
- (void)dealloc
{
    PP_RELEASE(background);
    PP_RELEASE(knob);
    PP_RELEASE(onImageView);
    PP_RELEASE(offImageView);
        PP_RELEASE(inactiveColor);
        PP_RELEASE(activeColor);
        PP_RELEASE(onColor);
    PP_RELEASE(borderColor);
    PP_RELEASE(knobColor);
    PP_RELEASE(shadowColor);
    PP_RELEASE(onImage);
    PP_RELEASE(offImage);
    PP_RELEASE(knobImage);
        PP_RELEASE(backgroundImage);
    PP_RELEASE(onText);
    PP_RELEASE(offText);
    PP_RELEASE(textFont);
    PP_RELEASE(onTextColor);
    PP_RELEASE(offTextColor);
    
    PP_SUPERDEALLOC;
    
}
- (id)init {
    self = [super initWithFrame:CGRectMake(0, 0, 50, 30)];
    if (self) {
        //        [self setup];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        //        [self setup];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    // use the default values if CGRectZero frame is set
    CGRect initialFrame;
    if (CGRectIsEmpty(frame)) {
        initialFrame = CGRectMake(0, 0, 50, 30);
    }
    else {
        initialFrame = frame;
    }
    self = [super initWithFrame:initialFrame];
    if (self) {
        //        [self setup];
    }
    return self;
}


/**
 *	Setup the individual elements of the switch and set default values
 */
- (void)setup {
    if(hasSteup_) return;
    maxTextWidth = 0;
    // default values
    self.isRounded = YES;
        if(!self.inactiveColor)
            self.inactiveColor = [UIColor clearColor];
        if(!self.activeColor)
            self.activeColor = [UIColor colorWithRed:0.89f green:0.89f blue:0.89f alpha:1.00f];
        if(!self.onColor)
            self.onColor = [UIColor colorWithRed:0.30f green:0.85f blue:0.39f alpha:1.00f];
    if(!self.borderColor)
        self.borderColor = [UIColor colorWithRed:0.89f green:0.89f blue:0.91f alpha:1.00f];
    if(!self.knobColor)
        self.knobColor = [UIColor whiteColor];
    if(!self.shadowColor)
        self.shadowColor = [UIColor grayColor];
    
    if(background)
    {
        [background removeFromSuperview];
        PP_RELEASE(background);
    }
    if(knob)
    {
        [knob removeFromSuperview];
        PP_RELEASE(knob);
    }
    if(onImageView)
    {
        [onImageView removeFromSuperview];
        PP_RELEASE(onImageView);
    }
    if(offImageView)
    {
        [offImageView removeFromSuperview];
        PP_RELEASE(offImageView);
    }
    
    
    // background
    background = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    background.backgroundColor = self.borderColor;//[UIColor clearColor];
    background.userInteractionEnabled = NO;
    
    //    if(backgroundImage){
    //        CGRect frame = background.frame;
    //        frame.origin.x = 0;
    //        frame.origin.y = 0;
    //        UIImageView * imageView = [[UIImageView alloc]initWithFrame:frame];
    //        imageView.image = backgroundImage;
    //        imageView.backgroundColor = [UIColor clearColor];
    //        [background addSubview:imageView];
    //        PP_RELEASE(imageView);
    //    }
    //    else
    //    {
    background.layer.cornerRadius = self.frame.size.height * 0.5;
    background.layer.borderColor = self.borderColor.CGColor;
    background.layer.borderWidth = 1.0;
    //    }
    [self addSubview:background];
    
    // knob
    if(knobImage)
    {
        UIImageView * imageview = [[UIImageView alloc] initWithFrame:CGRectMake(1, 1, self.frame.size.height - 2,self.frame.size.height - 2)]; // CGRectMake(1, 1, knobImage.size.width,knobImage.size.height)];
        imageview.image = knobImage;
        knob = imageview;
    }
    else
    {
        knob = [[UIView alloc] initWithFrame:CGRectMake(1, 1,
                                                        maxTextWidth>0?maxTextWidth:self.frame.size.height - 2,
                                                        self.frame.size.height - 2)];
        knob.layer.cornerRadius = (self.frame.size.height * 0.5) - 1;
        knob.layer.shadowColor = self.shadowColor.CGColor;
        knob.layer.shadowRadius = 2.0;
        //    knob.layer.shadowRadius = 5.0;
        knob.layer.shadowOpacity = 0.5;
        knob.layer.shadowOffset = CGSizeMake(0, 3);
        knob.layer.masksToBounds = NO;
    }
    knob.backgroundColor = self.knobColor;
    
    knob.userInteractionEnabled = NO;
    [self addSubview:knob];
    
    // images
    if(!onText||!offText)
    {
        onImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width - self.frame.size.height, self.frame.size.height)];
        onImageView.alpha = 0;
        onImageView.contentMode = UIViewContentModeCenter;
        [self addSubview:onImageView];
        
        offImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.height, 0, self.frame.size.width - self.frame.size.height, self.frame.size.height)];
        offImageView.alpha = 1.0;
        offImageView.contentMode = UIViewContentModeCenter;
        [self addSubview:offImageView];
        
        [self bringSubviewToFront:knob];
    }
    else
    {
        if(!self.textFont) textFont = PP_RETAIN([UIFont systemFontOfSize:11]);
        
        NSDictionary *attributes = @{NSFontAttributeName: textFont};
        CGSize size = [ onText sizeWithAttributes:attributes];
        maxTextWidth = size.width;
        
        CGFloat leftDiff = (self.frame.size.width /2.0f - maxTextWidth - 5)/2.0f;
        CGFloat top = (self.frame.size.height - size.height)/2.0f;
        UILabel * onLabel = [[UILabel alloc]initWithFrame:CGRectMake(leftDiff, top , size.width, size.height)];
        onLabel.text = onText;
        onLabel.font = textFont;
        onLabel.textAlignment = NSTextAlignmentLeft;
        onLabel.textColor = onTextColor;
        onLabel.backgroundColor = [UIColor clearColor];
        onImageView = onLabel;
        [self addSubview:onImageView];
        
        size = [ offText sizeWithAttributes:attributes];
        if(size.width > maxTextWidth)
        {
            maxTextWidth = size.width;
        }
        UILabel * offLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width - size.width -leftDiff, top , size.width, size.height)];
        offLabel.text = offText;
        offLabel.font = textFont;
        offLabel.textColor = offTextColor;
        offLabel.textAlignment = NSTextAlignmentRight;
        offLabel.backgroundColor = [UIColor clearColor];
        offImageView = offLabel;
        [self addSubview:offImageView];
    }
    
    self.on = NO;
    
    isAnimating = NO;
    hasSteup_ = YES;
}


#pragma mark Touch Tracking
- (CGFloat) getKnobWidth
{
    if(onText && offText)
    {
        maxTextWidth = self.bounds.size.width/2.0f - 5;
    }
    CGFloat activeKnobWidth = knobImage?knob.frame.size.width:(maxTextWidth>self.bounds.size.height -2?maxTextWidth:self.bounds.size.height - 2);
    return activeKnobWidth;
}
- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    [super beginTrackingWithTouch:touch withEvent:event];
    
    // start timer to detect tap later in endTrackingWithTouch:withEvent:
    startTime = [[NSDate date] timeIntervalSince1970];
    
    // make the knob larger and animate to the correct color
    
    CGFloat activeKnobWidth = [self getKnobWidth];// + 5;
    isAnimating = YES;
    [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseOut|UIViewAnimationOptionBeginFromCurrentState animations:^{
        if (self.on) {
            knob.frame = CGRectMake(self.bounds.size.width - (activeKnobWidth + 1), knob.frame.origin.y, activeKnobWidth, knob.frame.size.height);
        }
        else {
            knob.frame = CGRectMake(knob.frame.origin.x, knob.frame.origin.y, activeKnobWidth, knob.frame.size.height);
        }
    } completion:^(BOOL finished) {
        isAnimating = NO;
    }];
    
    return YES;
}

- (BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    [super continueTrackingWithTouch:touch withEvent:event];
    
    // Get touch location
    CGPoint lastPoint = [touch locationInView:self];
    
    // update the switch to the correct visuals depending on if
    // they moved their touch to the right or left side of the switch
    if (lastPoint.x > self.bounds.size.width * 0.5)
        [self showOn:YES];
    else
        [self showOff:YES];
    
    return YES;
}

- (void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    [super endTrackingWithTouch:touch withEvent:event];
    
    // capture time to see if this was a tap action
    double endTime = [[NSDate date] timeIntervalSince1970];
    double difference = endTime - startTime;
    BOOL previousValue = self.on;
    
    // determine if the user tapped the switch or has held it for longer
    if (difference <= 0.2) {
        CGFloat normalKnobWidth = [self getKnobWidth];
        knob.frame = CGRectMake(knob.frame.origin.x, knob.frame.origin.y, normalKnobWidth, knob.frame.size.height);
        [self setOn:!self.on animated:YES];
    }
    else {
        // Get touch location
        CGPoint lastPoint = [touch locationInView:self];
        
        // update the switch to the correct value depending on if
        // their touch finished on the right or left side of the switch
        if (lastPoint.x > self.bounds.size.width * 0.5)
            [self setOn:YES animated:YES];
        else
            [self setOn:NO animated:YES];
    }
    
    if (previousValue != self.on)
        [self sendActionsForControlEvents:UIControlEventValueChanged];
}

- (void)cancelTrackingWithEvent:(UIEvent *)event {
    [super cancelTrackingWithEvent:event];
    
    // just animate back to the original value
    if (self.on)
        [self showOn:YES];
    else
        [self showOff:YES];
}


- (void)layoutSubviews {
    [super layoutSubviews];
    if(!hasSteup_)
    {
        [self setup];
    }
    if (!isAnimating) {
        CGRect frame = self.frame;
        
        // background
        background.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        background.layer.cornerRadius = self.isRounded ? frame.size.height * 0.5 : 2;
        
        // images
        if(!onText && !offText)
        {
            if(onImageView)
                onImageView.frame = CGRectMake(0, 0, frame.size.width - frame.size.height, frame.size.height);
            if(offImageView)
                offImageView.frame = CGRectMake(frame.size.height, 0, frame.size.width - frame.size.height, frame.size.height);
        }
        // knob
        [self setKnoFrameWithOnOff:self.on];
        knob.layer.cornerRadius = self.isRounded ? (frame.size.height * 0.5) - 1 : 2;
        
    }
}


#pragma mark Setters

/*
 *	Sets the background color when the switch is off.
 *  Defaults to clear color.
 */
- (void)setInactiveColor:(UIColor *)color {
    PP_RELEASE(inactiveColor);
    inactiveColor = PP_RETAIN(color);
    if (!self.on && !self.isTracking && background)
        background.backgroundColor = color;
}

/*
 *	Sets the background color that shows when the switch is on.
 *  Defaults to green.
 */
- (void)setOnColor:(UIColor *)color {
    PP_RELEASE(onColor);
    onColor = PP_RETAIN(color);
    if (self.on && !self.isTracking && background) {
        background.backgroundColor = color;
        background.layer.borderColor = color.CGColor;
    }
}

/*
 *	Sets the border color that shows when the switch is off. Defaults to light gray.
 */
- (void)setBorderColor:(UIColor *)color {
    PP_RELEASE(borderColor);
    borderColor = PP_RETAIN(color);
    //    if (!self.on && background)
    background.layer.borderColor = color.CGColor;
    background.backgroundColor = color;
}

/*
 *	Sets the knob color. Defaults to white.
 */
- (void)setKnobColor:(UIColor *)color {
    PP_RELEASE(knobColor);
    knobColor = PP_RETAIN(color);
    if(knob)
        knob.backgroundColor = color;
}

/*
 *	Sets the shadow color of the knob. Defaults to gray.
 */
- (void)setShadowColor:(UIColor *)color {
    PP_RELEASE(shadowColor);
    shadowColor = PP_RETAIN(color);
    knob.layer.shadowColor = color.CGColor;
}
- (void)setBackgroundImage:(UIImage *)image
{
    PP_RELEASE(backgroundImage);
    backgroundImage = PP_RETAIN(image);
    if(image && background)
    {
        for (UIView * view in background.subviews) {
            [view removeFromSuperview];
        }
        CGRect frame = background.frame;
        frame.origin.x = 0;
        frame.origin.y = 0;
        UIImageView * imageView = [[UIImageView alloc]initWithFrame:frame];
        imageView.image = backgroundImage;
        [background addSubview:imageView];
        PP_RELEASE(imageView);
    }
}
- (void)setKnobImage:(UIImage *)image
{
    PP_RELEASE(knobImage);
    knobImage = PP_RETAIN(image);
    if(image && knob){
        if(knob)
        {
            [knob removeFromSuperview];
            PP_RELEASE(knob);
        }
        
        UIImageView * imageview = [[UIImageView alloc] initWithFrame:CGRectMake(1, 1, self.frame.size.height - 2,self.frame.size.height - 2)]; // CGRectMake(1, 1, image.size.width,image.size.height)];
        imageview.image = knobImage;
        knob = imageview;
        
        knob.backgroundColor = self.knobColor;
        knob.userInteractionEnabled = NO;
        [self addSubview:knob];
        //PP_RELEASE(imageview);
    }
}
/*
 *	Sets the image that shows when the switch is on.
 *  The image is centered in the area not covered by the knob.
 *  Make sure to size your images appropriately.
 */
- (void)setOnImage:(UIImage *)image {
    PP_RELEASE(onImage);
    onImage = PP_RETAIN(image);
    if([onImageView isKindOfClass:[UIImageView class]])
        ((UIImageView*)onImageView).image = image;
    else
    {
        [onImageView removeFromSuperview];
        PP_RELEASE(onImageView);
        onImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width - self.frame.size.height, self.frame.size.height)];
        onImageView.alpha = 0;
        ((UIImageView*)onImageView).image = image;
        onImageView.contentMode = UIViewContentModeCenter;
        [self addSubview:onImageView];
    }
}

/*
 *	Sets the image that shows when the switch is off.
 *  The image is centered in the area not covered by the knob.
 *  Make sure to size your images appropriately.
 */
- (void)setOffImage:(UIImage *)image {
    PP_RELEASE(offImage);
    offImage =PP_RETAIN(image);
    if([offImageView isKindOfClass:[UIImageView class]])
        ((UIImageView*)offImageView).image = image;
    else
    {
        [offImageView removeFromSuperview];
        PP_RELEASE(offImageView);
        offImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.height, 0, self.frame.size.width - self.frame.size.height, self.frame.size.height)];
        offImageView.alpha = 1.0;
        ((UIImageView*)offImageView).image = image;
        offImageView.contentMode = UIViewContentModeCenter;
        [self addSubview:offImageView];
    }
}


/*
 *	Sets whether or not the switch edges are rounded.
 *  Set to NO to get a stylish square switch.
 *  Defaults to YES.
 */
- (void)setIsRounded:(BOOL)rounded {
    isRounded = rounded;
    
    if (rounded) {
        background.layer.cornerRadius = self.frame.size.height * 0.5;
        knob.layer.cornerRadius = (self.frame.size.height * 0.5) - 1;
    }
    else {
        background.layer.cornerRadius = 2;
        knob.layer.cornerRadius = 2;
    }
}


/*
 * Set (without animation) whether the switch is on or off
 */
- (void)setOn:(BOOL)isOn {
    [self setOn:isOn animated:NO];
}


/*
 * Set the state of the switch to on or off, optionally animating the transition.
 */
- (void)setOn:(BOOL)isOn animated:(BOOL)animated {
    on = isOn;
    
    if (isOn) {
        [self showOn:animated];
    }
    else {
        [self showOff:animated];
    }
}


#pragma mark Getters

/*
 *	Detects whether the switch is on or off
 *
 *	@return	BOOL YES if switch is on. NO if switch is off
 */
- (BOOL)isOn {
    return self.on;
}


#pragma mark State Changes


/*
 * update the looks of the switch to be in the on position
 * optionally make it animated
 */
- (void)setKnoFrameWithOnOff:(BOOL)isON
{
    CGFloat normalKnobWidth = [self getKnobWidth];
    CGFloat activeKnobWidth = [self getKnobWidth];// + 5;
    //文字方式与图片方式有不同
    if(onText && offText && !knobImage)
    {
        isON = !isON;
    }
    if(isON)
    {
        if (self.tracking)
            knob.frame = CGRectMake(self.bounds.size.width - (activeKnobWidth + 1), knob.frame.origin.y, activeKnobWidth, knob.frame.size.height);
        else
            knob.frame = CGRectMake(self.bounds.size.width - (normalKnobWidth + 1), knob.frame.origin.y, normalKnobWidth, knob.frame.size.height);
    }
    else
    {
        if (self.tracking) {
            knob.frame = CGRectMake(1, knob.frame.origin.y, activeKnobWidth, knob.frame.size.height);
        }
        else {
            knob.frame = CGRectMake(1, knob.frame.origin.y, normalKnobWidth, knob.frame.size.height);
        }
    }
//    NSLog(@"knob frame:%@",NSStringFromCGRect(knob.frame));
}
- (void)setOnOffImageText:(BOOL)isON
{
    if(isON)
    {
        if(onImageView && offImageView)
        {
            if([onImageView isKindOfClass:[UILabel class]])
            {
                [((UILabel *)onImageView)setTextColor:self.onTextColor];
                [((UILabel *)offImageView)setTextColor:self.offTextColor];
            }
            else
            {
                onImageView.alpha = 1.0;
                offImageView.alpha = 0;
            }
        }
        
        if(!onText||!offText)
        {
            background.backgroundColor = self.onColor;
            background.layer.borderColor = self.onColor.CGColor;
        }
    }
    else
    {
        if(onImageView && offImageView)
        {
            if([onImageView isKindOfClass:[UILabel class]])
            {
                [((UILabel *)onImageView)setTextColor:self.offTextColor];
                [((UILabel *)offImageView)setTextColor:self.onTextColor];
            }
            else
            {
                onImageView.alpha = 0;
                offImageView.alpha =1.0;
            }
        }
        
        if(!onText||!offText)
        {
            background.backgroundColor = self.inactiveColor;
            background.layer.borderColor = self.inactiveColor.CGColor;
        }
    }
}
- (void)showOn:(BOOL)animated {
    
    if (animated) {
        isAnimating = YES;
        [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseOut|UIViewAnimationOptionBeginFromCurrentState animations:^{
            [self setKnoFrameWithOnOff:YES];
            [self setOnOffImageText:YES];
        } completion:^(BOOL finished) {
            isAnimating = NO;
        }];
    }
    else {
        [self setKnoFrameWithOnOff:YES];
        [self setOnOffImageText:YES];
    }
}


/*
 * update the looks of the switch to be in the off position
 * optionally make it animated
 */
- (void)showOff:(BOOL)animated {
    if (animated) {
        isAnimating = YES;
        [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseOut|UIViewAnimationOptionBeginFromCurrentState animations:^{
            [self setKnoFrameWithOnOff:NO];
            [self setOnOffImageText:NO];
            
        } completion:^(BOOL finished) {
            isAnimating = NO;
        }];
    }
    else {
        [self setKnoFrameWithOnOff:NO];
        [self setOnOffImageText:NO];
    }
}

@end
