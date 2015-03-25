//
//  ContentViewController.m
//  Converter Application
//
//  Created by Andres Ruggiero on 3/18/15.
//  Copyright (c) 2015 Andres Ruggiero. All rights reserved.
//

#import "ContentViewController.h"
#import "ExchangeManager.h"
#import "CurrencyCollection.h"
#import "CustomContentCell.h"
#import "Item.h"

@interface ContentViewController ()

@end

@implementation ContentViewController{
    // Message array is used to download the config currencyArray of Parse
    NSArray *message;
}

@synthesize exchangeManager;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    exchangeManager = [ExchangeManager sharedManager];
    
    /*NSArray *arr = [exchangeManager getAllCurrencyCollectionsFromCategoryWithName:@"Volume"];
    
    for (CurrencyCollection *coll in arr) {
        
        NSLog(@"%@",coll.currencyCollectionName);
        NSArray *itemArray = coll.itemsArray;
        for (Item *item in itemArray) {
            NSLog(@"base: %@ target: %@",item.baseCurrency, item.targetCurrency);
        }
    }*/
    
    // Loading currencyArray config from Parse BaaS
    message = [[NSArray alloc] initWithArray:[exchangeManager loadParameter:@"currencyArray"]];
    
    // Uncomment the following line to preserve selection between presentations.
     self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView Data Source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    // Return the number of rows in the section.
    NSMutableArray *array = [exchangeManager getCurrencyCollectionsWithNames:message andExchangeCategoryName:@"Currency"];
    return [array count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CustomContentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Custom Cell" forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[CustomContentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Custom Cell"];
    }
    
    NSMutableArray *array = [exchangeManager getCurrencyCollectionsWithNames:message andExchangeCategoryName:@"Currency"];
    
    CurrencyCollection *collection = [array objectAtIndex:[indexPath row]];
    
    [cell setBaseCurrencyLabel:collection.currencyCollectionName];
    
    //[cell.baseCurrencyLabel setText:collection.currencyCollectionName];
    
    Item *item = [exchangeManager getItemFromCurrencyCollection:collection fromBaseCurrency:collection.currencyCollectionName toTargetCurrency:@"USD"];
    
    if (item != nil) {
        [cell setExchangeRateLabel:item.exchangeRate];
        //[cell.exchangeRateLabel setText:item.exchangeRate];
        
        [cell setBaseNameLabel:item.baseName];
        //[cell.baseNameLabel setText:item.baseName];
    } else {
        NSLog(@"Error: Item nil");
    }
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
