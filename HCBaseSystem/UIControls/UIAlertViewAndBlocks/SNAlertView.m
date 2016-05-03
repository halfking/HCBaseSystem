//
//  SNAlterView.m
//  maiba
//
//  Created by HUANGXUTAO on 16/1/14.
//  Copyright © 2016年 seenvoice.com. All rights reserved.
//

#import "SNAlertView.h"
#import <hccoren/UIView+extension.h>

//颜色的快速输入
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


#define ALLineColorOfGray UIColorFromRGB(0xa7afbb)
#define ALLineColorOfBlue UIColorFromRGB(0x83b3f6)
#define ALTextColorOfButton UIColorFromRGB(0x007aff)
#define ALTextColorOfTitle UIColorFromRGB(0x000000)
#define ALTextColorOfMessage UIColorFromRGB(0x000000)
#define ALFontOfTitle [UIFont boldSystemFontOfSize:15]
#define ALFontOfMessage [UIFont systemFontOfSize:13]
#define ALFontOfNormalButton [UIFont systemFontOfSize:15]
#define ALFontOfCancelButton [UIFont boldSystemFontOfSize:15]

#define ALBtnBGColorOfHL UIColorFromRGB(0xc5ccd4)

@interface SNAlertView()

@property (nonatomic, weak) id delegate;
@property (nonatomic, strong) NSAttributedString *title;
@property (nonatomic, strong) NSAttributedString *message;
@property (nonatomic, strong) NSArray *buttons;
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, assign) CGRect outFrame;
@property (nonatomic, strong) UIView * maskView;
@end

@implementation SNAlertView
- (nullable instancetype)initWithTitle:(nullable NSString *)title
                               message:(nonnull NSString *)message
                              delegate:(nullable id<SNAlertViewDelegate>)delegate
                     cancelButtonTitle:(nonnull NSString *)cancelButtonTitle
                     otherButtonTitles:(nullable NSString *)otherButtonTitles, ...;
{
    //    NSDictionary *attributes = @{NSForegroundColorAttributeName:[UIColor blueColor]};
    //
    //    NSMutableAttributedString *message = [[NSMutableAttributedString alloc] initWithString:@"这是 文字高亮，模仿系统提示框的样式，但是可以定义文字格式"];
    //    [message setAttributes:attributes
    //                     range:NSMakeRange(3, 4)];
    if(self = [super init])
    {
        
        if(title)
            self.title = [[NSAttributedString alloc] initWithString:title];
        if(message)
            self.message =[[NSAttributedString alloc] initWithString:message];
        self.delegate = delegate;
        NSMutableArray * array = [NSMutableArray new];
        if(cancelButtonTitle)
        {
            [array addObject:cancelButtonTitle];
            self.cancelButtonIndex = 0;
        }
        {
            if(otherButtonTitles){
                va_list varList;
                id arg;
                
                [array addObject:otherButtonTitles];
                va_start(varList,otherButtonTitles);
                while((arg = va_arg(varList,id))){
                    [array addObject:arg];
                }
                va_end(varList);
            }
        }
        self.buttons = array;
        PP_RELEASE(array);
        
        [self initSetup];
    }
    return self;
}
- (nullable instancetype)initWithTitle:(nullable NSAttributedString *)title
                               message:(nonnull NSAttributedString *)message
                              delegate:(nullable id<SNAlertViewDelegate>)delegate
                                titles:(nonnull NSArray *)titles{
    self = [super init];
    if (self) {
        self.title = title;
        self.message = message;
        self.delegate = delegate;
        self.buttons = titles;
        
        [self initSetup];
    }
    return self;
}

- (void)initSetup{
    [self setupUI];
    
    CGRect frame = self.frame;
    
    frame.origin.y = [DeviceConfig config].Height;
}

