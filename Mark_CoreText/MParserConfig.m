//
//  MParserConfig.m
//  Mark_CoreText
//
//  Created by Mark on 2016/12/8.
//  Copyright © 2016年 Mark. All rights reserved.
//

#import "MParserConfig.h"
#import <UIKit/UIKit.h>
#import <UIColor+HexString.h>
#import <CoreText/CoreText.h>
@implementation MParserConfig
#pragma mark - publicFunc
+ (MParserConfig *)attributeStringWithJsonModel:(MJsonModel *)jsonModel withBouns:(CGRect)bounds {
    NSMutableAttributedString *attributedStr;
    MParserConfig *config = [[MParserConfig alloc] init];
    if (jsonModel.body.length > 0) {
        attributedStr = [[NSMutableAttributedString alloc] initWithString:jsonModel.body attributes:[self getTextAttributes]];
        [self cinfigLinkWithAttributrStr:attributedStr jsonModel:jsonModel];
        [self cinfigImgWithAttributrStr:attributedStr jsonModel:jsonModel];
        config.attString = attributedStr;
        [config createFrameSetterAndFrameWithBounds:bounds];
        //获取图片的绘制位置
        [config fillImageRectWithJsonModel:jsonModel];
        
        config.imaModelList = jsonModel.img;
        config.linkModelList = jsonModel.link;
    }
    return  config;
}

- (CGFloat)frameSetterHeightWithWidth:(CGFloat)width {

    CGSize size = CGSizeZero;
    if (_attString.length > 0 && _setter) {
     size = CTFramesetterSuggestFrameSizeWithConstraints(self.setter, CFRangeMake(0, self.attString.length), NULL, CGSizeMake(width, CGFLOAT_MAX), NULL);
    }
    return size.height;
}

- (MLinkJsonModel *)touchLinkInview:(UIView *)view atPoint:(CGPoint)point {
    
    CFArrayRef lines = CTFrameGetLines(_frameRef);
    if (!lines) return nil;
    CFIndex count = CFArrayGetCount(lines);
    CGPoint origins[count];
    CTFrameGetLineOrigins(_frameRef, CFRangeMake(0, 0), origins);
    CGAffineTransform transform = CGAffineTransformMakeTranslation(0, view.bounds.size.height);
    transform = CGAffineTransformScale(transform, 1.f, -1.f);
    
    for (int i = 0; i < count; i++) {
        CGPoint linePoint = origins[i];
        CTLineRef line = CFArrayGetValueAtIndex(lines, i);
        //获取到每个line的rect
        CGRect flippedRect  = [self getLineBounds:line point:linePoint];
        CGRect rect = CGRectApplyAffineTransform(flippedRect, transform);
        if (CGRectContainsPoint(rect, point)) {
            //将点击的坐标转换成相对于当前行的坐标
            CGPoint relativePoint = CGPointMake(point.x - CGRectGetMinX(rect), point.y - CGRectGetMinY(rect));
            //获得当前点击坐标对应的字符串偏移
            CFIndex idx = CTLineGetStringIndexForPosition(line, relativePoint);
            //判断这个偏移是否在我们的链接列表中
            MLinkJsonModel *linkModel = [self linkAtIndex:idx];
            return linkModel;
        }
    }
    return nil;
}

#pragma mark - privateFunc
- (void)createFrameSetterAndFrameWithBounds:(CGRect)rect {
    
    if (_attString.length == 0) {
        return;
    }
    CTFramesetterRef setter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)self.attString);
    _setter = setter;
    rect = CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, 1009);
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, rect);
    CTFrameRef frameRef = CTFramesetterCreateFrame(setter, CFRangeMake(0, self.attString.length), path, nil);
    _frameRef = frameRef;
    CFRelease(path);
    
}

- (MLinkJsonModel *)linkAtIndex:(CFIndex)index {

    MLinkJsonModel *selectLinkModel = nil;
    for (MLinkJsonModel *linkModel in self.linkModelList) {
        if (NSLocationInRange(index, linkModel.linkRange)) {
            selectLinkModel = linkModel;
            break;
        }
    }
    return selectLinkModel;
}

- (CGRect)getLineBounds:(CTLineRef)line point:(CGPoint)point {

    CGFloat ascent = 0.0f;
    CGFloat desecnt = 0.0f;
    CGFloat leading = 0.0f;
    CGFloat width = (CGFloat)CTLineGetTypographicBounds(line, &ascent, &desecnt, &leading);
    CGFloat height = ascent + desecnt;
    return CGRectMake(point.x, point.y - desecnt, width, height);
}

