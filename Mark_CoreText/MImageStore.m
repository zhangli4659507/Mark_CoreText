//
//  MImageStore.m
//  Mark_CoreText
//
//  Created by Mark on 2017/1/10.
//  Copyright © 2017年 Mark. All rights reserved.
//

#import "MImageStore.h"
#import <CoreText/CoreText.h>
@implementation MImageStore

CGFloat acentCallBack(void *ref) {

    MImageStore *store = (__bridge MImageStore*)ref;
    
    return store.size.height;
}

CGFloat decentCallBack(void *ref) {

    return 0;
}

CGFloat widthCallBack(void *ref) {
   MImageStore *store = (__bridge MImageStore*)ref;
    return store.size.width;
}
void deallocCallBack(void *ref) {

    
}

- (NSAttributedString *)createAttString {

    CTRunDelegateCallbacks dc;
    dc.version = kCTRunDelegateVersion1;
    dc.getAscent = acentCallBack;
    dc.getDescent = decentCallBack;
    dc.getWidth = widthCallBack;
    dc.dealloc = deallocCallBack;
    
    CTRunDelegateRef delegate = CTRunDelegateCreate(&dc, (void *)CFRetain((__bridge CFTypeRef)(self)));
    
    unichar spaceChar = 0xFFFC;
    NSString *spaceStr = [NSString stringWithCharacters:&spaceChar length:1];
    
    NSMutableAttributedString *att = [[NSMutableAttributedString alloc] initWithString:spaceStr];
    [att addAttribute:(__bridge_transfer NSString *)kCTRunDelegateAttributeName value:(__bridge id _Nonnull)(delegate) range:NSMakeRange(0, 1)];
    CFRelease(delegate);
    return att;
}

- (void)drawImageStrore {

    
    if (_image) {
        CGContextRef content = UIGraphicsGetCurrentContext();
        CGRect rect = UIEdgeInsetsInsetRect(self.imageRect, UIEdgeInsetsMake(0, 10, 0, 100));
        CGContextDrawImage(content, rect, _image.CGImage);
    }
    
}


@end
