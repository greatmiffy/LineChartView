//
//  FSLineChartController.m
//  ChartTest
//
//  Created by sensology on 2018/8/15.
//  Copyright © 2018年 sensology. All rights reserved.
//

#import "FSLineChartController.h"
#import "FSLineChart.h"

@interface FSLineChartController ()

@property (nonatomic, strong) FSLineChart *lineChart;

@end

@implementation FSLineChartController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self configCharts];
}

- (void)configCharts
{
    [self.view addSubview:self.lineChart];
    [self.lineChart setChartData:@[@5,@1,@13,@9,@33,@16,@230,@4,@17,@5,@1,@13,@9,@33,@16,@23,@4,@17]];
}

- (FSLineChart *)lineChart
{
    if (!_lineChart) {
        _lineChart = [[FSLineChart alloc]initWithFrame:CGRectMake(10, 200, 394, 200)];
        _lineChart.animationDuration = .0f;
        
    }
    return _lineChart;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
