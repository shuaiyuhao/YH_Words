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

static NSString * const wordCardCellId = @"YHWordCardCellId";

@interface YHWordController ()<QiCardViewDelegate, QiCardViewDataSource>

@property (nonatomic,strong) QiCardView *cardView;

@property (nonatomic,strong) NSArray<WordDataModel *> *datas;

@property (nonatomic,strong) UIButton *rememberButton;
@property (nonatomic,strong) UIButton *forgetButton;

@end

@implementation YHWordController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"YH Words";
    [self.view setBackgroundColor:[UIColor colorWithHexString:@"0x171C24"]];

    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
//    [self initDatas];
    [self.view addSubview:self.cardView];
    [self.view addSubview:self.rememberButton];
    [self.view addSubview:self.forgetButton];
    
    [self layoutPageViews];
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
#pragma mark - QiCardDataSource
#pragma mark -

- (QiCardViewCell *)cardView:(QiCardView *)cardView cellForRowAtIndex:(NSInteger)index {
    YHWordCardCell *cell = [cardView dequeueReusableCellWithIdentifier:wordCardCellId];

    [cell configWithData:self.datas[index]];

    cell.layer.cornerRadius = 10;
    cell.layer.masksToBounds = YES;

    return cell;

}

- (NSInteger)numberOfCountInCardView:(QiCardView *)cardView {
    return self.datas.count;
}

#pragma mark - QiCardDelegate
#pragma mark -
- (void)cardView:(QiCardView *)cardView didRemoveLastCell:(QiCardViewCell *)cell forRowAtIndex:(NSInteger)index {
    [cardView reloadDataAnimated:true];
}

- (void)cardView:(QiCardView *)cardView didRemoveCell:(QiCardViewCell *)cell forRowAtIndex:(NSInteger)index {
    NSLog(@"didRemoveCell forRowAtIndex = %ld", index);
    
    if ((cell.cardDirection == QiCardCellSwipeDirectionLeft)) {
        NSLog(@"left");
    }
    if (((cell.cardDirection == QiCardCellSwipeDirectionRight))) {
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
        _cardView.visibleCount = 4;
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


- (NSArray<WordDataModel *> *)datas {
    if (!_datas) {
        _datas = @[
            [[WordDataModel alloc] initWithDic:@{
                @"word":@"abandon",
                @"phonetic":@"/ə'bændən/",
                @"chinese":@"v./抛弃，舍弃，放弃",
                @"example":@"We had to abandon the car and walk the rest of the way."
            }],

            [[WordDataModel alloc] initWithDic:@{
                @"word":@"able",
                @"phonetic":@"/'eɪbəl/",
                @"chinese":@"a./能够；有能力的 be able to do",
                @"example":@"Will she be able to cope with the work?"
            }],

            [[WordDataModel alloc] initWithDic:@{
                @"word":@"abnormal",
                @"phonetic":@"/æb'nɔːməl US -'nɔːr-/",
                @"chinese":@"a./反常的，变态的",
                @"example":@"abnormal behaviour"
            }],

            [[WordDataModel alloc] initWithDic:@{
                @"word":@"abolish",
                @"phonetic":@"/ə'bɔlɪʃ US ə'bɑː-/",
                @"chinese":@"v./废除，废止",
                @"example":@"Slavery was abolished in the US in the 19th century."
            }],

            [[WordDataModel alloc] initWithDic:@{
                @"word":@"about",
                @"phonetic":@"/ə'baut/",
                @"chinese":@"ad./大约；到处；四处# prep./关于；在各处；四处 ",
                @"example":@"We're about (= almost) ready to leave"
            }],

            [[WordDataModel alloc] initWithDic:@{
                @"word":@"absent",
                @"phonetic":@"/'æbsənt/",
                @"chinese":@"a./缺席，不在",
                @"example":@"`Nothing,' Rosie said in an absent way."
            }]


        ];
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
//- (void)initDatas {
//    _datas = @[
//               [[WordDataModel alloc] initWithDic:@{
//                   @"word":@"abandon",
//                   @"phonetic":@"/ə'bændən/",
//                   @"chinese":@"v./抛弃，舍弃，放弃",
//                   @"example":@"We had to abandon the car and walk the rest of the way."
//               }],
//
//               [[WordDataModel alloc] initWithDic:@{
//                   @"word":@"able",
//                   @"phonetic":@"/'eɪbəl/",
//                   @"chinese":@"a./能够；有能力的 be able to do",
//                   @"example":@"Will she be able to cope with the work?"
//               }],
//
//               [[WordDataModel alloc] initWithDic:@{
//                   @"word":@"abnormal",
//                   @"phonetic":@"/æb'nɔːməl US -'nɔːr-/",
//                   @"chinese":@"a./反常的，变态的",
//                   @"example":@"abnormal behaviour"
//               }],
//
//               [[WordDataModel alloc] initWithDic:@{
//                   @"word":@"abolish",
//                   @"phonetic":@"/ə'bɔlɪʃ US ə'bɑː-/",
//                   @"chinese":@"v./废除，废止",
//                   @"example":@"Slavery was abolished in the US in the 19th century."
//               }],
//
//               [[WordDataModel alloc] initWithDic:@{
//                   @"word":@"about",
//                   @"phonetic":@"/ə'baut/",
//                   @"chinese":@"ad./大约；到处；四处# prep./关于；在各处；四处 ",
//                   @"example":@"We're about (= almost) ready to leave"
//               }],
//
//               [[WordDataModel alloc] initWithDic:@{
//                   @"word":@"absent",
//                   @"phonetic":@"/'æbsənt/",
//                   @"chinese":@"a./缺席，不在",
//                   @"example":@"`Nothing,' Rosie said in an absent way."
//               }]
//
//
//           ];
//}
@end
