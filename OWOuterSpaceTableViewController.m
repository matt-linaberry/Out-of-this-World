//
//  OWOuterSpaceTableViewController.m
//  Out of this World
//
//  Created by Matthew Linaberry on 10/2/14.
//  Copyright (c) 2014 Matthew Linaberry. All rights reserved.
//

#import "OWOuterSpaceTableViewController.h"
#import "OWSpaceObject.h"
#import "AstronomicalData.h"
#import "OWSpaceImageViewController.h"
#import "OWSpaceDataViewController.h"
@interface OWOuterSpaceTableViewController ()

@end

@implementation OWOuterSpaceTableViewController
#pragma mark - lazy instantiation

-(NSMutableArray *)planets
{
    if (!_planets)
    {
        _planets = [[NSMutableArray alloc] init];
    }
    return _planets;
}

- (NSMutableArray *)addedSpaceObjects
{
    if (!_addedSpaceObjects)
    {
        _addedSpaceObjects = [[NSMutableArray alloc] init];
    }
    return _addedSpaceObjects;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    for (NSMutableDictionary *planetData in [AstronomicalData allKnownPlanets])
    {
        NSString *imageName = [NSString stringWithFormat:@"%@.jpg", planetData[PLANET_NAME]];
        OWSpaceObject *planet = [[OWSpaceObject alloc] initWithData:planetData andImage:[UIImage imageNamed:imageName]];
        [self.planets addObject:planet];
    }
    
//    NSMutableDictionary *myDictionary = [[NSMutableDictionary alloc] init];
//    NSString *firstColor = @"red";
//    [myDictionary setObject:firstColor forKey:@"firetruck color"];
//    [myDictionary setObject:@"blue" forKey:@"ocean color"];
//    [myDictionary setObject:@"yellow" forKey:@"star color"];
//    
//    NSLog(@"%@", myDictionary);
//    
//    NSString *blueString = [myDictionary objectForKey:@"ocean color"];
//    NSLog(@"%@", blueString);
    NSNumber *myNumber = [NSNumber numberWithInt:5];
    NSLog(@"%@", myNumber);
    NSNumber *floatNumber = [NSNumber numberWithFloat:3.14];
    NSLog(@"%@", floatNumber);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - OWAddSpaceObjectViewContrtollerDelegate
-(void) didCancel
{
    NSLog(@"didCancel was just called!");
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) addSpaceObject:(OWSpaceObject *)spaceObject
{
    [self.addedSpaceObjects addObject:spaceObject];
    NSLog(@"addSpaceObject just called!");
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    if ([self.addedSpaceObjects count]) {
        return 2;
    }
    else {
        return 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    if (section == 1)
    {
        return [self.addedSpaceObjects count];
    }
    else {
        return [self.planets count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    // Configure the cell...
    if (indexPath.section == 1)
    {
        // use new space object to customize our cell...
        OWSpaceObject *planet = [self.addedSpaceObjects objectAtIndex:indexPath.row];
        cell.textLabel.text = planet.name;
        cell.detailTextLabel.text = planet.nickname;
        
        cell.imageView.image = planet.spaceImage;
    }
    else {
        OWSpaceObject *planet = self.planets[indexPath.row];
        cell.textLabel.text = planet.name;
        cell.detailTextLabel.text = planet.nickname;
        cell.imageView.image = planet.spaceImage;
    }
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.detailTextLabel.textColor = [UIColor colorWithWhite:0.5 alpha:1.0];
    
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

#pragma UITableView delegates
-(void) tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"push to space data" sender:indexPath];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    // the sender is the object that gets tapped!
    if ([sender isKindOfClass:[UITableViewCell class]])
    {
        // did a tableview cell cause the navigation event?
        if ([segue.destinationViewController isKindOfClass:[OWSpaceImageViewController class]])
        {
            // are we going to the space image view controller?
            OWSpaceImageViewController *nextViewController = segue.destinationViewController;
            NSIndexPath *path = [self.tableView indexPathForCell:sender];  // return the index path of the cell that called the segue!
            OWSpaceObject *selectedObject;
            
            if (path.section == 0)
            {
                selectedObject = self.planets[path.row];
            }
            else if (path.section == 1)
            {
                selectedObject = self.addedSpaceObjects[path.row];
            }
            
            nextViewController.spaceObject = selectedObject;
        }
    }
    
    if ([sender isKindOfClass:[NSIndexPath class]])
    {
        if ([segue.destinationViewController isKindOfClass:[OWSpaceDataViewController class]])
        {
            OWSpaceDataViewController *targetViewController = segue.destinationViewController;
            NSIndexPath *path = sender;
            OWSpaceObject *selectedObject;
            if (path.section == 0)
            {
                selectedObject = self.planets[path.row];
            }
            else if (path.section == 1)
            {
                selectedObject = self.addedSpaceObjects[path.row];
            }
            targetViewController.spaceObject = selectedObject;
        }
    }
    if ([segue.destinationViewController isKindOfClass:[OWAddSpaceObjectViewController class]]) {
        OWAddSpaceObjectViewController *addSpaceObjectVC = segue.destinationViewController;
        addSpaceObjectVC.delegate = self;
    }
}


@end
