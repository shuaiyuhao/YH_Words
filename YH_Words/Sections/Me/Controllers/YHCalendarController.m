//
//  YHCalendarController.m
//  YH_Words
//
//  Created by Yuhao Shuai on 2020/5/9.
//  Copyright © 2020 Vwidea. All rights reserved.
//

#import "YHCalendarController.h"
#import <FSCalendar.h>
#import <EventKit/EventKit.h>
#import "LunarFormatter.h"
#import "SFHUD.h"

@interface YHCalendarController ()<FSCalendarDelegate,FSCalendarDataSource>

@property (nonatomic,strong) FSCalendar *calendar;

@property (nonatomic,strong) UIImageView *calendarBackView;

@property (nonatomic,strong) UIButton *signButton;

@property (nonatomic,assign) NSInteger count;

@property (assign, nonatomic) NSInteger SignCount;
@property (strong, nonatomic) NSDateFormatter *dateFormatter;
@property (strong, nonatomic) NSDate *minimumDate;
@property (strong, nonatomic) NSDate *maximumDate;
@property (strong, nonatomic) NSCache *cache;
@property (assign, nonatomic) BOOL showsLunar;
@property (assign, nonatomic) BOOL showsEvents;

@property (strong, nonatomic) NSArray<EKEvent *> *events;

@property (strong, nonatomic) NSMutableArray *signInList;

@property (strong,nonatomic) NSString *dateStr;
@property (strong, nonatomic) NSCalendar *gregorian;
@property (strong, nonatomic) LunarFormatter *lunarFormatter;

@end

@implementation YHCalendarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"签到日历";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    [self.view setBackgroundColor:[UIColor colorWithHexString:@"0x171C24"]];
    
    
    
    [self.view insertSubview:self.calendarBackView atIndex:1];
    [self.view addSubview:self.calendar];
    [self.view addSubview:self.signButton];
    
    //日历配置
    [self calendarConfig];
    //1.加载缓存的日期,并选中
    [self getCache];
    //2.从网络获取其签到结果,如果发现请求的结果中存在没有被选中,就将其选中,并加载到缓存中
    [self getSign];
    
    [self layoutPageViews];
}

- (void)layoutPageViews {
    [self.calendar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset(40);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth - 50, 300));
    }];
    
    [self.calendarBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth - 20, 345));
        make.top.equalTo(self.view).offset(20);
    }];

    [self.signButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.calendarBackView.mas_bottom).offset(30);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth - 80, 40));
    }];
}

