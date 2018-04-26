//
//  ViewController.h
//  WorkingWithPlist
//
//  Created by Venkatesh Botla on 26/04/18.
//  Copyright © 2018 botla. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
    
    IBOutlet UITextField *nameTextField;
    IBOutlet UITextField *cityTextField;
    IBOutlet UITextField *mobileTestField;
    
    IBOutlet UIButton *readButton;
    IBOutlet UIButton *updateButton;
    IBOutlet UIButton *removeButton;
    IBOutlet UIButton *saveButton;

    IBOutlet UITableView *plistTableView;
    
    NSMutableDictionary *contacstDictionary;
    NSMutableArray *contactsArray;
    NSUInteger selectedIndexPath;
    
}

- (IBAction)readButtonClicked:(id)sender;
- (IBAction)updateButtonClicked:(id)sender;
- (IBAction)removeButtonClicked:(id)sender;
- (IBAction)saveButtonClicked:(id)sender;




@end

