//
//  FirstNumber+Update.m
//  makePreData
//
//  Created by hbucius on 10/16/14.
//  Copyright (c) 2014 hbucius. All rights reserved.
//

#import "FirstNumber+Update.h"
#import "Context.h"
@implementation FirstNumber (Update)




+(void) updateFirstNumber:(NSUInteger*) num{
    
    FirstNumber *first=[NSEntityDescription insertNewObjectForEntityForName:@"FirstNumber" inManagedObjectContext:[Context context]];
    if(first!=nil){
        first.number=[NSNumber numberWithInt:num];
        [[Context delegate] saveContext];
    }
    
}
+(NSUInteger *) getFirstNumber{
    
    NSEntityDescription *entityDescription=[NSEntityDescription entityForName:@"FirstNumber" inManagedObjectContext:[Context context]];
    NSFetchRequest *fetchRequest=[[NSFetchRequest alloc]init];
    [fetchRequest setEntity:entityDescription];
    NSError *erro;
    NSArray *array=[[Context context] executeFetchRequest:fetchRequest error:&erro];
    NSLog(@"the array count  is %lu in first number table" ,(unsigned long)array.count);
    if([array[0] isKindOfClass:[FirstNumber class]])
        return [((FirstNumber*)array[0]).number integerValue];
    else return 0;
}


@end