//加载缓存
- (void)getCache {
    //从缓存中先把数据取出来
    NSString *key = [NSString stringWithFormat:@"arrayDate"];
    NSMutableArray *cache = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    //允许用户选择,其实是允许系统来选中签到日期
    self.calendar.allowsSelection = YES;
    self.calendar.allowsMultipleSelection = YES;
    if (cache.count) {//如果cache里面有数据
        //选中日期,只有不在选中之列的才去选中它
        for (NSInteger i = 0; i<cache.count; i++) {
            if (![self.calendar.selectedDates containsObject:cache[i]]) {
                [self.calendar selectDate:cache[i]];
            }
        }
    }else{//如果cache里面没有数据,说明第一次启动
        //创建个可变数组储存进缓存(必要)
        NSMutableArray *cache = [NSMutableArray array];
        [[NSUserDefaults standardUserDefaults] setValue:cache forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    //选择完毕后关闭可选项,不让用户自己点
    self.calendar.allowsSelection = NO;
}

//点击签到按钮的Action
- (void)signInAction {
    //假设在这里网络请求签到成功,成功后需要重新请求签到所有结果
    if (_count>31) {
        NSLog(@"别点了");
        return;
    }else if (!_count){
        _count = 1;
    }
    
    NSDate *nowdate = [NSDate now];
    
    
    
    NSString *dateStr = [self.dateFormatter stringFromDate:nowdate];
    _count++;
    
    if (self.signInList.count == 0) {
        [self.signInList addObject:dateStr];
    } else if ([dateStr isEqualToString:self.signInList[self.signInList.count - 1]]) {
        [SFHUD showToast:@"你已经签过到了！"];
    } else {
        [self.signInList addObject:dateStr];
    }
    
    [self getSign];
}

//从网络获取所有签到结果
- (void)getSign {
    //配置日期缓存的key
    NSString *key = [NSString stringWithFormat:@"arrayDate"];
    
    //在这里假装网络请求所有的签到结果(signInList)成功了
    NSLog(@"%@",_signInList);
    //获取签到总数量
    self.SignCount = _signInList.count;
    //常见临时数组dataArrayCache,用于存放签到结果(可能有的人觉得这一步不需要,但是咱们假设的签到结果里面只有纯日期,正式项目中可不一定如此)
    NSMutableArray *dataArrayCache = [NSMutableArray array];
    
    if (self.SignCount) {//如果请求的数据有效
        for (NSString *dateStr in _signInList) {
            //把所有签到数据取出来添加进临时数组
            NSDate *date = [self.dateFormatter dateFromString:dateStr];
            if(date){
                [dataArrayCache addObject:date];
            }
        }
        //用偏好设置保存签到数据到本地缓存
        [[NSUserDefaults standardUserDefaults] setValue:dataArrayCache forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
        //保存后重新加载缓存数据
        [self getCache];
    }
}

+(NSArray *)getStartTimeAndFinalTime {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *datenow = [NSDate date];
    NSString *currentTimeString = [formatter stringFromDate:datenow];
    NSDate *newDate=[formatter dateFromString:currentTimeString];
    double interval = 0;
    NSDate *firstDate = nil;
    NSDate *lastDate = nil;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    BOOL OK = [calendar rangeOfUnit:NSCalendarUnitMonth startDate:& firstDate interval:&interval forDate:newDate];
    if (OK) {
        lastDate = [firstDate dateByAddingTimeInterval:interval - 1];
    }else {
        return @[@"",@""];
    }
    NSString *firstString = [formatter stringFromDate: firstDate];
    NSString *lastString = [formatter stringFromDate: lastDate];
    //返回数据为日历要显示的最小日期firstString和最大日期lastString
    return @[firstString, lastString];
}

#pragma mark - <配置日历>
- (void)calendarConfig {
    //创建系统日历类
       self.gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
       //获取日历要显示的日期范围
       NSArray *timeArray = [YHCalendarController getStartTimeAndFinalTime];
       self.dateStr = [timeArray[0] substringToIndex:7];
       //设置最小和最大日期(在最小和最大日期之外的日期不能被选中,日期范围如果大于一个月,则日历可翻动)
       self.minimumDate = [self.dateFormatter dateFromString:timeArray[0]];
       self.maximumDate = [self.dateFormatter dateFromString:timeArray[1]];
       self.calendar.accessibilityIdentifier = @"calendar";
       //title显示方式
       self.calendar.appearance.headerDateFormat = @"yyyy年MM月";
       //关闭字体自适应,设置字体大小\颜色
       self.calendar.appearance.subtitleFont = [UIFont systemFontOfSize:8];
       self.calendar.appearance.headerTitleColor = [UIColor whiteColor];
       self.calendar.appearance.weekdayTextColor = [UIColor whiteColor];
       self.calendar.appearance.selectionColor = [UIColor orangeColor];
       //日历头部颜色
       self.calendar.calendarHeaderView.backgroundColor = [UIColor colorWithRed:235/255.0f green:91/255.0f blue:87/255.0f alpha:1];
       self.calendar.calendarWeekdayView.backgroundColor = [UIColor colorWithRed:235/255.0f green:91/255.0f blue:87/255.0f alpha:1];
       //载入节假日
       [self loadCalendarEvents];
       //显示农历
       [self lunarItemClicked];
       //显示节假日
       [self eventItemClicked];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    //清除缓存
    NSString *key = [NSString stringWithFormat:@"arrayDate"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
}

- (void)dealloc {
    NSLog(@"%s",__FUNCTION__);
}

#pragma mark - Target actions
//显示农历
- (void)lunarItemClicked
{
    self.showsLunar = !self.showsLunar;
    [self.calendar reloadData];
}
//显示节日
- (void)eventItemClicked
{
    self.showsEvents = !self.showsEvents;
    [self.calendar reloadData];
}

#pragma mark - FSCalendarDataSource
//日期范围(最小)
- (NSDate *)minimumDateForCalendar:(FSCalendar *)calendar
{
    return self.minimumDate;
}
//日期范围(最大)
- (NSDate *)maximumDateForCalendar:(FSCalendar *)calendar
{
    return self.maximumDate;
}
//数据源方法,根据是否显示节日和农历
- (NSString *)calendar:(FSCalendar *)calendar subtitleForDate:(NSDate *)date
{
    if (self.showsEvents) {//如果要求显示节日
        EKEvent *event = [self eventsForDate:date].firstObject;
        if (event) {
            return event.title;
        }
    }
    if (self.showsLunar) {//如果要求显示农历
        return [self.lunarFormatter stringFromDate:date];
    }
    return nil;
}

#pragma mark - FSCalendarDelegate
//手动选中了某个日期(本项目暂时被隐藏)
- (void)calendar:(FSCalendar *)calendar didSelectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition
{
    NSLog(@"did select %@",[self.dateFormatter stringFromDate:date]);
}
//当前页被改变,日历翻动时调用(本项目暂时没用到)
- (void)calendarCurrentPageDidChange:(FSCalendar *)calendar
{
    NSLog(@"did change page %@",[self.dateFormatter stringFromDate:calendar.currentPage]);
}
//返回节日数量
- (NSInteger)calendar:(FSCalendar *)calendar numberOfEventsForDate:(NSDate *)date
{
    if (!self.showsEvents) return 0;
    if (!self.events) return 0;
    NSArray<EKEvent *> *events = [self eventsForDate:date];
    return events.count;
}
//calendar的events的偏好设置
- (NSArray<UIColor *> *)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance eventDefaultColorsForDate:(NSDate *)date
{
    if (!self.showsEvents) return nil;//如果不允许显示节日
    if (!self.events) return nil;     //如果当前日期范围内根本没有节日
    //根据日期来获取事件数组
    NSArray<EKEvent *> *events = [self eventsForDate:date];
    NSMutableArray<UIColor *> *colors = [NSMutableArray arrayWithCapacity:events.count];
    //遍历事件,设置事件文字颜色
    [events enumerateObjectsUsingBlock:^(EKEvent * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [colors addObject:[UIColor colorWithCGColor:obj.calendar.CGColor]];
    }];
    return colors.copy;
}

#pragma mark - Private methods
//加载节日到日历中
- (void)loadCalendarEvents {
    __weak typeof(self) weakSelf = self;
    EKEventStore *store = [[EKEventStore alloc] init];
    //请求访问日历
    [store requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
        //允许访问
        if(granted) {
            NSDate *startDate = self.minimumDate;
            NSDate *endDate = self.maximumDate;
            NSPredicate *fetchCalendarEvents = [store predicateForEventsWithStartDate:startDate endDate:endDate calendars:nil];
            NSArray<EKEvent *> *eventList = [store eventsMatchingPredicate:fetchCalendarEvents];
            NSArray<EKEvent *> *events = [eventList filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(EKEvent * _Nullable event, NSDictionary<NSString *,id> * _Nullable bindings) {
                return event.calendar.subscribed;
            }]];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                if (!weakSelf) return;
                weakSelf.events = events;
                [weakSelf.calendar reloadData];
            });
            
        } else {
            
            // Alert
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"权限错误" message:@"获取节日事件需要权限呀大宝贝!" preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil]];
            [self presentViewController:alertController animated:YES completion:nil];
        }
    }];
    
}
//根据日期来显示事件
- (NSArray<EKEvent *> *)eventsForDate:(NSDate *)date {
    NSArray<EKEvent *> *events = [self.cache objectForKey:date];
    if ([events isKindOfClass:[NSNull class]]) {
        return nil;
    }
    NSArray<EKEvent *> *filteredEvents = [self.events filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(EKEvent * _Nullable evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
        return [evaluatedObject.occurrenceDate isEqualToDate:date];
    }]];
    if (filteredEvents.count) {
        [self.cache setObject:filteredEvents forKey:date];
    } else {
        [self.cache setObject:[NSNull null] forKey:date];
    }
    return filteredEvents;
}


