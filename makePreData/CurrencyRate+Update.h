//
//  CurrencyRate+Update.h
//  makePreData
//
//  Created by hbucius on 10/16/14.
//  Copyright (c) 2014 hbucius. All rights reserved.
//

#import "CurrencyRate.h"
#import "Context.h"
@interface CurrencyRate (Update)
-(void) updateInfo;
-(NSArray *) getCurrencyRate;
-(void) SaveFullNameWithdic:(NSDictionary*)dic;



@end