- (void)setupUI{
    //add title
    CGRect frame = self.frame;
    frame.size.width= 270;
    self.frame = frame;
    
    
    CGFloat verticalSpace = 20;
    CGFloat horizentalSpace = 20;
    
    
    CGFloat height = 0;
    
    //self
    self.layer.cornerRadius = 5;
    self.layer.masksToBounds = YES;
    self.backgroundColor = [UIColor clearColor];
    self.bgView = [[UIView alloc] initWithFrame:self.bounds];
    self.bgView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.98f];
    _bgView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    [self addSubview:_bgView];
    
    if (_title.length > 0) {
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.numberOfLines = 0;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.textColor = ALTextColorOfTitle;
        titleLabel.font = ALFontOfTitle;
        titleLabel.attributedText = _title; //注意，要放在label设置font，textColor等属性之后。
        titleLabel.backgroundColor = [UIColor clearColor];
        //#warning sw 可以兼容ios8
        //        CGSize titleSize = [_title sizeWithFont:titleLabel.font
        //                                       forWidth:self.width - 2*horizentalSpace
        //                                  lineBreakMode:NSLineBreakByWordWrapping];
        CGSize titleSize = CGSizeZero;
//        if([DeviceConfig config].SysVersion>=7)
//        {
            titleSize =  [_title.string boundingRectWithSize:CGSizeMake(self.frame.size.width - 2*horizentalSpace, 10000)
                                                     options:NSStringDrawingUsesLineFragmentOrigin
                                                  attributes:@{NSFontAttributeName:titleLabel.font}
                                                     context:nil].size;
//        }
//        else
//        {
//            titleSize = [_title.string sizeWithFont:titleLabel.font
//                                  constrainedToSize:CGSizeMake(self.frame.size.width - 2*horizentalSpace, 10000)];
//        }
        //        CGSize titleSize = [_title.string sizeWithAttributes:@{NSFontAttributeName:titleLabel.font}];
        
        CGRect titleFrame = CGRectMake((self.frame.size.width - titleSize.width)/2.0f, verticalSpace, titleSize.width + 2, titleSize.height +2);
        titleLabel.frame = titleFrame;
        //        titleLabel.size = titleSize;
        //        titleLabel.centerX = self.width/2;
        //        titleLabel.top = verticalSpace;
        [self addSubview:titleLabel];
        height = titleFrame.origin.y + titleFrame.size.height;
        //        height = titleLabel.bottom;
    }
    
    if (_message.length > 0) {
        UILabel *messageLabel = [[UILabel alloc] init];
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = NSTextAlignmentCenter;
        messageLabel.textColor = ALTextColorOfMessage;
        messageLabel.font = ALFontOfMessage;
        messageLabel.attributedText = _message;//注意，要放在label设置font，textColor等属性之后。
        messageLabel.backgroundColor = [UIColor clearColor];
//#warning sw 可以兼容ios8
        //        CGSize messageSize = [_message sizeWithFont:messageLabel.font
        //                                       forWidth:self.width - 2*horizentalSpace
        //                                  lineBreakMode:NSLineBreakByWordWrapping];
        
        //         CGSize messageSize = [_message.string sizeWithAttributes:@{NSFontAttributeName:titleLabel.font}];
        CGSize messageSize = CGSizeZero;
//        if([DeviceConfig config].SysVersion>=7)
//        {
            messageSize =  [_message.string boundingRectWithSize:CGSizeMake(self.frame.size.width - 2*horizentalSpace, 10000)
                                                     options:NSStringDrawingUsesLineFragmentOrigin
                                                  attributes:@{NSFontAttributeName:messageLabel.font}
                                                     context:nil].size;
//        }
//        else
//        {
//            messageSize = [_message.string sizeWithFont:messageLabel.font
//                                  constrainedToSize:CGSizeMake(self.frame.size.width - 2*horizentalSpace, 10000)];
//        }
//        CGSize messageSize = [_message.string sizeWithFont:messageLabel.font
//                                         constrainedToSize:CGSizeMake(self.frame.size.width - 2*horizentalSpace, 10000)];
//        
        CGFloat mtop = verticalSpace;
        if (fabs(height)>=0.5) {
            mtop = height + 10;
        }
        
        CGRect messageFrame = CGRectMake((self.frame.size.width - messageSize.width)/2.0f, mtop, messageSize.width + 2, messageSize.height +2);
        messageLabel.frame = messageFrame;
        //        messageLabel.size = messageSize;
        //        messageLabel.centerX = self.width/2;
        //        if (FLOAT_IS_ZERO(height)) {
        //            messageLabel.top = verticalSpace;
        //        }else{
        //            messageLabel.top = height + 10;
        //        }
        [self addSubview:messageLabel];
        
        height = messageFrame.origin.y + messageFrame.size.height;
        //        height = messageLabel.bottom;
    }
    //分割线
    if (fabs(height)>=0.5 /* !FLOAT_IS_ZERO(height)*/) {
        UIView *seperator = [[UIView alloc] init];
        
        if ([_buttons count] >= 3) {
            seperator.backgroundColor = ALLineColorOfBlue;
        }else{
            seperator.backgroundColor = ALLineColorOfGray;
        }
        CGRect speratorFrame = CGRectMake(0, height + verticalSpace, self.frame.size.width, 0.5f);
        //        seperator.width = self.width;
        //        seperator.height = 0.5f;
        //        seperator.top = height + verticalSpace;
        seperator.frame = speratorFrame;
        [self addSubview:seperator];
        
        height = speratorFrame.origin.y + speratorFrame.size.height;
        //        height = seperator.bottom;
    }
    [self buildButtons:height];
    
}
- (void)buildButtons:(CGFloat)height
{
    //暂时支持2个按钮
    CGFloat btnHeight = 44;
    if ([_buttons count] == 1) {
        CGRect tmpFrame = CGRectMake(0, height, self.frame.size.width, btnHeight);
        UIButton *btn = [self getBtnWithText:[_buttons firstObject]
                                       frame:tmpFrame];
        [btn addTarget:self
                action:@selector(actionClick:)
      forControlEvents:UIControlEventTouchUpInside];
        btn.titleLabel.font = ALFontOfCancelButton;
        [self addSubview:btn];
        height = btn.frame.origin.y + btn.frame.size.height;// btn.bottom;
    }
    else if(_buttons.count>1){
        CGFloat btnSpace = self.frame.size.width / _buttons.count;
        //目前只支持2个按钮
        for (int i = 0; i < _buttons.count; i ++) {
            CGRect tmpFrame = CGRectMake(i * btnSpace, height, btnSpace, btnHeight);
            UIButton *btn = [self getBtnWithText:[_buttons objectAtIndex:i]
                                           frame:tmpFrame];
            if (i == 0) {
                btn.titleLabel.font = ALFontOfCancelButton;
            }
            btn.tag = i;
            [btn addTarget:self
                    action:@selector(actionClick:)
          forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:btn];
        }
        for (int i = 0;i<_buttons.count-1;i++)
        {
            //垂直 分割线
            UIView *verticalLine = [[UIView alloc] init];
            verticalLine.backgroundColor = ALLineColorOfGray;
            CGFloat left = round(((i+1) * btnSpace - 0.25f)*2)/2.0f;
            CGRect lineFrame = CGRectMake(left, height, 0.5f, btnHeight);
            //        verticalLine.height = btnHeight;
            //        verticalLine.width = 0.5f;
            //        verticalLine.centerX = self.width/2;
            //        verticalLine.top = height;
            verticalLine.frame = lineFrame;
            [self addSubview:verticalLine];
        }
        
        
        height += btnHeight;
    }
    CGRect selfFrame = self.frame;
    selfFrame.size.height = height;
    self.frame = selfFrame;
    //    self.height = height;
}

