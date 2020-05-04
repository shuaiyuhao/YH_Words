//
//  YHMemoryController.m
//  YH_Words
//
//  Created by Yuhao on 2020/3/31.
//  Copyright © 2020 Vwidea. All rights reserved.
//

#import "YHMemoryController.h"
#import <PNChart.h>

@interface YHMemoryController ()

@property (nonatomic,strong) PNLineChart *memorizeLineChart;

@property (nonatomic,strong) PNLineChart *fuzzyLineChart;

@end

@implementation YHMemoryController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor colorWithHexString:@"0x171C24"]];
    self.navigationItem.title = @"记忆曲线";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    
    [self.view addSubview:self.memorizeLineChart];
    [self.view addSubview:self.fuzzyLineChart];
    
    [self layoutPageViews];
    
}

- (void)layoutPageViews {
    [self.memorizeLineChart mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenWidth - 40, 180));
        make.centerX.equalTo(self.view);
        
        make.top.equalTo(self.view).offset(40);
    }];
}

#pragma mark - getter and setter
#pragma mark -
- (PNLineChart *)memorizeLineChart {
    if (!_memorizeLineChart) {
        _memorizeLineChart = [[PNLineChart alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth - 40, 180)];
        _memorizeLineChart.backgroundColor = [UIColor colorWithHexString:@"0x171C24"];
        [_memorizeLineChart setXLabelColor:[UIColor colorWithHexString:@"0xD66563"]];
        [_memorizeLineChart setXLabels:@[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8"]];
        
        [_memorizeLineChart setYLabelColor:[UIColor colorWithHexString:@"0xD66563"]];
        
        [_memorizeLineChart setAxisColor:[UIColor colorWithHexString:@"0xD66563"]];
        [_memorizeLineChart setAxisWidth:2.f];
        [_memorizeLineChart setShowCoordinateAxis:YES];
        
        NSArray *arr = @[@15,@16,@17,@17,@14,@10,@9,@30];
        
        PNLineChartData *data = [PNLineChartData new];
        data.color = PNTwitterColor;
        data.itemCount = _memorizeLineChart.xLabels.count;
        data.inflexionPointStyle = PNLineChartPointStyleSquare;
        
        data.getData = ^PNLineChartDataItem *(NSUInteger item) {
            CGFloat yValue = [arr[item] floatValue];
            return [PNLineChartDataItem dataItemWithY:yValue];
        };
        
        _memorizeLineChart.chartData = @[data];
        [_memorizeLineChart strokeChart];
        _memorizeLineChart.showSmoothLines = YES;
    }
    return _memorizeLineChart;
}

@end
