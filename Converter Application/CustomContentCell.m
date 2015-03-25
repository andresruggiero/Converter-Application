//
//  CustomContentCell.m
//  Converter Application
//
//  Created by Andres Ruggiero on 3/18/15.
//  Copyright (c) 2015 Andres Ruggiero. All rights reserved.
//

#import "CustomContentCell.h"
#import "StyleKitName.h"

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

-(void) drawRect:(CGRect)rect{
    
    [StyleKitName drawCanvas1WithBaseCurrencyName:self.baseNameLabel
                                     baseCurrency:self.baseCurrencyLabel
                                     exchangeRate:self.exchangeRateLabel];
    
    
}

@end
