//
//  UIPlaceHolderTextView.m
//  HotelCloud
//
//  Created by Suixing on 12-10-31.
//  Copyright (c) 2012年 Suixing. All rights reserved.
//

#import "UIPlaceHolderTextView.h"

@implementation UIPlaceHolderTextView
@synthesize placeHolderLabel;
@synthesize placeholder;
@synthesize placeholderColor;
@synthesize placeholderFont;
@synthesize placeholderTextAlignment;

- (void)dealloc
{
#ifdef TRACKPAGES
    Class claz = [self class];
    NSString * cname = NSStringFromClass(claz);
    void * p = (void*)self;
    NSString * addr = [NSString stringWithFormat:@"%X",(unsigned int)p];
    [[SystemConfiguration sharedSystemConfiguration] closePageRec:cname  Addr:addr];
#endif
    [[NSNotificationCenter defaultCenter] removeObserver:self];
#if __has_feature(objc_arc)
#else
    PP_RELEASE(placeholderFont);
    [placeHolderLabel release]; placeHolderLabel = nil;
    [placeholderColor release]; placeholderColor = nil;
    [placeholderTextAlignment release];placeholderTextAlignment = nil;
    [placeholder release]; placeholder = nil;
    [super dealloc];
#endif
    
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setPlaceholder:@""];
    [self setPlaceholderColor:[UIColor lightGrayColor]];
    [self setPlaceholderTextAlignment:NSTextAlignmentLeft];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged:) name:UITextViewTextDidChangeNotification object:nil];
}

- (id)initWithFrame:(CGRect)frame
{
    if( (self = [super initWithFrame:frame]) )
    {
#ifdef TRACKPAGES
        Class claz = [self class];
        NSString * cname = NSStringFromClass(claz);
        void * p = (void*)self;
        NSString * addr = [NSString stringWithFormat:@"%X",(unsigned int)p];
        [[SystemConfiguration sharedSystemConfiguration] openPageRec:cname  Addr:addr];
#endif
        [self setPlaceholder:@""];
        [self setPlaceholderColor:[UIColor lightGrayColor]];
        [self setPlaceholderTextAlignment:NSTextAlignmentLeft];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged:) name:UITextViewTextDidChangeNotification object:nil];
    }
    return self;
}

- (void)textChanged:(NSNotification *)notification
{
    if([[self placeholder] length] == 0)
    {
        return;
    }
    
    if([[self text] length] == 0)
    {
        [[self viewWithTag:999] setAlpha:1];
    }
    else
    {
        [[self viewWithTag:999] setAlpha:0];
    }
}

- (void)setText:(NSString *)text {
    [super setText:text];
    [self textChanged:nil];
}

- (void)drawRect:(CGRect)rect
{
    if( [[self placeholder] length] > 0 )
    {
        if ( placeHolderLabel == nil )
        {
            placeHolderLabel = [[UILabel alloc] initWithFrame:CGRectMake(8,8,self.bounds.size.width - 16,0)];
            placeHolderLabel.lineBreakMode = NSLineBreakByCharWrapping;
            placeHolderLabel.numberOfLines = 0;
            placeHolderLabel.font = placeholderFont?placeholderFont: self.font;
            placeHolderLabel.backgroundColor = [UIColor clearColor];
            placeHolderLabel.textColor = self.placeholderColor;
            placeHolderLabel.textAlignment = self.placeholderTextAlignment;
            placeHolderLabel.alpha = 0;
            placeHolderLabel.tag = 999;
            [self addSubview:placeHolderLabel];
        }
        
        placeHolderLabel.text = self.placeholder;
        
        if (placeHolderLabel.textAlignment == NSTextAlignmentLeft) {
            [placeHolderLabel sizeToFit];
        } else {
            UIFont * fontLbl = placeholderFont?placeholderFont:self.font;
            NSDictionary *attribute = @{NSFontAttributeName: fontLbl};
            CGSize sizeLbl = [placeholder boundingRectWithSize:CGSizeMake(placeHolderLabel.frame.size.width, self.frame.size.height) options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
            CGRect frameLbl = placeHolderLabel.frame;
            frameLbl.size.height = sizeLbl.height;
            placeHolderLabel.frame = frameLbl;
        }
        
        [self sendSubviewToBack:placeHolderLabel];
    }
    
    if( [[self text] length] == 0 && [[self placeholder] length] > 0 )
    {
        [[self viewWithTag:999] setAlpha:1];
    }
    
    [super drawRect:rect];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
