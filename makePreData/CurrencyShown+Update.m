//
//  CurrencyShown+Update.m
//  makePreData
//
//  Created by hbucius on 10/16/14.
//  Copyright (c) 2014 hbucius. All rights reserved.
//

#import "CurrencyShown+Update.h"
#import "Context.h"
@implementation CurrencyShown (Update)


+(void) updateCurrencyShown:(NSArray*) array{
    
    for (int i=0; i<array.count; i++) {
        CurrencyShown *shown=[NSEntityDescription insertNewObjectForEntityForName:@"CurrencyShown" inManagedObjectContext:[Context context]];
        if(shown){
            shown.shortname=array[i];
            shown.index=[NSNumber numberWithInt:i];
        }
        
    }
    [[Context delegate] saveContext];
    
}
+(NSArray *) getCurrencyShown{
    
    NSEntityDescription *entity=[NSEntityDescription entityForName:@"CurrencyShown" inManagedObjectContext:[Context context]];
    NSFetchRequest *request=[[NSFetchRequest alloc]init];
    [request setEntity:entity];
    NSSortDescriptor *descriptor=[[NSSortDescriptor alloc]initWithKey:@"index" ascending:YES];
    [request setSortDescriptors:[NSArray arrayWithObject:descriptor]];
    NSError *error;
    NSArray *array=[[Context context] executeFetchRequest:request error:&error];
    NSMutableArray *returnArray=[[NSMutableArray alloc]init];
    for (CurrencyShown * obj in array) {
        [returnArray  addObject:obj.shortname];
    }
    
    return [NSArray arrayWithArray:returnArray];
    
}

@end
