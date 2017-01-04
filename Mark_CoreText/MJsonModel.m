//
//  MJsonModel.m
//  Mark_CoreText
//
//  Created by Mark on 2016/12/8.
//  Copyright © 2016年 Mark. All rights reserved.
//

#import "MJsonModel.h"
@implementation MImaJsonModel


@end

@implementation MLinkJsonModel


@end

@implementation MJsonModel
+ (NSDictionary *)mj_objectClassInArray {

    return @{@"link":[MLinkJsonModel class],@"img":[MImaJsonModel class]};
}

+ (MJsonModel *)jsonModelCreateLocalPath {

    NSString *path = [[NSBundle mainBundle] pathForResource:@"json" ofType:@""];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSDictionary *dicJson =  [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    if (!dicJson) {
        return [self new];
    }
    MJsonModel *model = [MJsonModel mj_objectWithKeyValues:[[dicJson allValues] firstObject]];
    return model;
}

- (void)setBody:(NSString *)body {

    _body = body;
    if (body.length > 0) {
        _body = [_body stringByReplacingOccurrencesOfString:@"<p>" withString:@""];
        _body = [_body stringByReplacingOccurrencesOfString:@"</p>" withString:@"\n"];
    }
    
}

@end
