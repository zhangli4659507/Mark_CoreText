//
//  MParserConfig.h
//  Mark_CoreText
//
//  Created by Mark on 2016/12/8.
//  Copyright © 2016年 Mark. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJsonModel.h"
#import <CoreText/CoreText.h>
@interface MParserConfig : NSObject
@property (nonatomic, assign) CTFramesetterRef setter;
@property (nonatomic, strong) NSMutableAttributedString *attString;
@property (nonatomic, assign) CTFrameRef frameRef;
@property (nonatomic, strong) NSArray<MImaJsonModel *> *imaModelList;
@property (nonatomic, strong) NSArray<MLinkJsonModel *> *linkModelList;
+ (MParserConfig *)attributeStringWithJsonModel:(MJsonModel *)jsonModel withBouns:(CGRect)bounds;
- (MLinkJsonModel *)touchLinkInview:(UIView *)view atPoint:(CGPoint)pointt;
- (CGFloat)frameSetterHeightWithWidth:(CGFloat)width;
@end
