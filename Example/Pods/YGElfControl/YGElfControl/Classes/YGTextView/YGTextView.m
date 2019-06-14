//
//  YGTextView.m
//  iOutletShopping
//
//  Created by Ray on 2017/6/12.
//  Copyright © 2017年 aolaigo. All rights reserved.
//

#import "YGTextView.h"

@interface YGTextView () <UITextViewDelegate>

@end

@implementation YGTextView
{
    NSString *_placheholdString;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.placeholderColor = [UIColor lightGrayColor];
        self.limitWordsNumber = 0;
        self.isAllowEdite = YES;
        self.delegate = self;
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        self.placeholderColor = [UIColor lightGrayColor];
        self.limitWordsNumber = 0;
        self.isAllowEdite = YES;
        self.delegate = self;
    }
    return self;
}

#pragma mark - Setter Method

/** 设置属性时需要重绘 */
- (void)setText:(NSString *)text
{
    [super setText:text];
    if (text.length) {
        // 有值内容时不显示placeholder
        _placeholder = @"";
    } else {
        _placeholder = _placheholdString;
    }
    [self setNeedsDisplay];
}

- (void)setAttributedText:(NSAttributedString *)attributedText
{
    [super setAttributedText:attributedText];
    if (attributedText.length) {
        _placeholder = @"";
    }
    [self setNeedsDisplay];
}

- (void)setPlaceholder:(NSString *)placeholder
{
    if (self.hasText) {
        _placeholder = @"";
    } else {
        _placeholder = placeholder;
    }
    _placheholdString = placeholder;
    [self setNeedsDisplay];
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = placeholderColor;
    [self setNeedsDisplay];
}

- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    [self setNeedsDisplay];
}

- (void)setLimitWordsNumber:(NSInteger)limitWordsNumber
{
    _limitWordsNumber = limitWordsNumber;
    
    [self callBackAndDelegate];
}

- (void)setShowPlaceholder:(BOOL)showPlaceholder
{
    if (showPlaceholder) {
        self.text = @"";
        _placeholder = _placheholdString;
    } else {
        _placeholder = @"";
    }
    [self setNeedsDisplay];
}

#pragma mark - UITextViewDelegate

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString*)text
{
//    if ([text isEqualToString:@"\n"]) {
//        [textView resignFirstResponder];
//        return NO;
//    }
    
    if ([textView isFirstResponder]) {
        // 中文状态Emoji的输入
        if ([[[textView textInputMode] primaryLanguage] isEqualToString:@"emoji"] || ![[textView textInputMode] primaryLanguage]) {
            return NO;
        }
        
        // 判断键盘是不是九宫格键盘
        if ([YGTextView isNineKeyBoard:text]) {
            return _isAllowEdite;
        } else {
            // 判断是否需要限制输入Emoji
            if (!_isContainsEmoji && ([YGTextView hasEmoji:text] || [YGTextView stringContainsEmoji:text])) {
                return NO;
            }
        }
    }
    return _isAllowEdite;
}

- (void)textViewDidChange:(YGTextView *)textView
{
    if (textView.hasText) {
        _placeholder = @"";
    } else {
        _placeholder = _placheholdString;
    }
    
    [self setNeedsDisplay];
    
    //字数限制
    if (_limitWordsNumber && _limitWordsNumber > 0) {
        [self limitWordsInputString:textView.text];
    }
    
    [self callBackAndDelegate];
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    if (_limitDelegate && [_limitDelegate respondsToSelector:@selector(yg_textViewShouldBeginEditing:)]) {
        [_limitDelegate yg_textViewShouldBeginEditing:textView];
    }
    return _isAllowEdite;
}

#pragma mark - 回调的限制文字字数

- (void)callBackAndDelegate
{
    // 回调
    if (_limitDelegate && [_limitDelegate respondsToSelector:@selector(yg_textViewLimitText:text:)]) {
        [_limitDelegate yg_textViewLimitText:self text:[self limit]];
    }
    
    if (_limitDelegate && [_limitDelegate respondsToSelector:@selector(yg_textViewDidChange:)]) {
        [_limitDelegate yg_textViewDidChange:self];
    }
    
    // 回调
    if (_callBack) {
        _callBack([self limit]);
    }
}

