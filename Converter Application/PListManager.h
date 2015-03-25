//
//  PListManager.h
//  Exchange Rate Converter
//
//  Created by Andres Ruggiero on 2/2/15.
//  Copyright (c) 2015 Andres Ruggiero. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ExchangeCategory;

@interface PListManager : NSObject

@property (strong, nonatomic) NSMutableArray *itemArray;
@property (strong, nonatomic) NSMutableArray *categories;
@property (strong,nonatomic) NSMutableArray *exchangeCategoriesArray;

-(void) saveItemsFromDictionary: (NSMutableDictionary *)myDic;
-(void) loadPListWithName:(NSString *)name;
-(NSMutableArray *) getAllItems;
-(NSMutableArray *) getAllCategories;

@end