#pragma mark - getter and setter
#pragma mark -
- (FSCalendar *)calendar {
    if (!_calendar) {
        _calendar = [[FSCalendar alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth - 50, 300)];
        _calendar.backgroundColor = [UIColor whiteColor];
        _calendar.locale = [NSLocale localeWithLocaleIdentifier:@"zh-CN"];
        
        _calendar.allowsMultipleSelection = YES;
        _calendar.firstWeekday = 1;
        _calendar.appearance.caseOptions = FSCalendarCaseOptionsWeekdayUsesSingleUpperCase|FSCalendarCaseOptionsHeaderUsesUpperCase;
        
        _calendar.dataSource = self;
        _calendar.delegate = self;
    }
    return _calendar;
}

- (UIImageView *)calendarBackView {
    if (!_calendarBackView) {
        _calendarBackView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"calendarback"]];
        _calendarBackView.frame = CGRectMake(0, 0, kScreenWidth - 20, 345);
    }
    return _calendarBackView;
}

- (UIButton *)signButton {
    if (!_signButton) {
        _signButton = UIButton.builder()
        .title(@"签到")
        .titleColor([UIColor whiteColor])
        .backgroundColor([UIColor redColor])
        .build();
        
        [self toCornradius:5 with:_signButton];
        _signButton.clipsToBounds = YES;
        
        [self.signButton sf_addHandler:^(id weakSender) {
            [self signInAction];
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _signButton;
}

- (NSMutableArray *)signInList{
    if (!_signInList) {
        _signInList = [NSMutableArray array];
    }
    return _signInList;
}

- (LunarFormatter *)lunarFormatter{
    if (!_lunarFormatter) {
        _lunarFormatter = [[LunarFormatter alloc] init];
    }
    return _lunarFormatter;
}

- (NSDateFormatter *)dateFormatter{
    if (!_dateFormatter) {
        _dateFormatter = [[NSDateFormatter alloc]init];
        _dateFormatter.dateFormat = @"yyyy-MM-dd";
    }
    return _dateFormatter;
}

@end