- (void)fillImageRectWithJsonModel:(MJsonModel *)jsonModel {

    if (jsonModel.img.count == 0 || _attString.length == 0) {
        return;
    }
    
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
          MImaJsonModel *imaModel =  (__bridge MImaJsonModel*)CTRunDelegateGetRefCon(delegate);
            CGFloat xOffset = CTLineGetOffsetForStringIndex(line, CTRunGetStringRange(run).location, NULL);
            imaRect = CGRectMake(lineOrigins[i].x + xOffset, lineOrigins[i].y - descent, wid, ascent + descent);
            
            CGPathRef path = CTFrameGetPath(_frameRef);
            CGRect  colRect = CGPathGetBoundingBox(path);
            CGRect delegateBounds = CGRectOffset(imaRect, colRect.origin.x, colRect.origin.y);
            
            if (imaModel) {
                imaModel.imgRect = delegateBounds;
            }
        }
    }
}

#pragma mark - privateFunc
+ (NSDictionary *)getTextAttributes {

    UIFont *font = [UIFont systemFontOfSize:15.f];
    UIColor *textColor = [UIColor colorWithHexString:@"#333"];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 4.f;
    paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
    return @{NSFontAttributeName:font,NSParagraphStyleAttributeName:paragraphStyle,NSForegroundColorAttributeName:textColor};
}

+ (NSDictionary *)getLinkAttributes {

    UIFont *font = [UIFont systemFontOfSize:12.f];
    UIColor *textColor = [UIColor colorWithHexString:@"#e13b29"];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 4.f;
    paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
    return @{NSFontAttributeName:font,NSParagraphStyleAttributeName:paragraphStyle,NSForegroundColorAttributeName:textColor};
}

static CGFloat ascentCallBack(void *ref) {
    MImaJsonModel *imaModel = (__bridge  MImaJsonModel*)ref;
    return [[[imaModel.pixel componentsSeparatedByString:@"*"] lastObject] floatValue]/2;

}

static CGFloat descentCallBack(void *ref) {
 
    return 0.f;
}

static CGFloat widthCallBack(void *ref) {
    MImaJsonModel *imaModel = (__bridge MImaJsonModel*)ref;
    return  [[[imaModel.pixel componentsSeparatedByString:@"*"] firstObject] floatValue]/2;
}

static void deallocCallBack() {

}

+ (void)cinfigImgWithAttributrStr:(NSMutableAttributedString *)attributrdStr jsonModel:(MJsonModel *)jsonModel {

    for (MImaJsonModel *imaModel in jsonModel.img) {
       NSRange range = [attributrdStr.string rangeOfString:imaModel.ref];
        if (range.location != NSNotFound) {
            CTRunDelegateCallbacks callBacks;
            memset(&callBacks, 0, sizeof(CTRunDelegateCallbacks));
            callBacks.version = kCTRunDelegateVersion1;
            callBacks.dealloc = deallocCallBack;
            callBacks.getAscent = ascentCallBack;
            callBacks.getDescent = descentCallBack;
            callBacks.getWidth = widthCallBack;
//            将对象的所有权交给cf 不然会包空指针异常
            CTRunDelegateRef delegate = CTRunDelegateCreate(&callBacks, (__bridge_retained void * _Nullable)(imaModel));
            unichar replaceChar = 0xFFFC;
            NSString *content = [NSString stringWithCharacters:&replaceChar length:1];
            NSMutableAttributedString *att = [[NSMutableAttributedString alloc] initWithString:content attributes:[self getTextAttributes]];
            CFAttributedStringSetAttribute((CFMutableAttributedStringRef)att, CFRangeMake(0, 1), kCTRunDelegateAttributeName, delegate);
            NSString *alt = [NSString stringWithFormat:@"\n%@\n",imaModel.alt];
            [att appendAttributedString:[[NSAttributedString alloc] initWithString:alt attributes:[self getLinkAttributes]]];
            [attributrdStr replaceCharactersInRange:range withAttributedString:att];
            CFRelease(delegate);
        }
    }
}

+ (void)cinfigLinkWithAttributrStr:(NSMutableAttributedString *)attributrdStr jsonModel:(MJsonModel *)jsonModel {
    
    for (MLinkJsonModel *linkModel in jsonModel.link) {
        NSRange range = [attributrdStr.string rangeOfString:linkModel.ref];
        if (range.location != NSNotFound) {
          NSMutableAttributedString *att = [[NSMutableAttributedString alloc] initWithString:linkModel.title attributes:[self getLinkAttributes]];
            linkModel.linkRange = range;
            [attributrdStr replaceCharactersInRange:range withAttributedString:att];
        }
    }
}

- (void)dealloc {

    if (_frameRef) {
     CFRelease(_frameRef);
    }
    if (_setter) {
         CFRelease(_setter);
    }
   
}

@end
