//
//  MTextContainer.h
//  Mark_CoreText
//
//  Created by Mark on 2017/1/10.
//  Copyright © 2017年 Mark. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>
@interface MTextContainer : NSObject
@property (nonatomic, strong) NSMutableAttributedString *attString;
@property (nonatomic, strong)   UIColor     *textColor;         // 文字颜色
@property (nonatomic, strong)   UIColor     *linkColor;         //链接颜色
@property (nonatomic, strong)   UIFont      *font;              // 文字大小
@property (nonatomic, assign)   NSTextAlignment textAlignment;  // 文本对齐方式 kCTTextAlignmentLeft
@property (nonatomic, assign)   NSLineBreakMode lineBreakMode;  // 换行模式
@property (nonatomic, assign) CGFloat lineSpace; //行距
@property (nonatomic, assign) CTFrameRef frameRef;
@property (nonatomic, strong) NSMutableArray *arrRunStores;
- (void)createFrameRefWithTextRect:(CGRect)rect;
- (CGFloat)contentHeightWithWidth:(CGFloat)width;
@end

@interface MTextContainer(text)
- (void)appendText:(NSString *)text;

- (void)appendAttributeString:(NSAttributedString *)att;

@end

@interface MTextContainer (image)
- (void)appendImageWithImage:(UIImage *)image size:(CGSize)size;
@end
