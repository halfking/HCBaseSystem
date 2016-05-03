//
//  HMSegmentedControl.m
//  HMSegmentedControlExample
//
//  Created by Hesham Abd-Elmegid on 23/12/12.
//  Copyright (c) 2012 Hesham Abd-Elmegid. All rights reserved.
//

#import "HMSegmentedControl.h"
#import <QuartzCore/QuartzCore.h>
#import <hccoren/base.h>


@interface HMSegmentedControl ()

@property (nonatomic, strong) CALayer *selectedSegmentLayer;
@property (nonatomic, readwrite) CGFloat segmentWidth;

@end

@implementation HMSegmentedControl

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];

    if (self) {
        [self setDefaults];
    }
    
    return self;
}

- (id)initWithSectionTitles:(NSArray *)sectiontitles {
    self = [super initWithFrame:CGRectZero];
    
    if (self) {
        self.sectionTitles = [NSMutableArray arrayWithArray:sectiontitles];
        [self setDefaults];
    }
    
    return self;
}

- (void)setDefaults {
    self.font = [UIFont fontWithName:@"STHeitiSC-Light" size:18.0f];
    //textcolor如何分段设置。
    self.textColor = [UIColor whiteColor];//未选中状态下为白色。
    self.textSelectedColor = [UIColor blueColor];
    //改变高度
    self.IndicatorOffset2Bottom = 0;
    self.opaque = NO;
    
//    self.backgroundColor = [UIColor clearColor];

    self.selectionIndicatorColor = [UIColor colorWithRed:246.0f/255.0f green:60.0f/255.0f blue:61.0f/255.0f alpha:1.0f];
    //self.selectionIndicatorColor = [UIColor redColor];
    self.selectionIndicatorMode = HMSelectionIndicatorDot;

    self.segmentEdgeInset = UIEdgeInsetsMake(0, 5, 0, 5);//??????EdgeInset???????
    self.height = 32.0f;
    self.selectionIndicatorHeight = 10.0f;
//    self.selectionIndicatorMode = HMSelectionIndicatorResizesToStringWidth;
    

    self.selectedSegmentLayer = [CALayer layer];
    if(self.selectionIndicatorMode == HMSelectionIndicatorDot)
    {
        self.selectedSegmentLayer.cornerRadius = 5.0f;
        self.selectedSegmentLayer.masksToBounds = YES;
    }
    self.selectedIndex = 0;
}

#pragma mark - Drawing

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];

    self.opaque = NO;
    if(self.backgroundColor)
    {
        [self.backgroundColor set];
        UIRectFill([self bounds]);
    }
    
    [self.sectionTitles enumerateObjectsUsingBlock:^(id titleString, NSUInteger idx, BOOL *stop) {
        if(idx==_selectedIndex)
        {
            [self.textSelectedColor set];
        }
        else
        {
            [self.textColor set];
        }
        CGFloat stringHeight = [titleString sizeWithAttributes:@{NSFontAttributeName:self.font}].height;
//        CGFloat stringHeight = [titleString sizeWithFont:self.font].height;
//        CGFloat y = ((self.height - self.selectionIndicatorHeight) / 2) + (self.selectionIndicatorHeight - stringHeight / 2);
        //说明是分开的rect。
        CGFloat y;
        if(self.selectionIndicatorMode == HMSelectionIndicatorDot){
             //CGFloat y = ((self.height) / 2) + (self.selectionIndicatorHeight - stringHeight / 2);
           // y = self.height+100;
           // y = ((self.height- self.selectionIndicatorHeight) / 2) ;
            //+ (self.selectionIndicatorHeight - stringHeight / 2);
            y=self.height/2.0f-stringHeight/2.0f;
        }else{
           y = ((self.height - self.selectionIndicatorHeight) / 2) + (self.selectionIndicatorHeight - stringHeight / 2);
        }
        CGRect rect = CGRectMake(self.segmentWidth * idx, y, self.segmentWidth, stringHeight);
        
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 60000
        
        [titleString drawInRect:rect
                       withFont:self.font
                  lineBreakMode:UILineBreakModeClip
                      alignment:UITextAlignmentCenter];
#else
        NSMutableParagraphStyle* paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
        paragraphStyle.lineBreakMode = NSLineBreakByClipping;
        NSDictionary*attribute = @{NSFontAttributeName:self.font,NSParagraphStyleAttributeName:paragraphStyle};
        
//        CGSize size = [titleString boundingRectWithSize:CGSizeMake(300, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil].size;
        
        [titleString drawWithRect:rect options:NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil];
        
//        [titleString drawInRect:rect
//                       withFont:self.font
//                  lineBreakMode:NSLineBreakByClipping
//                      alignment:NSTextAlignmentCenter];
#endif
        
        self.selectedSegmentLayer.frame = [self frameForSelectionIndicator];
        self.selectedSegmentLayer.backgroundColor = self.selectionIndicatorColor.CGColor;
//        if (self.selectionIndicatorMode == HMSelectionIndicatorDot) {
//            self.selectedSegmentLayer = [UIImageView ][UIImage imageNamed:@""]
//        }
        [self.layer addSublayer:self.selectedSegmentLayer];

    }];
}

