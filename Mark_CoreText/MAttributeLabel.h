//
//  MAttributeLabel.h
//  Mark_CoreText
//
//  Created by Mark on 2017/1/10.
//  Copyright © 2017年 Mark. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MAttributeLabel : UILabel
@property (nonatomic, strong) NSMutableAttributedString *attString;
- (void)appendText:(NSString *)text;

- (void)appendAttributeString:(NSAttributedString *)att;
- (void)appendImageWithImage:(UIImage *)image size:(CGSize)size;
- (CGFloat)contentHeight;
@end
