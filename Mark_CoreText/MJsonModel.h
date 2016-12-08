//
//  MJsonModel.h
//  Mark_CoreText
//
//  Created by Mark on 2016/12/8.
//  Copyright © 2016年 Mark. All rights reserved.
//

#import <Foundation/Foundation.h>
#import   "MJExtension.h"
@interface MLinkJsonModel : NSObject
@property (nonatomic, copy) NSString *ref;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *href;
@end

@interface MImaJsonModel : NSObject
@property (nonatomic, copy) NSString *ref;
@property (nonatomic, copy) NSString *pixel;
@property (nonatomic, copy) NSString *src;
@property (nonatomic, copy) NSString *alt;
@end

@interface MJsonModel : NSObject
@property (nonatomic, copy) NSString *body;
@property (nonatomic, strong) NSArray<MLinkJsonModel *> *link;
@property (nonatomic, strong) NSArray<MImaJsonModel *> *img;

+ (MJsonModel *)jsonModelCreateLocalPath;

@end