- (NSString *)limit
{
    if (self.text.length > _limitWordsNumber) {
        self.text = [self.text substringToIndex:_limitWordsNumber];
    }
    NSString *limitText = [NSString stringWithFormat:@"%ld/%ld", (unsigned long)self.text.length, (long)self.limitWordsNumber];
    
    return limitText;
}

#pragma mark - 计算文字限制

//限制字符输入方法
- (void)limitWordsInputString:(NSString *)toBeString
{
    // 键盘输入模式
    NSString *lang = self.textInputMode.primaryLanguage;
    
    NSInteger number = _limitWordsNumber;
    
    // 简体中文输入，包括简体拼音，健体五笔，简体手写
    if ([lang isEqualToString:@"zh-Hans"])
    {
        UITextRange *selectedRange = [self markedTextRange];
        //获取高亮部分
        UITextPosition *position = [self positionFromPosition:selectedRange.start offset:0];
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position)
        {
            if (toBeString.length > number)
            {
                self.text = [toBeString substringToIndex:number];
            }
        }
        // 有高亮选择的字符串，则暂不对文字进行统计和限制
        else
        {
            
        }
    }
    // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
    else
    {
        if (toBeString.length > number)
        {
            self.text = [toBeString substringToIndex:number];
        }
    }
}

+ (NSString *)disable_emoji:(NSString *)text
{
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]" options:NSRegularExpressionCaseInsensitive error:nil];
    NSString *modifiedString = [regex stringByReplacingMatchesInString:text
                                                               options:0
                                                                 range:NSMakeRange(0, [text length])
                                                          withTemplate:@""];
    return modifiedString;
}

/**
 判断是不是九宫格
 @param string  输入的字符
 @return YES(是九宫格拼音键盘)
 */
+ (BOOL)isNineKeyBoard:(NSString *)string
{
    NSString *other = @"➋➌➍➎➏➐➑➒";
    int len = (int)string.length;
    for(int i = 0; i < len; i++)
    {
        if(!([other rangeOfString:string].location != NSNotFound))
            return NO;
    }
    return YES;
}

/**
 限制第三方输入法，是否包含Emoji，如搜狗
 */
+ (BOOL)hasEmoji:(NSString*)string;
{
    NSString *pattern = @"[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:string];
    return isMatch;
}

/**
 限制系统输入法，是否包含Emoji
 */
+ (BOOL)stringContainsEmoji:(NSString *)string
{
    __block BOOL returnValue = NO;
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length])
                               options:NSStringEnumerationByComposedCharacterSequences
                            usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                                const unichar hs = [substring characterAtIndex:0];
                                if (0xd800 <= hs && hs <= 0xdbff) {
                                    if (substring.length > 1) {
                                        const unichar ls = [substring characterAtIndex:1];
                                        const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                                        if (0x1d000 <= uc && uc <= 0x1f77f) {
                                            returnValue = YES;
                                        }
                                    }
                                } else if (substring.length > 1) {
                                    const unichar ls = [substring characterAtIndex:1];
                                    if (ls == 0x20e3) {
                                        returnValue = YES;
                                    }
                                } else {
                                    if (0x2100 <= hs && hs <= 0x27ff) {
                                        returnValue = YES;
                                    } else if (0x2B05 <= hs && hs <= 0x2b07) {
                                        returnValue = YES;
                                    } else if (0x2934 <= hs && hs <= 0x2935) {
                                        returnValue = YES;
                                    } else if (0x3297 <= hs && hs <= 0x3299) {
                                        returnValue = YES;
                                    } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                                        returnValue = YES;
                                    }
                                }
                            }];
    return returnValue;
}

#pragma mark - Overrid Method

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = self.font;
    attrs[NSForegroundColorAttributeName] = self.placeholderColor;
    
    [_placeholder drawInRect:CGRectMake(4, 7, self.frame.size.width-2, self.frame.size.height) withAttributes:attrs];
}

@end
