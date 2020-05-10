//
//  YHWordController.m
//  YH_Words
//
//  Created by Yuhao on 2020/3/31.
//  Copyright © 2020 Vwidea. All rights reserved.
//

#import "YHWordController.h"
#import "QiCardView.h"
#import "YHWordCardCell.h"
#import "WordDataModel.h"
#import "YHStudyWordsListApi.h"
#import <YYModel.h>
#import "YHMarkWordsApi.h"
#import <iflyMSC/iflyMSC.h>

static NSString * const wordCardCellId = @"YHWordCardCellId";

static NSInteger pageNumber = 0;

@interface YHWordController ()<QiCardViewDelegate, QiCardViewDataSource, YTKRequestDelegate, YHWordCardCellDelegate, IFlySpeechSynthesizerDelegate>

@property (nonatomic,strong) QiCardView *cardView;

@property (nonatomic,strong) YHStudyWordsListApi *listApi;

@property (nonatomic,strong) NSMutableArray<WordDataModel *> *datas;

@property (nonatomic,strong) UIButton *rememberButton;
@property (nonatomic,strong) UIButton *forgetButton;

@property (nonatomic, strong) IFlySpeechSynthesizer * iFlySpeechSynthesizer;

@end

@implementation YHWordController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"YH Words";
    [self.view setBackgroundColor:[UIColor colorWithHexString:@"0x171C24"]];

    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [self.listApi start];
    [self.view addSubview:self.cardView];
    [self.view addSubview:self.rememberButton];
    [self.view addSubview:self.forgetButton];
    
    [self layoutPageViews];
    
    //
     [[IFlySpeechUtility getUtility] setParameter:@"tts" forKey:[IFlyResourceUtil ENGINE_START]];
     _iFlySpeechSynthesizer = [IFlySpeechSynthesizer sharedInstance];
     _iFlySpeechSynthesizer.delegate = self;
     [_iFlySpeechSynthesizer setParameter:[IFlySpeechConstant TYPE_LOCAL] forKey:[IFlySpeechConstant ENGINE_TYPE]];
     [_iFlySpeechSynthesizer setParameter:@"xiaoyan" forKey:[IFlySpeechConstant VOICE_NAME]];
     NSString *resPath = [[NSBundle mainBundle] resourcePath];
     NSString *vcnResPath = [[NSString alloc] initWithFormat:@"%@/aisound/common.jet;%@/aisound/xiaoyan.jet",resPath,resPath];
     [_iFlySpeechSynthesizer setParameter:vcnResPath forKey:@"tts_res_path"];
    
}


- (void)layoutPageViews {
    [self.cardView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(self.view.frame.size.width - 50.0, 460));
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset(50);
    }];
    
    [self.rememberButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(60, 60));
        make.left.equalTo(self.view).offset(37);
        make.top.equalTo(self.cardView.mas_bottom).offset(24);
    }];
    
    [self.forgetButton mas_makeConstraints:^(MASConstraintMaker *make) {
          make.size.mas_equalTo(CGSizeMake(60, 60));
          make.right.equalTo(self.view).offset(-37);
          make.top.equalTo(self.cardView.mas_bottom).offset(24);
      }];
}

#pragma mark - YHWordCardCellDelegate
- (void)cardViewCell:(YHWordCardCell *)cell soundText:(NSString *)text {
    if (text) {
        [_iFlySpeechSynthesizer startSpeaking:text];
    }
}

#pragma mark - YTKRequestDelegate
#pragma mark -
- (void)requestFinished:(__kindof YTKBaseRequest *)request {
    id obj = request.responseObject;
    id data = [(SFBaseApiRequest *)request fetchDataWithReformer:nil];
    
    if (![(SFBaseApiRequest *)request success]) {
        NSLog(@"获取单词错误");
        return;
    }
    
    if ([(SFBaseApiRequest *)request isKindOfClass:[YHStudyWordsListApi class]]) {
        NSLog(@"%@",data);
        NSArray *array = [NSArray yy_modelArrayWithClass:[WordDataModel class] json:data];
        
        self.datas = [NSMutableArray arrayWithArray:array];
        [self.cardView reloadData];
    }
    
}

- (void)requestFailed:(__kindof YTKBaseRequest *)request {
    return;
}

#pragma mark - QiCardDataSource
#pragma mark -

- (QiCardViewCell *)cardView:(QiCardView *)cardView cellForRowAtIndex:(NSInteger)index {
    YHWordCardCell *cell = [cardView dequeueReusableCellWithIdentifier:wordCardCellId];

    [cell configWithData:self.datas[index]];

    cell.layer.cornerRadius = 10;
    cell.layer.masksToBounds = YES;
    cell.delegate = self;

    return cell;

}

