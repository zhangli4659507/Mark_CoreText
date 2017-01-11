//
//  MImageStore.h
//  Mark_CoreText
//
//  Created by Mark on 2017/1/10.
//  Copyright © 2017年 Mark. All rights reserved.
//

#import "MTextStore.h"

@interface MImageStore : MTextStore
@property (nonatomic, weak) UIView *owerView;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) NSString *imaUrl;
@property (nonatomic, strong) NSString *replaceImageName;
@property (nonatomic, assign) UIEdgeInsets margin;
@property (nonatomic, assign) NSRange range;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGRect imageRect;//cg下的坐标

- (NSAttributedString *)createAttString;
- (void)drawImageStrore;
@end
