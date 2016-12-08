//
//  MParserConfig.m
//  Mark_CoreText
//
//  Created by Mark on 2016/12/8.
//  Copyright © 2016年 Mark. All rights reserved.
//

#import "MParserConfig.h"
#import <UIKit/UIKit.h>
#import <UIColor+HexString.h>

@implementation MParserConfig
+ (NSAttributedString *)attributeStringWithJsonModel:(MJsonModel *)jsonModel {

    NSMutableAttributedString *attributedStr;
    if (jsonModel.body.length > 0) {
        attributedStr = [[NSMutableAttributedString alloc] initWithString:jsonModel.body attributes:[self getTextAttributes]];
        [self cinfigLinkWithAttributrStr:attributedStr jsonModel:jsonModel];
        [self cinfigImgWithAttributrStr:attributedStr jsonModel:jsonModel];
    }
    return  attributedStr;
}

+ (NSDictionary *)getTextAttributes {

    UIFont *font = [UIFont systemFontOfSize:15.f];
    UIColor *textColor = [UIColor colorWithHexString:@"#333"];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 4.f;
    paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
    return @{NSFontAttributeName:font,NSParagraphStyleAttributeName:paragraphStyle,NSForegroundColorAttributeName:textColor};
}

+ (NSDictionary *)getLinkAttributes {

    UIFont *font = [UIFont systemFontOfSize:12.f];
    UIColor *textColor = [UIColor colorWithHexString:@"#e13b29"];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 4.f;
    paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
    return @{NSFontAttributeName:font,NSParagraphStyleAttributeName:paragraphStyle,NSForegroundColorAttributeName:textColor};
}

+ (void)cinfigImgWithAttributrStr:(NSMutableAttributedString *)attributrdStr jsonModel:(MJsonModel *)jsonModel {

    
    
    
}

+ (void)cinfigLinkWithAttributrStr:(NSMutableAttributedString *)attributrdStr jsonModel:(MJsonModel *)jsonModel {
    
    for (MLinkJsonModel *linkModel in jsonModel.link) {
        NSRange range = [attributrdStr.string rangeOfString:linkModel.ref];
        
//        [attributrdStr replaceCharactersInRange:range withAttributedString:<#(nonnull NSAttributedString *)#>];
        
    }
}


@end
