//
//  StyleKitName.h
//  ProjectName
//
//  Created by Andres Ruggiero on 4/17/15.
//  Copyright (c) 2015 CompanyName. All rights reserved.
//
//  Generated by PaintCode (www.paintcodeapp.com)
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface StyleKitName : NSObject

// Colors
+ (UIColor*)baseColor;
+ (UIColor*)stringColor;
+ (UIColor*)redBaseColor;

// Drawing Methods
+ (void)drawContentCellWithFrame: (CGRect)frame baseCurrencyName: (NSString*)baseCurrencyName baseCurrency: (NSString*)baseCurrency exchangeRate: (NSString*)exchangeRate isPressed: (BOOL)isPressed;
+ (void)drawCategoriesCellWithFrame: (CGRect)frame withIcon: (UIImage*)withIcon andExchangeCategoryName: (NSString*)andExchangeCategoryName isPressed: (BOOL)isPressed;
+ (void)drawCanvas1WithFrame: (CGRect)frame isPressed: (BOOL)isPressed category: (NSString*)category;

@end
