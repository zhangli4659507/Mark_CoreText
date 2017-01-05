//
//  MDownLoadImageTool.h
//  Mark_CoreText
//
//  Created by Mark on 2017/1/5.
//  Copyright © 2017年 Mark. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface MDownLoadImageTool : NSObject
+ (void)downLoadImaWithUrl:(NSString *)imaUrl finishBlock:(void (^)(UIImage *image))success;
@end
