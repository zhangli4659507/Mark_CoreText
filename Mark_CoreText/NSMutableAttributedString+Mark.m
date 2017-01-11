//
//  NSMutableAttributedString+Mark.m
//  Mark_CoreText
//
//  Created by Mark on 2017/1/10.
//  Copyright © 2017年 Mark. All rights reserved.
//

#import "NSMutableAttributedString+Mark.h"
#import <CoreText/CoreText.h>
@implementation NSMutableAttributedString (Mark)
- (void)m_setTextColor:(UIColor *)color {
    [self m_setTextColor:color range:NSMakeRange(0, self.length)];
}

- (void)m_setTextColor:(UIColor *)color range:(NSRange )range {

    [self removeAttribute:NSForegroundColorAttributeName range:range];
    [self addAttribute:NSForegroundColorAttributeName value:color range:range];
}

- (void)m_setFont:(UIFont *)font {
    [self m_setFont:font range:NSMakeRange(0, self.length)];
}

- (void)m_setFont:(UIFont *)font range:(NSRange)range {

    [self removeAttribute:NSFontAttributeName range:range];
    [self addAttribute:NSFontAttributeName value:font range:range];
}

- (void)m_setUnderLineStyle:(NSUnderlineStyle)underlineStyle {

    [self m_setUnderLineStyle:underlineStyle range:NSMakeRange(0, self.length)];
}

- (void)m_setUnderLineStyle:(NSUnderlineStyle)underlineStyle range:(NSRange)range {

    [self removeAttribute:NSUnderlineStyleAttributeName range:range];
    
    if (underlineStyle != NSUnderlineStyleNone) {
        [self addAttribute:NSUnderlineStyleAttributeName value:@(underlineStyle) range:range];
    }
}

- (void)m_setAligment:(NSTextAlignment)aligment lineSpace:(CGFloat)lineSpace lineBreakMode:(NSLineBreakMode)lineBreakMode {
    [self m_setAligment:aligment lineSpace:lineSpace lineBreakMode:lineBreakMode];
}

- (void)m_setAligment:(NSTextAlignment)aligment lineSpace:(CGFloat)lineSpace lineBreakMode:(NSLineBreakMode)lineBreakMode range:(NSRange)range {
    
    CTParagraphStyleSetting aligmentStyle;
    aligmentStyle.spec = kCTParagraphStyleSpecifierAlignment;
    aligmentStyle.valueSize = sizeof(aligment);
    aligmentStyle.value = &aligment;
    
    CTParagraphStyleSetting lineBreakModeStyle;
    lineBreakModeStyle.spec = kCTParagraphStyleSpecifierLineBreakMode;
    lineBreakModeStyle.valueSize = sizeof(lineBreakMode);
    lineBreakModeStyle.value = &lineBreakMode;
    
    CTParagraphStyleSetting lineSpaceStyle;
    lineSpaceStyle.spec = kCTParagraphStyleSpecifierLineSpacingAdjustment;
    lineSpaceStyle.valueSize = sizeof(lineSpace);
    lineSpaceStyle.value = &lineSpace;
    CTParagraphStyleSetting settings[] = {aligmentStyle,lineSpaceStyle,lineBreakModeStyle};
    
    CTParagraphStyleRef paragraphStyle = CTParagraphStyleCreate(settings, sizeof(settings)/sizeof(settings[0]));
    [self addAttribute:NSParagraphStyleAttributeName value:(id)paragraphStyle range:range];
    
    
}


@end
