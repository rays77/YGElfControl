//
//  YGTextView.h
//  iOutletShopping
//
//  Created by Ray on 2017/6/12.
//  Copyright © 2017年 aolaigo. All rights reserved.
//
//

#import <UIKit/UIKit.h>

@protocol YGTextViewLimitDelgate <NSObject>

@optional
- (void)yg_textViewShouldBeginEditing:(UITextView *)textView;
- (void)yg_textViewLimitText:(UITextView *)textView text:(NSString *)text;
- (void)yg_textViewDidChange:(UITextView *)textView;

@end

typedef void(^YGTextViewLimitCallBack)(NSString *text);

@interface YGTextView : UITextView

/** 占位文字 */
@property (nonatomic, copy) NSString *placeholder;
/** 占位文字颜色 */
@property (nonatomic, strong) UIColor *placeholderColor;
/** 字数限制 */
@property (nonatomic, assign) NSInteger limitWordsNumber;
/** 手动控制，显示占位文字 */
@property (nonatomic, assign) BOOL showPlaceholder;
/** 是否允许输入Emoji，默认不支持 */
@property (nonatomic, assign) BOOL isContainsEmoji;
/** 是否允许输输入，默认允许 */
@property (nonatomic, assign) BOOL isAllowEdite;

@property (nonatomic, assign) id <YGTextViewLimitDelgate> limitDelegate;
@property (nonatomic, copy) YGTextViewLimitCallBack callBack;

@end
