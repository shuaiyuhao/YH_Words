//
//  YHMemoryController.m
//  YH_Words
//
//  Created by Yuhao on 2020/3/31.
//  Copyright © 2020 Vwidea. All rights reserved.
//

#import "YHMemoryController.h"
#import <PNChart.h>
#import "YHRememberLineApi.h"
#import "YHFuzzyLineApi.h"

@interface YHMemoryController ()<YTKRequestDelegate>

@property (nonatomic,strong) UILabel *memoryTitleLabel;

@property (nonatomic,strong) UILabel *fuzzyTitleLabel;

@property (nonatomic,strong) PNLineChart *memorizeLineChart;

@property (nonatomic,strong) PNLineChart *fuzzyLineChart;

@property (nonatomic,strong) YHRememberLineApi *rememberApi;
@property (nonatomic,strong) YHFuzzyLineApi *fuzzyApi;

@property (nonatomic,strong) NSArray *rememberArray;
@property (nonatomic,strong) NSArray *fuzzyArray;

@end

@implementation YHMemoryController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor colorWithHexString:@"0x171C24"]];
    self.navigationItem.title = @"记忆曲线";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    [self.view addSubview:self.memoryTitleLabel];
    [self.view addSubview:self.fuzzyTitleLabel];
    [self.view addSubview:self.memorizeLineChart];
    [self.view addSubview:self.fuzzyLineChart];
    
    [self layoutPageViews];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [self.rememberApi start];
    
    [self.fuzzyApi start];
}

- (void)layoutPageViews {
    [self.memoryTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(160, 30));
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset(30);
    }];
    
    [self.memorizeLineChart mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenWidth - 40, 180));
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.memoryTitleLabel.mas_bottom).offset(40);
    }];
    
    [self.fuzzyTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(160, 30));
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.memorizeLineChart.mas_bottom).offset(30);
    }];
    
    [self.fuzzyLineChart mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenWidth - 40, 180));
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.fuzzyTitleLabel.mas_bottom).offset(40);
    }];
}

#pragma mark - YTKRequestDelegate
#pragma mark -
- (void)requestFinished:(__kindof YTKBaseRequest *)request {
    id data = [(SFBaseApiRequest *)request fetchDataWithReformer:nil];
    
    if (![(SFBaseApiRequest *)request success]) {
        
        return;
    }
    
    if ([(SFBaseApiRequest *)request isKindOfClass:[YHRememberLineApi class]]) {
        self.rememberArray = data;
    }
    
    if ([(SFBaseApiRequest *)request isKindOfClass:[YHFuzzyLineApi class]]) {
        self.fuzzyArray = data;
    }
}

-(void)requestFailed:(__kindof YTKBaseRequest *)request {
    
}


#pragma mark - getter and setter
#pragma mark -
- (PNLineChart *)memorizeLineChart {
    if (!_memorizeLineChart) {
        _memorizeLineChart = [[PNLineChart alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth - 40, 180)];
        _memorizeLineChart.backgroundColor = [UIColor colorWithHexString:@"0x171C24"];
        [_memorizeLineChart setXLabelColor:[UIColor colorWithHexString:@"0xD66563"]];
        [_memorizeLineChart setXLabels:@[@"1",@"2",@"3",@"4",@"5",@"6",@"7"]];
        
        [_memorizeLineChart setYLabelColor:PNPinkDark];
        
        [_memorizeLineChart setAxisColor:[UIColor colorWithHexString:@"0xD66563"]];
        [_memorizeLineChart setAxisWidth:2.f];
        [_memorizeLineChart setShowCoordinateAxis:YES];
        
        NSArray *arr = @[@15,@16,@17,@17,@14,@10,@9];
        
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

- (PNLineChart *)fuzzyLineChart {
    if (!_fuzzyLineChart) {
        _fuzzyLineChart = [[PNLineChart alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth - 40, 180)];
        _fuzzyLineChart.backgroundColor = [UIColor colorWithHexString:@"0x171c24"];
        
        [_fuzzyLineChart setXLabelColor:[UIColor colorWithHexString:@"0xD66563"]];
        [_fuzzyLineChart setXLabels:@[@"1",@"2",@"3",@"4",@"5",@"6",@"7"]];
        
        [_fuzzyLineChart setYLabelColor:[UIColor colorWithHexString:@"0xD66563"]];
        
        [_fuzzyLineChart setAxisColor:[UIColor colorWithHexString:@"0xD66563"]];
        [_fuzzyLineChart setAxisWidth:2.f];
        [_fuzzyLineChart setShowCoordinateAxis:YES];
        
        NSArray *arr = @[@15,@16,@17,@17,@14,@10,@9];
        
        PNLineChartData *data = [PNLineChartData new];
        data.color = PNRed;
        data.itemCount = _memorizeLineChart.xLabels.count;
        data.inflexionPointStyle = PNLineChartPointStyleSquare;
        
        data.getData = ^PNLineChartDataItem *(NSUInteger item) {
            CGFloat yValue = [arr[item] floatValue];
            return [PNLineChartDataItem dataItemWithY:yValue];
        };
        _fuzzyLineChart.chartData = @[data];
        [_fuzzyLineChart strokeChart];
        _fuzzyLineChart.showSmoothLines = YES;
        
    }
    return _fuzzyLineChart;
}

- (UILabel *)memoryTitleLabel {
    if (!_memoryTitleLabel) {
        _memoryTitleLabel = UILabel.builder()
        .text(@"单词记忆曲线")
        .textAlignment(NSTextAlignmentCenter)
        .textColor([UIColor whiteColor])
        .font([UIFont systemFontOfSize:19])
        .build();
    }
    return _memoryTitleLabel;
}

- (UILabel *)fuzzyTitleLabel {
    if (!_fuzzyTitleLabel) {
        _fuzzyTitleLabel = UILabel.builder()
        .text(@"单词遗忘曲线")
        .textAlignment(NSTextAlignmentCenter)
        .textColor([UIColor whiteColor])
        .font([UIFont systemFontOfSize:19])
        .build();
    }
    return _fuzzyTitleLabel;
}

- (YHRememberLineApi *)rememberApi {
    if (!_rememberApi) {
        _rememberApi = [[YHRememberLineApi alloc] initWithUserId:[YHUserManager sharedManager].userId token:[YHUserManager sharedManager].token type:3];
        _rememberApi.delegate = self;
    }
    return _rememberApi;
}

- (YHFuzzyLineApi *)fuzzyApi {
    if (!_fuzzyApi) {
        _fuzzyApi = [[YHFuzzyLineApi alloc] initWithUserId:[YHUserManager sharedManager].userId token:[YHUserManager sharedManager].token type:2];
        _fuzzyApi.delegate = self;
    }
    return _fuzzyApi;
}
@end