- (UIButton *)getBtnWithText:(NSString *)text frame:(CGRect)frame{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:text forState:UIControlStateNormal];
    [btn setTitleColor:ALTextColorOfButton forState:UIControlStateNormal];
    [btn setBackgroundImage:nil
                   forState:UIControlStateNormal];
    UIImage *hlImage = [self getImageWithColor:ALBtnBGColorOfHL
                                          size:frame.size];
    [btn setBackgroundImage:hlImage
                   forState:UIControlStateHighlighted];
    btn.titleLabel.font = ALFontOfNormalButton;
    btn.frame = frame;
    
    return btn;
}

- (UIImage *)getImageWithColor:(UIColor *)bgColor size:(CGSize)size{
    UIGraphicsBeginImageContextWithOptions(size, NO, 1);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextAddRect(context, CGRectMake(0, 0, size.width, size.height));
    CGContextSetLineWidth(context, 0);
    [bgColor setFill];
    CGContextDrawPath(context, kCGPathFill);
    UIImage *finalImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return finalImage;
}

#pragma mark - action

- (void)actionClick:(id)sender{
    if ([_delegate respondsToSelector:@selector(snAlertView:clickedButtonAtIndex:)]) {
        UIButton *btn = (UIButton *)sender;
        [_delegate snAlertView:self clickedButtonAtIndex:btn.tag];
    }
    CGRect selfFrame = self.outFrame;
    [UIView animateWithDuration:0.25 animations:^(void)
     {
         self.frame = selfFrame;
         self.maskView.alpha = 0;
     }
                     completion:^(BOOL finished)
     {
         self.delegate = nil;
         [self removeFromSuperview];
         [self.maskView removeFromSuperview];
         self.maskView = nil;
     }];
    
}
- (void)show
{
    if(self.delegate)
    {
        if([self.delegate isKindOfClass:[UIViewController class]])
            [self show:((UIViewController *)self.delegate).view];
        else
        {
            UIViewController * vc  = [((UIView *)self.delegate) traverseResponderChainForUIViewController];
            if(vc)
            {
                [self show:vc.view];
            }
            else
            {
                UIView * v = [UIApplication sharedApplication].keyWindow.rootViewController.navigationController.topViewController.view;
                [self show:v];
            }
        }
    }
    else
    {
        UIView * v = [UIApplication sharedApplication].keyWindow.rootViewController.navigationController.topViewController.view;
        [self show:v];
    }
}
- (void)show:(nonnull UIView *)superView
{
    CGRect selfFrame = self.frame;
    selfFrame.origin.x = (superView.bounds.size.width - selfFrame.size.width)/2.0f;
    selfFrame.origin.y = superView.bounds.size.height;
    self.frame = selfFrame;
    self.outFrame = selfFrame;
    [superView addSubview:self];
    UIView * maskView = [[UIView alloc]initWithFrame:superView.bounds];
    maskView.backgroundColor = [UIColor blackColor];
    maskView.alpha = 0;
    [superView insertSubview:maskView belowSubview:self];
    self.maskView = maskView;
    selfFrame.origin.y = (superView.bounds.size.height - selfFrame.size.height)/2.0f;
    
    [UIView animateWithDuration:0.35 animations:^(void)
     {
         self.frame = selfFrame;
         maskView.alpha = 0.2;
     }];
}

@end
