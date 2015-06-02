//
//  ViewController.m
//  Converter Application
//
//  Created by Andres Ruggiero on 3/13/15.
//  Copyright (c) 2015 Andres Ruggiero. All rights reserved.
//

#import "ViewController.h"
#import <Parse/Parse.h>
#import "ParseBackEndManager.h"
#import "ExchangeManager.h"
#import "ExchangeCategory.h"
#import "CurrencyCollection.h"
#import "Item.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize exchangeManager;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    exchangeManager = [ExchangeManager sharedManager];
    
    // Do any additional setup after loading the view, typically from a nib.
    
    NSLog(@"Container View Controller");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
