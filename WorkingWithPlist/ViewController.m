//
//  ViewController.m
//  WorkingWithPlist
//
//  Created by Venkatesh Botla on 26/04/18.
//  Copyright © 2018 botla. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () 

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Declaring and allocating variables for future use.
    contacstDictionary = [[NSMutableDictionary alloc] init];
    contactsArray = [[NSMutableArray alloc] init];
}

- (IBAction)readButtonClicked:(id)sender {
    // Get the plist document path
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *plistFilePath = [documentsDirectory stringByAppendingPathComponent:@"contacts.plist"];
    
    // Check contacts.plist file exist or not
    BOOL isPlistExist = [[NSFileManager defaultManager] fileExistsAtPath:plistFilePath];
    if (isPlistExist) {
        NSLog(@"File is available. Get data if anything stored");
        contactsArray = [[NSMutableArray alloc] initWithContentsOfFile:plistFilePath];
    } else {
        NSLog(@"File is not available.");
        plistFilePath = [documentsDirectory stringByAppendingPathComponent:@"contacts.plist"];
        //NSLog(@"plistFilePath: %@", plistFilePath);
    }
    
    // Print the plist result data on tableview
    for (int i = 0; i < contactsArray.count; i++) {
        contacstDictionary = [contactsArray objectAtIndex:i];
        [plistTableView reloadData];
    }
    [self alertMessage:nil andMessage:@"Read successfully"];
}

- (IBAction)updateButtonClicked:(id)sender {
    NSLog(@"update button clicked");
    // Get the plist document path
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *plistFilePath = [documentsDirectory stringByAppendingPathComponent:@"contacts.plist"];
    
    // Check contacts.plist file exist or not
    BOOL isPlistExist = [[NSFileManager defaultManager] fileExistsAtPath:plistFilePath];
    if (isPlistExist) {
        NSLog(@"File is available. Get data if anything stored");
        contactsArray = [[NSMutableArray alloc] initWithContentsOfFile:plistFilePath];
    } else {
        NSLog(@"File is not available.");
        plistFilePath = [documentsDirectory stringByAppendingPathComponent:@"contacts.plist"];
        NSLog(@"plistFilePath: %@", plistFilePath);
    }
    
    // updating selected index row data on tableview and plist file
    [contacstDictionary setObject:nameTextField.text forKey:@"Name"];
    [contacstDictionary setObject:cityTextField.text forKey:@"City"];
    [contacstDictionary setObject:mobileTestField.text forKey:@"Mobile"];
    
    // updating contactsDictionary to contactsArray
    [contactsArray replaceObjectAtIndex:selectedIndexPath withObject:contacstDictionary];
    if ([contactsArray writeToFile:plistFilePath atomically:YES]) {
        nameTextField.text = @"";
        cityTextField.text = @"";
        mobileTestField.text = @"";
        
        [self alertMessage:nil andMessage:@"Updated successfully"];
    } else {
        [self alertMessage:nil andMessage:@"Coludn't updated"];
    }
    
    [plistTableView reloadData];
}

- (IBAction)removeButtonClicked:(id)sender {
    // Get the plist document path
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *plistFilePath = [documentsDirectory stringByAppendingPathComponent:@"contacts.plist"];
    
    // Check contacts.plist file exist or not
    BOOL isPlistExist = [[NSFileManager defaultManager] fileExistsAtPath:plistFilePath];
    if (isPlistExist) {
        NSLog(@"File is available. Get data if anything stored");
        contactsArray = [[NSMutableArray alloc] initWithContentsOfFile:plistFilePath];
    } else {
        NSLog(@"File is not available.");
        plistFilePath = [documentsDirectory stringByAppendingPathComponent:@"contacts.plist"];
        NSLog(@"plistFilePath: %@", plistFilePath);
    }
    
    // removing selected index row from tableview and plist file
    [contactsArray removeObjectAtIndex:selectedIndexPath];
    //NSLog(@"contactsArray: %@", contactsArray);
    
    if ([contactsArray writeToFile:plistFilePath atomically:YES]) {
        nameTextField.text = @"";
        cityTextField.text = @"";
        mobileTestField.text = @"";
        
        [self alertMessage:nil andMessage:@"Removed successfully"];
    } else {
        [self alertMessage:nil andMessage:@"Coludn't removed"];
        
    }
    
    [plistTableView reloadData];
    
}

- (IBAction)saveButtonClicked:(id)sender {
    NSLog(@"save button clicked");
    // Get the plist document path
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *plistFilePath = [documentsDirectory stringByAppendingPathComponent:@"contacts.plist"];

    // Check contacts.plist file exist or not
    BOOL isPlistExist = [[NSFileManager defaultManager] fileExistsAtPath:plistFilePath];
    if (isPlistExist) {
        NSLog(@"File is available. Get data if anything stored");
        contactsArray = [[NSMutableArray alloc] initWithContentsOfFile:plistFilePath];
    } else {
        NSLog(@"File is not available.");
        plistFilePath = [documentsDirectory stringByAppendingPathComponent:@"contacts.plist"];
        NSLog(@"plistFilePath: %@", plistFilePath);
    }
    
    NSString *name = nameTextField.text;
    NSString *city = cityTextField.text;
    NSString *mobile = mobileTestField.text;
    
    // check all the text fileds have values
    if (name.length > 1 && city.length > 1 && mobile.length > 1) {
        // add values to contactsDictionary
        [contacstDictionary setValue:name forKey:@"Name"];
        [contacstDictionary setValue:city forKey:@"City"];
        [contacstDictionary setObject:mobile forKey:@"Mobile"];
        
        // add contactsDictionary to contactsArray
        [contactsArray addObject:contacstDictionary];
        [plistTableView reloadData];
        
        if ([contactsArray writeToFile:plistFilePath atomically:YES]) {
            nameTextField.text = @"";
            cityTextField.text = @"";
            mobileTestField.text = @"";
            
            [self alertMessage:nil andMessage:@"Saved successfully"];

        } else {
            [self alertMessage:nil andMessage:@"Coludn't saved"];
        }
    } else {
        [self alertMessage:nil andMessage:@"Please! enter values"];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return contactsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellId"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"CellId"];
    }
    cell.textLabel.text = [[contactsArray objectAtIndex:indexPath.row] objectForKey:@"Name"];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@, %@", [[contactsArray objectAtIndex:indexPath.row] objectForKey:@"City"], [[contactsArray objectAtIndex:indexPath.row] objectForKey:@"Mobile"]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    nameTextField.text = [[contactsArray objectAtIndex:indexPath.row] objectForKey:@"Name"];
    cityTextField.text = [[contactsArray objectAtIndex:indexPath.row] objectForKey:@"City"];
    mobileTestField.text = [[contactsArray objectAtIndex:indexPath.row] objectForKey:@"Mobile"];
    
      selectedIndexPath = indexPath.row;
}

-(void)alertMessage:(NSString *)title andMessage:(NSString *)message {
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:nil
                                                                   message:message
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {}];
    
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
