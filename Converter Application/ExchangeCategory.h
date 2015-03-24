//
//  ExchangeCategory.h
//  Exchange Rate Converter
//
//  Created by Andres Ruggiero on 2/2/15.
//  Copyright (c) 2015 Andres Ruggiero. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class CurrencyCollection;

@interface ExchangeCategory : NSObject

// Array of Currency Collection objects
@property NSMutableArray *currencyCollectionArray;
@property (strong, nonatomic) NSString *exchangeCategoryName;
@property (strong, nonatomic) UIImage *exchangeCategoryIcon;

-(id) initWithName:(NSString *) name andIcon:(UIImage *)image;
-(void) addCurrencyCollection:(CurrencyCollection *)collection;

@end
