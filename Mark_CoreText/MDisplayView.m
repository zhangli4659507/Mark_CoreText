//
//  MDisplayView.m
//  Mark_CoreText
//
//  Created by Mark on 2016/12/9.
//  Copyright © 2016年 Mark. All rights reserved.
//

#import "MDisplayView.h"
#import <CoreText/CoreText.h>
#import "SDWebImageDownloader.h"

@implementation MDisplayView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CGContextTranslateCTM(context, 0, self.bounds.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    if (_config.frameRef) {
            CTFrameDraw(_config.frameRef, context);
    }
    
    if (_config.imaModel.count > 0) {
        [self drawImaWithContext:context];
    }
    // Drawing code
}

- (void)drawImaWithContext:(CGContextRef)context {

    for (MImaJsonModel *imaModel in _config.imaModel) {
        [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:imaModel.src] options:SDWebImageDownloaderIgnoreCachedResponse progress:nil completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
            
            if (image) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    imaModel.imgRect = CGRectMake(10,imaModel.imgRect.origin.y, CGRectGetWidth(imaModel.imgRect) - 20, CGRectGetHeight(imaModel.imgRect));
                    CGContextDrawImage(context, imaModel.imgRect, image.CGImage);

                });
               
            }
        }];
    }
    
   
    
}


@end
