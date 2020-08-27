//
//  SPGLSLDrawViewController.m
//  OpenGLESDemo
//
//  Created by 王杰 on 2020/8/27.
//  Copyright © 2020 SPPT. All rights reserved.
//

#import "SPGLSLDrawViewController.h"
#import "SPGLSLDrawView.h"

@interface SPGLSLDrawViewController ()

@end

@implementation SPGLSLDrawViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    SPGLSLDrawView *v = [[SPGLSLDrawView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:v];
}

@end
