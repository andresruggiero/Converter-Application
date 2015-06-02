//
//  CustomContentCell.m
//  Converter Application
//
//  Created by Andres Ruggiero on 3/18/15.
//  Copyright (c) 2015 Andres Ruggiero. All rights reserved.
//

#import "CustomContentCell.h"
#import "StyleKitName.h"

@interface CustomContentCell()

@property BOOL isPressed;

@end

@implementation CustomContentCell
@synthesize baseCurrencyLabel;
@synthesize baseNameLabel;
@synthesize exchangeRateLabel;

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

// Overriden setHighlited method to integrate StyleKitName class
-(void) setHighlighted:(BOOL)highlighted{
    
    if (highlighted) {
        self.isPressed = YES;
        [self setNeedsDisplay];
        //NSLog(@"Is Pressed");
    } else {
        self.isPressed = NO;
        [self setNeedsDisplay];
        //NSLog(@"Is not Pressed");
    }
    
}

-(void) drawRect:(CGRect)rect{
    
    [StyleKitName drawContentCellWithFrame:rect
                          baseCurrencyName:self.baseNameLabel
                              baseCurrency:self.baseCurrencyLabel
                              exchangeRate:self.exchangeRateLabel
                                 isPressed:self.isPressed];

}

@end
