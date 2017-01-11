//
//  MTextStore.h
//  Mark_CoreText
//
//  Created by Mark on 2017/1/10.
//  Copyright © 2017年 Mark. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>
@interface MTextStore : NSObject
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, strong) UIFont *font;
@property (nonatomic, assign) CTUnderlineStyle underlineStyle;
@property (nonatomic, assign) CTUnderlineStyleModifiers underlineStyleModifiers;
@end
