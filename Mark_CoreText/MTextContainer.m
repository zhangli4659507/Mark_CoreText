//
//  MTextContainer.m
//  Mark_CoreText
//
//  Created by Mark on 2017/1/10.
//  Copyright © 2017年 Mark. All rights reserved.
//

#import "MTextContainer.h"
#import "NSMutableAttributedString+Mark.h"
#import "MImageStore.h"
@interface MTextContainer ()
@end

@implementation MTextContainer

- (instancetype)init {

    if (self = [super init]) {
        [self initialize];
    }
    return self;
}

- (void)initialize {
    _attString = [[NSMutableAttributedString alloc] init];
    _arrRunStores = [NSMutableArray array];
    _font = [UIFont systemFontOfSize:15];
    _textColor = [UIColor cyanColor];
    _linkColor = [UIColor blueColor];
    _lineBreakMode = NSLineBreakByCharWrapping;
    _textAlignment = NSTextAlignmentLeft;
    _lineSpace = 2.f;
    
}

- (NSMutableAttributedString *)createAttributeStringWithText:(NSString*)text {

    if (text.length == 0) {
        return [NSMutableAttributedString new];
    }
    NSMutableAttributedString *att = [[NSMutableAttributedString alloc] initWithString:text];
    [self setTextFontAndColorWithAtt:att];
    return att;
    
}

- (void)setTextFontAndColorWithAtt:(NSMutableAttributedString *)att {

    [att m_setFont:_font];
    [att m_setTextColor:_textColor];
}

- (void)setLineBreakModeAndSoOnWithAtt:(NSMutableAttributedString *)att {
    [att m_setAligment:_textAlignment lineSpace:_lineSpace lineBreakMode:_lineBreakMode];
    
}

- (void)resetFrameRef {

    if (_frameRef) {
        CFRelease(_frameRef);
    }

}

- (CGFloat)textHeightWithFrameSetter:(CTFramesetterRef)setter width:(CGFloat)width {

    CGSize size = CGSizeZero;
    if (_attString.length > 0 && setter) {
        size = CTFramesetterSuggestFrameSizeWithConstraints(setter, CFRangeMake(0, _attString.length), NULL, CGSizeMake(width, CGFLOAT_MAX), NULL);
    }
    return size.height;
}

- (CTFrameRef)crateFrameRefwWithWid:(CGFloat)width rect:(CGRect)rect frameSetter:(CTFramesetterRef)setter {
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, CGRectMake(0, 0, CGRectGetWidth(rect), CGRectGetHeight(rect)));
    CTFrameRef frameRef = CTFramesetterCreateFrame(setter, CFRangeMake(0, _attString.length), path, NULL);
    CFRelease(path);
    return frameRef;
}

- (void)computerStroreRect {
    NSArray *lines = (NSArray *)CTFrameGetLines(_frameRef);
    int lintCount = (int)lines.count;
    CGPoint lineOrigins[lintCount];
    CTFrameGetLineOrigins(_frameRef, CFRangeMake(0, 0), lineOrigins);
    
    for (int i = 0 ; i < lintCount ; i++) {
        
        CTLineRef line = (__bridge CTLineRef)(lines[i]);
        NSArray *runs = (NSArray *)CTLineGetGlyphRuns(line);
        for (id runObj in runs) {
            CTRunRef run = (__bridge CTRunRef)(runObj);
            NSDictionary *runAttributes = (NSDictionary *)CTRunGetAttributes(run);
            CTRunDelegateRef delegate = (__bridge CTRunDelegateRef)runAttributes[(id)kCTRunDelegateAttributeName];
            if (!delegate) {
                continue;
            }
            
            CGRect imaRect ;
            CGFloat ascent;
            CGFloat descent;
            CGFloat wid = CTRunGetTypographicBounds(run, CFRangeMake(0, 0), &ascent, &descent, NULL);
            imaRect.size.height = ascent + descent;
            MImageStore *imaModel =  (__bridge MImageStore*)CTRunDelegateGetRefCon(delegate);
            CGFloat xOffset = CTLineGetOffsetForStringIndex(line, CTRunGetStringRange(run).location, NULL);
            imaRect = CGRectMake(lineOrigins[i].x + xOffset, lineOrigins[i].y - descent, wid, ascent + descent);
            
            CGPathRef path = CTFrameGetPath(_frameRef);
            CGRect  colRect = CGPathGetBoundingBox(path);
            CGRect delegateBounds = CGRectOffset(imaRect, colRect.origin.x, colRect.origin.y);
            
            if (imaModel) {
                imaModel.imageRect = delegateBounds;
            }
        }
    }

}



#pragma mark - publicFunc
- (CGFloat)contentHeightWithWidth:(CGFloat)width {
    CTFramesetterRef setter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)_attString);
    CGFloat height = [self textHeightWithFrameSetter:setter width:width];
    return height;
}

- (void)createFrameRefWithTextRect:(CGRect)rect {

    if (_frameRef) {
        return;
    }
    CTFramesetterRef setter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)_attString);
    _frameRef = [self crateFrameRefwWithWid:CGRectGetWidth(rect) rect:rect frameSetter:setter];
    [self computerStroreRect];
}

- (void)appendText:(NSString *)text {

    if (text.length == 0) {
        return;
    }
    NSMutableAttributedString *att = [self createAttributeStringWithText:text];
    [self appendAttributeString:att];
    
}

- (void)appendAttributeString:(NSAttributedString *)att {

    if (att.length == 0) {
        return;
    }
    
    if ([att isKindOfClass:[NSMutableAttributedString class]]) {
        [self setTextFontAndColorWithAtt:(NSMutableAttributedString *)att];
    }
    [_attString appendAttributedString:att];
    [self resetFrameRef];
    
}

- (void)appendImageWithImage:(UIImage *)image size:(CGSize)size {

    MImageStore *stre = [[MImageStore alloc] init];
    stre.image = image;
    stre.size = size;
    NSAttributedString *att = [stre createAttString];
    stre.range = NSMakeRange(_attString.length - 1, att.length);
    [self.arrRunStores addObject:stre];
    [self appendAttributeString:att];
}

@end
