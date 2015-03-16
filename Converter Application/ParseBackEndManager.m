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
#import "Item.h"

@implementation ParseBackEndManager

-(void) uploadDataFromParse{
    
    [self loadParameter:@"currencyArray"];
    NSLog(@"uploadDataFromParse");
    
    /*for (NSString *currencyCode in currencyCodeArray) {
        //ExchangeCategory *exchangeCategory = [[ExchangeCategory alloc] initWithName:currencyCode];
        NSArray *objects = [[NSArray alloc] initWithArray:[self objectsWithClassName:@"Item" whereKey:@"baseCurrency" equalTo:currencyCode]];
        NSLog(@"Hello: %@",[objects objectAtIndex:0]);
    }*/
    
    NSLog(@"After");
}

-(void) loadParameter:(NSString *)parameter{
    
    NSLog(@"Getting the latest config...");
    
    __block NSArray *objectArray = nil;
    
    [PFConfig getConfigInBackgroundWithBlock:^(PFConfig *config, NSError *error) {
        if (!error) {
            NSLog(@"Yay! Config was fetched from the server.");
        } else {
            NSLog(@"Failed to fetch. Using Cached Config.");
            config = [PFConfig currentConfig];
        }
        
        NSArray *message = config[parameter];
        if (!message) {
            NSLog(@"Falling back to default message.");
            //welcomeMessage = @"Welcome!";
        }
        NSLog(@"Messsage = %@", message);
        
        objectArray = [[NSArray alloc] initWithArray:message];
        NSLog(@"Object Array: %@",objectArray);
    }];
    
#warning Problem is that config is fetched asynchronously.
    
}

-(NSArray *) objectsWithClassName:(NSString *)className whereKey:(NSString *)key equalTo:(NSString *)string{
    
    PFQuery *allItems = [PFQuery queryWithClassName:className];
    [allItems whereKey:key equalTo:string];
    __block NSArray *parseObjects = nil;
    
    allItems.limit = 200;
    
    [allItems findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error){
        if (!error) {
            // The find succeeded
            parseObjects = objects;
        } else {
            NSLog(@"Error: %@ %@",error, [error userInfo]);
        }
    }];
    
    return parseObjects;
}

@end
