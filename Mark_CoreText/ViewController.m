//
//  ViewController.m
//  Mark_CoreText
//
//  Created by Mark on 2016/12/8.
//  Copyright © 2016年 Mark. All rights reserved.
//

#import "ViewController.h"
#import "MJsonModel.h"
#import "MParserConfig.h"
#import "MDisplayView.h"
#import <CoreText/CoreText.h>
@interface ViewController ()
@property (weak, nonatomic) IBOutlet MDisplayView *disPlayView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *height;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    MJsonModel *jsonModel = [MJsonModel jsonModelCreateLocalPath];
    
    MParserConfig *config = [MParserConfig attributeStringWithJsonModel:jsonModel withBouns:_disPlayView.bounds];
    _disPlayView.config = config;
    self.height.constant = [config frameSetterHeightWithWidth:CGRectGetWidth(self.disPlayView.bounds)];;
    [self.view setNeedsLayout];
    
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
