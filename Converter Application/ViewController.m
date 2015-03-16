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

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*PFQuery *query1 = [PFQuery queryWithClassName:@"Item"];
    [query1 whereKey:@"category" equalTo:@"Currency"];
    [query1 whereKey:@"targetCurrency" equalTo:@"EUR"];
    
    query1.limit = 200;
    [query1 findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %lu scores.", (unsigned long)objects.count);
            // Do something with the found objects
            for (PFObject *object in objects) {
                NSLog(@"%@", object.objectId);
            }
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];*/
    
    /*NSLog(@"Getting the latest config...");
    [PFConfig getConfigInBackgroundWithBlock:^(PFConfig *config, NSError *error) {
        if (!error) {
            NSLog(@"Yay! Config was fetched from the server.");
        } else {
            NSLog(@"Failed to fetch. Using Cached Config.");
            config = [PFConfig currentConfig];
        }
        
        NSArray *welcomeMessage = config[@"currencyArray"];
        if (!welcomeMessage) {
            NSLog(@"Falling back to default message.");
            //welcomeMessage = @"Welcome!";
        }
        NSLog(@"Welcome Messsage = %@", welcomeMessage);
    }];*/
    
    ParseBackEndManager *pbackend = [[ParseBackEndManager alloc] init];
    [pbackend uploadDataFromParse];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
