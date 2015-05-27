//
//  CustomCategoriesTableViewCell.m
//  Converter Application
//
//  Created by Andres Ruggiero on 3/30/15.
//  Copyright (c) 2015 Andres Ruggiero. All rights reserved.
//

#import "CustomCategoriesTableViewCell.h"
#import "StyleKitName.h"

@interface CustomCategoriesTableViewCell()

@property BOOL isPressed;

@end

@implementation CustomCategoriesTableViewCell
@synthesize categoriesLabel;
@synthesize icon;

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
        NSLog(@"Is Pressed");
    } else {
        self.isPressed = NO;
        [self setNeedsDisplay];
        NSLog(@"Is not Pressed");
    }
    
}

-(void) drawRect:(CGRect)rect{
    
    
    
    /*[StyleKitName drawCategoriesCellWithFrame:rect
                                     withIcon:self.icon
                      andExchangeCategoryName:self.categoriesLabel
                                    isPressed:self.isPressed];*/
    
    [StyleKitName drawCanvas1WithFrame:rect isPressed:self.isPressed category:self.categoriesLabel];
    
}

@end
