//
//  MAttributeLabel.m
//  Mark_CoreText
//
//  Created by Mark on 2017/1/10.
//  Copyright © 2017年 Mark. All rights reserved.
//

#import "MAttributeLabel.h"
#import <CoreText/CoreText.h>
#import "MTextContainer.h"
#import "MImageStore.h"
@interface MAttributeLabel()

@property (nonatomic, strong) MTextContainer *container;
@end

@implementation MAttributeLabel

#pragma mark - overrideFunc
- (instancetype)initWithFrame:(CGRect)frame {


    if (self = [super initWithFrame:frame]) {
        [self initialize];
    }
    
    return self;
    
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {

    if (self = [super initWithCoder:aDecoder]) {
        [self initialize];
    }
    return self;
}

- (void)initialize {

    self.attString = [[NSMutableAttributedString alloc] init];
    self.container = [[MTextContainer alloc] init];
}

#pragma mark - publicFunc

- (void)appendText:(NSString *)text {

    [_container appendText:text];
    [self setNeedsDisplay];
}

- (void)appendAttributeString:(NSAttributedString *)att {

    [_container appendAttributeString:att];
    [self setNeedsDisplay];
}

- (void)appendImageWithImage:(UIImage *)image size:(CGSize)size {

    if (!image) {
        return;
    }
    [_container appendImageWithImage:image size:size];
    [self setNeedsDisplay];
}

- (CGFloat)contentHeight {

    return [_container contentHeightWithWidth:CGRectGetWidth(self.bounds)];
}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    if (_container == nil || _container.attString.length == 0) {
        return;
    }
    
    [_container createFrameRefWithTextRect:self.bounds];
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);//设置字形的变换矩阵为不做图形变换
    CGContextTranslateCTM(context, 0, self.bounds.size.height);//平移方法，将画布向上平移一个屏幕高
    CGContextScaleCTM(context, 1.0, -1.0);
    CTFrameDraw(_container.frameRef, context);
    [self drawOtherStore];
}

- (void)drawOtherStore {

    for (MImageStore *store in _container.arrRunStores) {
        store.owerView = self;
        [store drawImageStrore];
    }
    
}

@end
