//
//  RouteDetailViewController.m
//  bus
//
//  Created by mac_hero on 12/5/18.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "RouteDetailViewController.h"
#import "UIKit+MITAdditions.h"
#define kPlainId				@"Plain"



@implementation RouteDetailViewController
@synthesize item;
@synthesize waitTime;
@synthesize  waitTime1_103;
@synthesize waitTime2_103;
@synthesize waitTime1_104;
@synthesize waitTime2_104;

- (void) getURL:(NSString* ) inputURL
{
   
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        [self.tableView applyStandardColors];
        // Custom initialization
    }
    item = [NSMutableArray new];
    waitTime = [NSMutableArray new];
    return self;
}

-(void) addRoutesURL:(NSString *)_103First and:(NSString *)_103Second and:(NSString *)_104First and:(NSString *)_104Second{
    waitTime1_103 = [NSURL URLWithString:_103First];
    waitTime2_103 = [NSURL URLWithString:_103Second];
    waitTime1_104 = [NSURL URLWithString:_104First];
    waitTime2_104 = [NSURL URLWithString:_104Second];
    [ waitTime  addObject:waitTime1_103 ];
    if (waitTime2_103) [ waitTime  addObject:waitTime2_103 ];
    [ waitTime  addObject:waitTime1_104 ];
    if (waitTime2_104) [ waitTime  addObject:waitTime2_104 ];
}

-(void)goBackMode:(BOOL)go{
       dir = go;
} 
- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
        
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    for (id obj in waitTime){
    NSError* error;
    UInt32 big5 = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingBig5);
    NSData* data = [[NSString stringWithContentsOfURL:obj encoding:big5 error:&error] dataUsingEncoding:big5];
    TFHpple* parser = [[TFHpple alloc] initWithHTMLData:data];
    NSArray *waittime_tmp  = [parser searchWithXPathQuery:@"//body//div//table//tr//td"]; // get the title
    TFHppleElement* T_ptr2 = [waittime_tmp objectAtIndex:2];
    NSArray *child2 = [T_ptr2 children];
    TFHppleElement* buf2 = [child2 objectAtIndex:0];
    [item  addObject: [buf2 content] ];
    [self.tableView reloadData];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

- (void)dealloc {
    [item release];
    [super dealloc];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [item count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kPlainId];
    
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:kPlainId] autorelease];
    }
    
    // Set up the cell
    
  
    cell.detailTextLabel.text =[item objectAtIndex:indexPath.row];
   // cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.adjustsFontSizeToFitWidth = YES;
    cell.textLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:16];
    if (dir){
        switch (indexPath.row) {
            case 0:
                cell.textLabel.text = @"103八斗子-中正路-總站";
                break;
            case 1:
                if ([waitTime count]>2)
                    cell.textLabel.text = @"103八斗子-祥豐街-總站";
                else
                    cell.textLabel.text = @"104新豐街-中正路-總站";
                break;
            case 2:
                cell.textLabel.text = @"104新豐街-中正路-總站";
                break;
            case 3:
                cell.textLabel.text = @"104新豐街-祥豐街-總站";
                break;
            default:
                break;
        }
    }
    else {
        switch (indexPath.row) {
            case 0:
                cell.textLabel.text = @"103總站-中正路-八斗子";
                break;
            case 1:
                if ([waitTime count]>2)
                    cell.textLabel.text = @"103總站-祥豐街-中正路";
                else
                    cell.textLabel.text = @"104總站-中正路-新豐街";
                break;
            case 2:
                cell.textLabel.text = @"104總站-中正路-新豐街";
                break;
            case 3:
                cell.textLabel.text = @"104總站-祥豐街-新豐街";
                break;
            default:
                break;
        }
    
    
    }
    cell.detailTextLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
    if ([cell.detailTextLabel.text isEqualToString:@"即將進站..."]) {
        cell.detailTextLabel.textColor = [UIColor redColor];
    }
    else if ([cell.detailTextLabel.text isEqualToString:@"目前無公車即時資料"]) {
        cell.detailTextLabel.textColor = [UIColor grayColor];
    }
    else{
        cell.detailTextLabel.textColor = [UIColor colorWithRed:35.0/255 green:192.0/255 blue:46/255 alpha:1];
    }
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
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
   }

@end
