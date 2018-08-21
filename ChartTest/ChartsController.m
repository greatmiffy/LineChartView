//
//  ChartsController.m
//  ChartTest
//
//  Created by sensology on 2018/8/15.
//  Copyright © 2018年 sensology. All rights reserved.
//

#import "ChartsController.h"
#import <Charts/Charts.h>

#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width
#define SCREENHEIGHT [UIScreen mainScreen].bounds.size.height
#define RGB(r, g, b)  [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

@interface ChartsController ()<LineChartDataProvider, ChartViewDelegate>

@property (nonatomic, strong) LineChartView *lineChart;

@end

@implementation ChartsController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.lineChart];
    [self setData];
}

- (void)setData
{
    //    _lineChart.xAxis.valueFormatter = [[ChartIndexAxisValueFormatter alloc] initWithValues:@[@"20180101", @"20180201"]];
    NSArray *dArr = @[@5, @8,@3, @12, @1, @3, @9, @0, @19, @5, @8,@3, @12, @1, @3, @9, @0, @19];
    NSMutableArray *yVals = [[NSMutableArray alloc] init];
    for (int i = 0; i < dArr.count; i++) {
        
        //        BTCTrenddata *dotData = (BTCTrenddata *)[self.financeLineDotDataList objectAtIndex:i];
        //将横纵坐标以ChartDataEntry的形式保存下来，注意横坐标值一般是i的值，而不是你的数据    //里面具体的值，如何将具体数据展示在X轴上我们下面将会说到。
        ChartDataEntry *entry = [[ChartDataEntry alloc] initWithX:i y:[dArr[i] integerValue]];
        [yVals addObject:entry];
    }
    
    LineChartDataSet *set = [[LineChartDataSet alloc] initWithValues:yVals];
    set.mode = 2;
    set.drawFilledEnabled = YES;
    set.drawCirclesEnabled = NO;
    set.highlightEnabled = NO;
    NSArray *gradientColors = @[(id)RGB(246,252,254).CGColor,
                                (id)RGB(223,244,251).CGColor];
    CGGradientRef gradientRef = CGGradientCreateWithColors(nil, (CFArrayRef)gradientColors, nil);
    set.fillAlpha = 1.0f;//透明度
    set.fill = [ChartFill fillWithLinearGradient:gradientRef angle:90.0f];//赋值填充颜色对象
    CGGradientRelease(gradientRef);//释放gradientRef
    
    NSMutableArray *dataSets = [[NSMutableArray alloc] init];
    [dataSets addObject:set];
    
    LineChartData *d = [[LineChartData alloc]initWithDataSets:dataSets];
    self.lineChart.data = d;
    [self.lineChart animateWithXAxisDuration:1.0f];
    
    //X 轴
    self.lineChart.xAxis.labelPosition = XAxisLabelPositionBottom;
    self.lineChart.xAxis.drawLimitLinesBehindDataEnabled = NO;
    
    // 限制线
    ChartLimitLine *limit = [[ChartLimitLine alloc] initWithLimit:15];
    limit.lineWidth = .5f;
    limit.lineColor = RGB(237, 85, 101);
    limit.lineDashLengths = @[@4,@2];
    [self.lineChart.leftAxis addLimitLine:limit];
    
}

- (LineChartView *)lineChart
{
    if (!_lineChart) {
        _lineChart = [[LineChartView alloc] initWithFrame:CGRectMake(0, 250, SCREENWIDTH, 200)];
        _lineChart.dragEnabled = YES;
        _lineChart.rightAxis.enabled = NO;  //隐藏右Y轴
        _lineChart.chartDescription.enabled = NO; //不显示描述label
        _lineChart.legend.enabled = NO;
        _lineChart.doubleTapToZoomEnabled = NO;  //禁止双击缩放
        _lineChart.drawBordersEnabled= NO;
        _lineChart.dragYEnabled = NO;
        _lineChart.dragEnabled = YES;  //拖动气泡
        [_lineChart animateWithXAxisDuration:2.2 easingOption:ChartEasingOptionEaseOutBack];// 动画
        
    }
    return _lineChart;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
