//
//  MDownLoadImageTool.m
//  Mark_CoreText
//
//  Created by Mark on 2017/1/5.
//  Copyright © 2017年 Mark. All rights reserved.
//

#import "MDownLoadImageTool.h"
#import "SDWebImageDownloader.h"
#import "SDWebImageManager.h"
@implementation MDownLoadImageTool
+ (void)downLoadImaWithUrl:(NSString *)imaUrl finishBlock:(void (^)(UIImage *image))success {
    
    SDWebImageManager *manger = [SDWebImageManager sharedManager];
    NSURL *url = [NSURL URLWithString:imaUrl];
    if ([manger diskImageExistsForURL:url]) {
        
        NSString *imaPath = [manger cacheKeyForURL:url];
        NSString *filePath = [manger.imageCache defaultCachePathForKey:imaPath];
        UIImage *ima = [UIImage imageWithContentsOfFile:filePath];
        (!success)?:success(ima);
        
    } else {
                [manger downloadImageWithURL:url options:SDWebImageLowPriority|SDWebImageRetryFailed progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
            (!success)?:success(image);
        }];
    }
    
    
}
@end
