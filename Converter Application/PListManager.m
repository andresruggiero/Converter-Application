//
//  PListManager.m
//  Exchange Rate Converter
//
//  Created by Andres Ruggiero on 2/2/15.
//  Copyright (c) 2015 Andres Ruggiero. All rights reserved.
//
// Description: PlistManager is in charge of taking the data from the property lists and saving it into the Data Model (Items, Collection & Categories). Saving the Categories into the ExchangeManager is handled by the Store Coordinator.

#import "PListManager.h"
#import "Item.h"
#import "ExchangeCategory.h"
#import "CurrencyCollection.h"

@implementation PListManager

@synthesize categories;
@synthesize exchangeCategoriesArray;

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.categories = [[NSMutableArray alloc] init];
        self.exchangeCategoriesArray = [[NSMutableArray alloc] init];
        [self startPListLoading];
    }
    
    return self;
}

#pragma mark - Property List Loading

-(void) saveItemsFromDictionary: (NSMutableDictionary *)myDic{
    
    //for (NSString *category in categoriesArray) {
        //NSMutableDictionary *myDic = [self loadPListWithName:category];
    for (NSString *categoryName in myDic) {
        NSLog(@"%@",categoryName);
        ExchangeCategory *exchangeCategory = [[ExchangeCategory alloc] initWithName:categoryName];
        NSMutableDictionary *categoryDictionary = [[NSMutableDictionary alloc] initWithDictionary:[myDic objectForKey:categoryName]];
        for (NSString *code in categoryDictionary) {
            NSMutableDictionary *myDic2 = [[NSMutableDictionary alloc] initWithDictionary:[categoryDictionary objectForKey:code]];
            NSLog(@"Code %@:",code);
            for (NSString *secondCode in myDic2) {
                NSLog(@"From: %@ to: %@ rate: %@",code,secondCode,[myDic2 objectForKey:secondCode]);
                Item *item = [[Item alloc] init];
#warning Modify item property set in Property Lists setup
                //item.baseCurrency = code;
                //item.fromCurrency = code;
                //item.toCurrency = secondCode;
                //item.exchangeRate = [myDic2 objectForKey:secondCode];
                [self.categories addObject:item];
            }
            CurrencyCollection *currencyCollection = [[CurrencyCollection alloc] initWithName:categoryName andArrayOfItems:self.categories];
            [exchangeCategory addCurrencyCollection:currencyCollection];
        }
        [self.exchangeCategoriesArray addObject:exchangeCategory];
    }
    //}
    
}

-(void) loadPListWithName:(NSString *)name{
    
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"plist"];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if ([fileManager fileExistsAtPath:path]) {
        NSLog(@"The file exists");
    } else {
        NSLog(@"The file does not exist");
    }
    
    NSMutableDictionary *myDic = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
    
    [self saveItemsFromDictionary:myDic];
}

-(void) startPListLoading{
    
    [self loadPListWithName:@"Units"];

}

#pragma mark - Getting Properties

-(NSMutableArray *) getAllItems{
    return self.categories;
}

-(NSMutableArray *) getAllCategories{
    return self.exchangeCategoriesArray;
}

@end
