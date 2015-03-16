//
//  ParseBackEndManager.m
//  Converter Application
//
//  Created by Andres Ruggiero on 3/13/15.
//  Copyright (c) 2015 Andres Ruggiero. All rights reserved.
//

#import "ParseBackEndManager.h"
#import <Parse/Parse.h>
#import "ExchangeCategory.h"
#import "CurrencyCollection.h"
#import "ExchangeManager.h"
#import "Item.h"

@implementation ParseBackEndManager

@synthesize exchangeManager;

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSLog(@"initParseBackEnd");
        exchangeManager = [ExchangeManager sharedManager];
        [self uploadDataFromParse];
    }
    return self;
}

-(void) uploadDataFromParse{
    
    NSArray *message = [self loadParameter:@"currencyArray"];
    //NSLog(@"Messsage = %@", message);
    
    // Creating Currency exchangeCategory
    ExchangeCategory *exchangeCategory = [[ExchangeCategory alloc] initWithName:@"Currency"];
    
    NSMutableArray *arrayOfExchangeCategory = [[NSMutableArray alloc] init];
    
    NSMutableArray *arrayOfCurrencyCollection = [[NSMutableArray alloc] init];
    
    for (NSString *code in message) {
        
        //NSLog(@"Code: %@",code);
        
        NSArray *objects = [[NSArray alloc] initWithArray:[self objectsWithClassName:@"Item" whereKey:@"baseCurrency" equalTo:code]];
        
        NSMutableArray *arrayOfItems = [[NSMutableArray alloc] init];
        
        for (PFObject *object in objects) {
            Item *item = [[Item alloc] init];
            [item setBaseCurrency:object[@"baseCurrency"]];
            [item setBaseName:object[@"baseName"]];
            [item setTargetCurrency:object[@"targetCurrency"]];
            [item setTargetName:object[@"targetName"]];
            [item setExchangeRate:object[@"exchangeRate"]];
            [arrayOfItems addObject:item];
            //NSLog(@"Base: %@ Target:%@ Rate:%@",item.baseName,item.targetName,item.exchangeRate);
        }
        
        // Creating a CurrencyCollection for each code
        CurrencyCollection *currencyCollection = [[CurrencyCollection alloc] initWithName:code andArrayOfItems:arrayOfItems];
        
        // Adding each currencyCollection to an array
        [arrayOfCurrencyCollection addObject:currencyCollection];
        
    }
    
    // Setting a currencyCollectionArray for each category
    [exchangeCategory setCurrencyCollectionArray:arrayOfCurrencyCollection];
    
    // Adding each exchangeCategory to the array
    [arrayOfExchangeCategory addObject:exchangeCategory];
    
    // Setting the categoryArray to the ExchangeManager
    [exchangeManager setCategoryArray:arrayOfExchangeCategory];
    
}

-(NSArray *) loadParameter:(NSString *)parameter{
    
    PFConfig *config = [PFConfig getConfig];
    
    config = [PFConfig currentConfig];
    
    NSLog(@"Getting the latest config...");
    NSArray *message = config[parameter];
    
    if (!message) {
        NSLog(@"Falling back to default message.");
        //welcomeMessage = @"Welcome!";
    }
    
    return message;
    
}

-(NSArray *) objectsWithClassName:(NSString *)className whereKey:(NSString *)key equalTo:(NSString *)string{
    
    PFQuery *allItems = [PFQuery queryWithClassName:className];
    [allItems whereKey:key equalTo:string];
    //__block NSArray *parseObjects = nil;
    
    allItems.limit = 200;
    
    NSArray *objects = [[NSArray alloc] initWithArray:[allItems findObjects]];
    
    /*[allItems findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error){
        if (!error) {
            // The find succeeded
            NSLog(@"objects: %@",objects);
            parseObjects = [[NSArray alloc] initWithArray:objects];
            NSLog(@"ParseObjects: %@",parseObjects);
            
        } else {
            NSLog(@"Error: %@ %@",error, [error userInfo]);
        }
    }];*/

    return objects;
}

@end