//获得指示器的frame值。
- (CGRect)frameForSelectionIndicator {
    //取得文字的宽度。
    CGFloat stringWidth = [[self.sectionTitles objectAtIndex:self.selectedIndex] sizeWithAttributes:@{NSFontAttributeName:self.font}].width;
//    CGFloat stringWidth = [[self.sectionTitles objectAtIndex:self.selectedIndex] sizeWithFont:self.font].width;
    CGFloat height = self.frame.size.height;
    if (self.selectionIndicatorMode == HMSelectionIndicatorResizesToStringWidth) {
        CGFloat widthTillEndOfSelectedIndex = (self.segmentWidth * self.selectedIndex) + self.segmentWidth;
        CGFloat widthTillBeforeSelectedIndex = (self.segmentWidth * self.selectedIndex);
        
        CGFloat x = ((widthTillEndOfSelectedIndex - widthTillBeforeSelectedIndex) / 2) + (widthTillBeforeSelectedIndex - stringWidth / 2);
        return CGRectMake(x, self.IndicatorOffset2Bottom, stringWidth, self.selectionIndicatorHeight);
    } else if(self.selectionIndicatorMode == HMSelectionIndicatorFillsSegment) {
        return CGRectMake(self.segmentWidth * self.selectedIndex, self.IndicatorOffset2Bottom, self.segmentWidth, self.selectionIndicatorHeight);
    }
    else
    {
//        CGFloat widthTillEndOfSelectedIndex = (self.segmentWidth * self.selectedIndex) + self.segmentWidth;
        CGFloat widthTillBeforeSelectedIndex = (self.segmentWidth * self.selectedIndex);
        
        CGFloat x = widthTillBeforeSelectedIndex + self.segmentWidth/2.0f -5;
        return CGRectMake(x, height + self.IndicatorOffset2Bottom, 10, 10);
    }
}

- (void)updateSegmentsRects {
    // If there's no frame set, calculate the width of the control based on the number of segments and their size
    if (CGRectIsEmpty(self.frame)) {
        self.segmentWidth = 0;
        
        for (NSString *titleString in self.sectionTitles) {
            CGSize size = [titleString sizeWithAttributes:@{NSFontAttributeName:self.font}];
            CGFloat stringWidth = size.width + self.segmentEdgeInset.left + self.segmentEdgeInset.right;
            self.segmentWidth = MAX(stringWidth, self.segmentWidth);
        }
        
        self.bounds = CGRectMake(0, 0, self.segmentWidth * self.sectionTitles.count, self.height);
    } else {
        self.segmentWidth = self.frame.size.width / self.sectionTitles.count;
        self.height = self.frame.size.height;
    }
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    // Control is being removed
    if (newSuperview == nil)
        return;
    
    [self updateSegmentsRects];
}

#pragma mark - Touch


//选中某个标题的时候
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint touchLocation = [touch locationInView:self];
    
    if (CGRectContainsPoint(self.bounds, touchLocation)) {
        NSInteger segment = touchLocation.x / self.segmentWidth;
        
        if (segment != self.selectedIndex) {
            [self setSelectedIndex:segment animated:YES];
        }
    }
}

#pragma mark -

- (void)setSelectedIndex:(NSInteger)index {
    [self setSelectedIndex:index animated:NO];
}

- (void)setSelectedIndex:(NSUInteger)index animated:(BOOL)animated {
    _selectedIndex = index;

    if (animated) {
        // Restore CALayer animations
        self.selectedSegmentLayer.actions = nil;
        
        [CATransaction begin];
        [CATransaction setAnimationDuration:0.15f];
        [CATransaction setCompletionBlock:^{
            if (self.superview)
                [self sendActionsForControlEvents:UIControlEventValueChanged];
            
            [self setNeedsDisplay];
            
            if (self.indexChangeBlock)
                self.indexChangeBlock(index);
        }];
        self.selectedSegmentLayer.frame = [self frameForSelectionIndicator];
        
        [CATransaction commit];
    } else {
        // Disable CALayer animations
        NSMutableDictionary *newActions = [[NSMutableDictionary alloc] initWithObjectsAndKeys:[NSNull null], @"position", [NSNull null], @"bounds", nil];
        self.selectedSegmentLayer.actions = newActions;
        
        self.selectedSegmentLayer.frame = [self frameForSelectionIndicator];
        
        if (self.superview)
            [self sendActionsForControlEvents:UIControlEventValueChanged];
        [self setNeedsDisplay];
        if (self.indexChangeBlock)
            self.indexChangeBlock(index);

    }    
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    
    if (self.sectionTitles)
        [self updateSegmentsRects];
    
    [self setNeedsDisplay];
}

- (void)setBounds:(CGRect)bounds {
    [super setBounds:bounds];
    
    if (self.sectionTitles)
        [self updateSegmentsRects];
    
    [self setNeedsDisplay];
}

@end