- (NSInteger)numberOfCountInCardView:(QiCardView *)cardView {
    return self.datas.count;
}

#pragma mark - QiCardDelegate
#pragma mark -
- (void)cardView:(QiCardView *)cardView didRemoveLastCell:(QiCardViewCell *)cell forRowAtIndex:(NSInteger)index {
    pageNumber += 1;
    
    YHStudyWordsListApi *api = [[YHStudyWordsListApi alloc] initWithPage:pageNumber row:5 token:[YHUserManager sharedManager].token userId:[YHUserManager sharedManager].userId];
    api.delegate = self;
    [api start];
    
    [cardView reloadDataAnimated:true];
}

- (void)cardView:(QiCardView *)cardView didRemoveCell:(QiCardViewCell *)cell forRowAtIndex:(NSInteger)index {
    NSLog(@"didRemoveCell forRowAtIndex = %ld", index);
    WordDataModel *model = self.datas[index];
    
    if ((cell.cardDirection == QiCardCellSwipeDirectionLeft)) {
        YHMarkWordsApi *api = [[YHMarkWordsApi alloc] initWithType:3 token:[YHUserManager sharedManager].token userId:[YHUserManager sharedManager].userId wordId:model.wordId];
        api.delegate = self;
        [api start];
        NSLog(@"left");
    }
    if (((cell.cardDirection == QiCardCellSwipeDirectionRight))) {
        YHMarkWordsApi *api = [[YHMarkWordsApi alloc] initWithType:2 token:[YHUserManager sharedManager].token userId:[YHUserManager sharedManager].userId wordId:model.wordId];
        api.delegate = self;
        [api start];
        
        NSLog(@"right");
    }
}

- (void)cardView:(QiCardView *)cardView didDisplayCell:(QiCardViewCell *)cell forRowAtIndex:(NSInteger)index {

//    NSLog(@"didDisplayCell forRowAtIndex = %ld", index);

//    NSLog(@"currentFirstIndex = %ld",cardView.currentFirstIndex);
//    NSLog(@"%ld",index);
}

- (void)cardView:(QiCardView *)cardView didMoveCell:(QiCardViewCell *)cell forMovePoint:(CGPoint)point {
//    NSLog(@"move point = %@", NSStringFromCGPoint(point));
}

#pragma mark - getter and setter
#pragma mark -
- (QiCardView *)cardView {
    if (!_cardView) {
        _cardView = [[QiCardView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width - 50.0, 420.0)];
        _cardView.backgroundColor = [UIColor colorWithHexString:@"0x171C24"];
        _cardView.visibleCount = 5;
        _cardView.lineSpacing = 15.0;
        _cardView.interitemSpacing = 10.0;
        _cardView.maxAngle = 10.0;
        _cardView.isAlpha = YES;
        _cardView.maxRemoveDistance = 100.0;
        _cardView.layer.cornerRadius = 10.0;
        _cardView.dataSource = self;
        _cardView.delegate = self;

         [_cardView registerClass:[YHWordCardCell class] forCellReuseIdentifier:wordCardCellId];
    }

    return _cardView;
}


- (NSMutableArray<WordDataModel *> *)datas {
    if (!_datas) {
        _datas = [NSMutableArray new];
        
    }
    return _datas;
}

- (UIButton *)rememberButton {
    if (!_rememberButton) {
        _rememberButton = UIButton.builder()
        .title(@"")
        .image([UIImage imageNamed:@"btn_remember"])
        .build();
        
//        [_rememberButton setImagePosition:SFImagePositionTop spacing:0];
        WeakSelf;
        [_rememberButton sf_addHandler:^(id weakSender) {
            [weakSelf.cardView removeTopCardViewFromSwipe:QiCardCellSwipeDirectionLeft];
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _rememberButton;
}

- (UIButton *)forgetButton {
    if (!_forgetButton) {
        _forgetButton = UIButton.builder()
        .title(@"")
        .image([UIImage imageNamed:@"btn_forget"])
        .build();
        
        WeakSelf;
        [_forgetButton sf_addHandler:^(id weakSender) {
            [weakSelf.cardView removeTopCardViewFromSwipe:QiCardCellSwipeDirectionRight];
        } forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _forgetButton;
}

- (YHStudyWordsListApi *)listApi {
    if (!_listApi) {
        pageNumber += 1;
        _listApi = [[YHStudyWordsListApi alloc] initWithPage:pageNumber row:5 token:[YHUserManager sharedManager].token userId:[YHUserManager sharedManager].userId];
        _listApi.delegate = self;
    }
    return _listApi;
}
@end
