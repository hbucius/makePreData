//
//  CurrencyRate.h
//  makePreData
//
//  Created by hbucius on 10/16/14.
//  Copyright (c) 2014 hbucius. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface CurrencyRate : NSManagedObject

@property (nonatomic, retain) NSString * fullname;
@property (nonatomic, retain) NSNumber * rate;
@property (nonatomic, retain) NSString * shortname;
@property (nonatomic,strong) NSDictionary *currencyDic;

@end
