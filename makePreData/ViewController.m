//
//  ViewController.m
//  makePreData
//
//  Created by hbucius on 10/16/14.
//  Copyright (c) 2014 hbucius. All rights reserved.
//

#import "ViewController.h"
#import "FirstNumber+Update.h"
#import "CurrencyShown+Update.h"
#import "CurrencyRate+Update.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    CurrencyRate *rate=[[CurrencyRate alloc]init];
 //   [FirstNumber updateFirstNumber:1998];
    NSArray *array=@[@"CNY",@"USD",@"EUR",@"HKD",@"JPY",@"KRW",@"GBP",@"TWD",@"MOP",@"CAD"];
    NSMutableDictionary *cocurrencyNameDic=[[NSMutableDictionary alloc]init];
    NSArray *array1=[[NSArray alloc] initWithObjects:@"CNY",@"人民币",@"USD",@"美元",@"HKD", @"港币",@"EUR", @"欧元", @"JPY",@"日元", @"GBP",@"英镑", @"TWD",@"新台币", nil];
    NSArray *array2=[[NSArray alloc]initWithObjects:@"MOP",@"澳门币",@"AUD",@"澳元",@"CAD",@"加拿大元",@"TWD",@"韩元",nil];
    NSArray *arrayAll=[[NSArray alloc]initWithObjects:array1,array2, nil];
    NSString *tempKey;
    for (int i=0; i<arrayAll.count; i++) {
        NSArray *tempArray=[arrayAll objectAtIndex:i];
        for (int j=0; j<tempArray.count; j++) {
            if(j%2==0) {
                tempKey=[tempArray objectAtIndex:j];
                continue;
            }
            else [cocurrencyNameDic setValue:[tempArray objectAtIndex:j] forKey:tempKey];
        }
    }
 //   [CurrencyShown  updateCurrencyShown:array];
  //  [rate updateInfo];
 //   sleep(3);
  //  [rate SaveFullNameWithdic:cocurrencyNameDic];
    NSLog(@"the first number is %d ",[FirstNumber getFirstNumber]);
   // sleep(6);
    NSLog(@"currency rate is %@",[rate getCurrencyRate]);

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
