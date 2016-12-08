//
//  MParserConfig.h
//  Mark_CoreText
//
//  Created by Mark on 2016/12/8.
//  Copyright © 2016年 Mark. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJsonModel.h"
@interface MParserConfig : NSObject
+ (NSAttributedString *)attributeStringWithJsonModel:(MJsonModel *)jsonModel;
@end
