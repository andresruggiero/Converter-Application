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

-(void) uploadData {
    
    //NSArray *message = [exchangeManager loadParameter:@"currencyArray"];
    
    NSDictionary *messageDictionary = [[NSDictionary alloc] initWithObjectsAndKeys:@"USD",@"USD",@"EUR",@"EUR",@"CHF",@"CHF",@"VEF",@"VEF", nil];
    
    //ExchangeCategory *exchangeCategory = [[ExchangeCategory alloc] initWithName:@"Currency" andIcon:nil];
    
    //NSMutableArray *arrayOfExchangeCategory = [[NSMutableArray alloc] init];
    //NSMutableArray *arrayOfCurrencyCollection = [[NSMutableArray alloc] init];
    
    PFQuery *query = [PFQuery queryWithClassName:@"Item"];
    query.limit = 1000;
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %lu scores.", (unsigned long)objects.count);
            
            NSMutableArray *arrayOfItems = [[NSMutableArray alloc] init];
            
            // Do something with the found objects
            for (PFObject *object in objects) {
                Item *item = [[Item alloc] init];
                [item setBaseCurrency:object[@"baseCurrency"]];
                [item setBaseName:object[@"baseName"]];
                [item setTargetCurrency:object[@"targetCurrency"]];
                [item setTargetName:object[@"targetName"]];
                [item setExchangeRate:object[@"exchangeRate"]];
                [arrayOfItems addObject:item];
                //NSLog(@"Base:%@ Target:%@ Rate:%@",item.baseCurrency,item.targetName,item.exchangeRate);
            }
            
            for (Item *item in arrayOfItems) {
                if ([[messageDictionary allKeys] containsObject:item.baseCurrency]) {
                    NSLog(@"Object Found: %@",item.baseCurrency);
                }
            }
            
            // I have all the items in-app, now I need to break them down and save them in each currencycollection
            
            // Creating a CurrencyCollection for each code
            //CurrencyCollection *currencyCollection = [[CurrencyCollection alloc] initWithName:code andArrayOfItems:arrayOfItems];
            
            // Adding each currencyCollection to an array
            //[arrayOfCurrencyCollection addObject:currencyCollection];
            
            
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    
}

-(void) uploadDataFromParse{
    
    NSArray *message = [exchangeManager loadParameter:@"currencyArray"];
    //NSLog(@"Messsage = %@", message);
    
    // Creating Currency exchangeCategory
    ExchangeCategory *exchangeCategory = [[ExchangeCategory alloc] initWithName:@"Currency" andIcon:nil];
    //[exchangeCategory setExchangeCategoryIcon:[UIImage imageNamed:@"Money_Bag-100.png"]];
    
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

-(IBAction)callback:(id)sender{
    
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
