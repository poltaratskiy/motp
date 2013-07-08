//
//  indeed_MainViewController.m
//  Mobile OTP for Indeed-ID
//
//  Created by Константин Полтарацкий on 02.07.13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "indeed_MainViewController.h"

@interface indeed_MainViewController ()

@property (nonatomic, strong) NSMutableArray *tokens;

@end

@implementation indeed_MainViewController
@synthesize tableVC = _tableVC;

@synthesize tokens = _tokens;
- (NSMutableArray *)tokens
{
    if (_tokens == nil)
    {
        _tokens = [indeed_TokenInfo GetTokenList];
        return _tokens;
    }
    else 
        return _tokens;
}

- (void)setTokens:(NSMutableArray *)tokens
{
    //_tokens = tokens;
}

- (void)refreshData
{
    _tokens = [indeed_TokenInfo GetTokenList];
    [self.tableVC reloadData];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        indeed_PublicPropertiesAndMethods *pp = [[indeed_PublicPropertiesAndMethods alloc] init];
        BOOL result = [pp CreateDB];
        if (result == NO)
            NSLog(@"Can't create table");
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.tableVC.delegate = self;
    indeed_PublicPropertiesAndMethods *cr = [[indeed_PublicPropertiesAndMethods alloc] init];
    [cr CreateDB];
    //self.tokens = [indeed_TokenInfo GetTokenList];
    //[self.tableVC reloadData];
}

- (void)viewDidUnload
{
    [self setTableVC:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [self refreshData];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    //return [indeed_TokenInfo.GetTokenList count];
    return [self.tokens count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    
    indeed_TokenInfo *ti = [self.tokens objectAtIndex:[indexPath row]];
    cell.textLabel.text = [ti name];
    cell.tag = [ti ID];
    
    return cell;
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }   
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }   
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    
    indeed_EnrollVC *dvc = [[indeed_EnrollVC alloc] initWithNibName:@"TokenInfoiPhoneView" bundle:nil];
    // ...
    // Pass the selected object to the new view controller.
    UITableViewCell *cl = [tableView cellForRowAtIndexPath:indexPath];
    dvc.TokenID = [cl tag];
    [self.navigationController pushViewController:dvc animated:YES];
     
}



- (IBAction)AddPressed:(id)sender {
    indeed_AddTokenVC *dvc = [[indeed_AddTokenVC alloc] initWithNibName:@"AddTokeniPhoneView" bundle:nil];
    [self presentModalViewController:dvc animated:YES];
}
@end
