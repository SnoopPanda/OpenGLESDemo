//
//  ViewController.m
//  OpenGLESDemo
//
//  Created by 王杰 on 2020/8/27.
//  Copyright © 2020 SPPT. All rights reserved.
//

#import "SPMenuViewController.h"
#import "SPDrawImageViewController.h"
#import "SPGLSLDrawViewController.h"

@interface SPMenuViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *menuList;
@property (nonatomic, strong) NSArray *dataArray;
@end

@implementation SPMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.menuList];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
        {
            SPDrawImageViewController *vc = [[SPDrawImageViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 1:
        {
            SPGLSLDrawViewController *vc = [[SPGLSLDrawViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
            
        default:
            break;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = self.dataArray[indexPath.row];
    return cell;
}

#pragma mark -

- (UITableView *)menuList {
    if (!_menuList) {
        _menuList = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        [_menuList registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        _menuList.delegate = self;
        _menuList.dataSource = self;
    }
    return _menuList;
}

- (NSArray *)dataArray {
    if (!_dataArray) {

        _dataArray = @[
            @"GLKBaseEffect绘制图片到屏幕",
            @"GLSL绘制图片到屏幕"
        ];
    }
    return _dataArray;
}

@end
