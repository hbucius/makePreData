//
//  CurrencyRate+Update.m
//  makePreData
//
//  Created by hbucius on 10/16/14.
//  Copyright (c) 2014 hbucius. All rights reserved.
//

#import "CurrencyRate+Update.h"
NSString * yahoolURL=@"http://finance.yahoo.com/webservice/v1/symbols/allcurrencies/quote?format=json&";

@interface CurrencyRate ()
- (NSDictionary *) getDicFromObject :(NSData *) data;
-(void) saveToContext2;
@end



@implementation CurrencyRate (Update)


- (void) updateInfo {
    dispatch_queue_t queue=dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        NSURLSessionDataTask *dataTask=[[NSURLSession sharedSession] dataTaskWithURL:[NSURL URLWithString:yahoolURL] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            NSString *string =[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"the data is %@",string);
            NSLog(@"the data 's address is %@",data);
            self.currencyDic=[self getDicFromObject:data];
            [self saveToContext2];
        }];
        [dataTask resume];
        
    });
    
}

-(void) saveToContext2{
    
    NSEntityDescription *entity=[NSEntityDescription entityForName:@"CurrencyRate" inManagedObjectContext:[Context context]];
    NSFetchRequest *request=[[NSFetchRequest alloc]init];
    [request setEntity:entity];
    for (NSString *key in self.currencyDic) {
        NSPredicate *predict=[NSPredicate predicateWithFormat:@"shortname=%@",key];
        [request setPredicate:predict];
        NSError *error;
        NSArray *array=[[Context context]executeFetchRequest:request error:&error];
        if (array.count>=1) {
            CurrencyRate *currencyRate=array[0];
            currencyRate.rate=[self.currencyDic valueForKey:key];
        }
        else{
            CurrencyRate *rate2=[NSEntityDescription insertNewObjectForEntityForName:@"CurrencyRate" inManagedObjectContext:[Context context]];
            rate2.shortname=key;
            rate2.rate=self.currencyDic[key];
        }
    }
    [[Context delegate]saveContext];
}

-(void) SaveFullNameWithdic:(NSDictionary*)dic{
    
    NSEntityDescription *entity=[NSEntityDescription entityForName:@"CurrencyRate" inManagedObjectContext:[Context context]];
    NSFetchRequest *request=[[NSFetchRequest alloc]init];
    [request setEntity:entity];
    for (NSString *key in dic) {
        NSPredicate *predict=[NSPredicate predicateWithFormat:@"shortname=%@",key];
        [request setPredicate:predict];
        NSError *error;
        NSArray *array=[[Context context]executeFetchRequest:request error:&error];
        if (array.count>=1) {
            CurrencyRate *currencyRate=array[0];
            currencyRate.fullname=[self.currencyDic valueForKey:key];
        }
       
    }
    [[Context delegate]saveContext];
    
}

- (NSDictionary *) getDicFromObject: (NSData *) data{
    NSError * error2;
    NSMutableDictionary *mutableDiction=[[NSMutableDictionary alloc]init];
    id jsonObject= [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error2];
    if([jsonObject isKindOfClass:[NSDictionary class]]) {
        NSDictionary * dictionary =(NSDictionary *) jsonObject;
        id mdic=[dictionary valueForKey:@"list"];
        if([mdic isKindOfClass:[NSDictionary class]])
        {
            id resourceArray=[(NSDictionary*)mdic valueForKey:@"resources"];
            
            if([resourceArray isKindOfClass:[NSArray class]]){
                NSArray *array=(NSArray *)resourceArray;
                //NSLog(array.description);
                for (int i=0; i<[array count]; i++) {
                    id resourceInArray=array[i];
                    if ([resourceInArray isKindOfClass:[NSDictionary class]]) {
                        id resource=[(NSDictionary *)resourceInArray valueForKey:@"resource"];
                        if([resourceInArray isKindOfClass:[NSDictionary class]]){
                            id fieldsInResource=[(NSDictionary *) resource valueForKey:@"fields"];
                            if([fieldsInResource isKindOfClass:[NSDictionary class]]){
                                NSString *name=[(NSDictionary *)fieldsInResource valueForKey:@"name"];
                                if([name rangeOfString:@"GOLD"].location !=NSNotFound || [name rangeOfString:@"SILVER"].location !=NSNotFound || [name rangeOfString:@"COPPER"].location !=NSNotFound || [name rangeOfString:@"PLATIN"].location !=NSNotFound || [name rangeOfString:@"PALLADIUM"].location !=NSNotFound)
                                    continue;
                                NSString *price_string=[(NSDictionary*)fieldsInResource valueForKey:@"price"];
                                NSNumber *price_number=[NSNumber numberWithFloat:[price_string floatValue]];
                                [mutableDiction setValue:price_number forKey:name];
                            }
                        }
                        
                    }
                }
                return mutableDiction;
            }
            
        }
        
        
    }
    return nil;
}


-(NSArray *) getCurrencyRate{
    NSEntityDescription *entity=[NSEntityDescription entityForName:@"CurrencyRate" inManagedObjectContext:[Context context]];
    NSFetchRequest *request=[[NSFetchRequest alloc]init];
    [request setEntity:entity];
    NSError *error;
    NSArray *array=[[Context context]executeFetchRequest:request error:&error];
    NSMutableArray *array2=[[NSMutableArray alloc]init];
    for (CurrencyRate *rate  in array  ){
        [array2 addObject:rate.shortname];
        [array2 addObject:rate.rate];
    }
    return array2;
    
}
@end
