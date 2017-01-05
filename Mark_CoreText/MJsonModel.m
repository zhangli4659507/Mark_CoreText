//
//  MJsonModel.m
//  Mark_CoreText
//
//  Created by Mark on 2016/12/8.
//  Copyright © 2016年 Mark. All rights reserved.
//

#import "MJsonModel.h"
#import "MDownLoadImageTool.h"

@interface MImaJsonModel ()
@property (nonatomic, strong) UIImage *image;
@end

@implementation MImaJsonModel

- (CGFloat)imaScale {

    if (self.pixel && [self.pixel containsString:@"*"]) {
        CGFloat height =    [[[self.pixel componentsSeparatedByString:@"*"] lastObject] floatValue]/2;
        CGFloat wid =    [[[self.pixel componentsSeparatedByString:@"*"] firstObject] floatValue]/2;
        return height/wid;
    }
    return 1;
}

- (void)setDisplaySuperView:(UIView *)displaySuperView {
    _displaySuperView = displaySuperView;
    if (_src) {
        [MDownLoadImageTool downLoadImaWithUrl:self.src finishBlock:^(UIImage *image) {
            if (image) {
                _image = image;
                [self.displaySuperView setNeedsDisplay];
            }
        }];
    }
}

- (void)drawRectWithDisplaySuperView:(UIView *)dispaySuperView {

    self.displaySuperView = dispaySuperView;
    if (_image) {
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextDrawImage(context, self.imgRect, _image.CGImage);
    }
}

@end

@implementation MLinkJsonModel


@end

@implementation MJsonModel
+ (NSDictionary *)mj_objectClassInArray {

    return @{@"link":[MLinkJsonModel class],@"img":[MImaJsonModel class]};
}

+ (MJsonModel *)jsonModelCreateLocalPath {

    NSString *path = [[NSBundle mainBundle] pathForResource:@"json" ofType:@""];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSDictionary *dicJson =  [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    if (!dicJson) {
        return [self new];
    }
    MJsonModel *model = [MJsonModel mj_objectWithKeyValues:[[dicJson allValues] firstObject]];
    return model;
}

- (void)setBody:(NSString *)body {

    _body = body;
    if (body.length > 0) {
        _body = [_body stringByReplacingOccurrencesOfString:@"<p>" withString:@""];
        _body = [_body stringByReplacingOccurrencesOfString:@"</p>" withString:@"\n"];
    }
    
}

@end
