//
//  MJsonModel.h
//  Mark_CoreText
//
//  Created by Mark on 2016/12/8.
//  Copyright © 2016年 Mark. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import   "MJExtension.h"
@interface MLinkJsonModel : NSObject
@property (nonatomic, copy) NSString *ref;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *href;
@property (nonatomic, assign) NSRange linkRange;
@end

@interface MImaJsonModel : NSObject
@property (nonatomic, copy) NSString *ref;
@property (nonatomic, strong) NSString *pixel;
@property (nonatomic, copy) NSString *src;
@property (nonatomic, copy) NSString *alt;
@property (nonatomic, assign) CGRect imgRect;
@property (nonatomic, weak) UIView *displaySuperView;
@property (nonatomic, assign,readonly) CGFloat imaScale;
- (void)drawRectWithDisplaySuperView:(UIView *)dispaySuperView;
@end

@interface MJsonModel : NSObject
@property (nonatomic, copy) NSString *body;
@property (nonatomic, strong) NSArray<MLinkJsonModel *> *link;
@property (nonatomic, strong) NSArray<MImaJsonModel *> *img;

+ (MJsonModel *)jsonModelCreateLocalPath;

@end
