//
//  NSMutableAttributedString+Mark.h
//  Mark_CoreText
//
//  Created by Mark on 2017/1/10.
//  Copyright © 2017年 Mark. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSMutableAttributedString (Mark)
- (void)m_setTextColor:(UIColor *)color;
- (void)m_setTextColor:(UIColor *)color range:(NSRange )range;

- (void)m_setFont:(UIFont *)font ;
- (void)m_setFont:(UIFont *)font range:(NSRange)range;

- (void)m_setUnderLineStyle:(NSUnderlineStyle)underlineStyle;
- (void)m_setUnderLineStyle:(NSUnderlineStyle)underlineStyle range:(NSRange)range;

- (void)m_setAligment:(NSTextAlignment)aligment lineSpace:(CGFloat)lineSpace lineBreakMode:(NSLineBreakMode)lineBreakMode;
- (void)m_setAligment:(NSTextAlignment)aligment lineSpace:(CGFloat)lineSpace lineBreakMode:(NSLineBreakMode)lineBreakMode range:(NSRange)range;
@end
