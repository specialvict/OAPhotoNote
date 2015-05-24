//
//  OAAddPhotoNotebookViewController.m
//  OAPhotoNote
//
//  Created by lee on 2015/5/17.
//  Copyright (c) 2015年 Lee Chung-Yun. All rights reserved.
//

#import "OAAddPhotoNotebookViewController.h"
#import "NotePropertyTableViewController.h"
#import "CategoryCollectionViewController.h"
#import "PhotoNotebook.h"

@interface OAAddPhotoNotebookViewController ()<UITextFieldDelegate>


@property (weak, nonatomic) IBOutlet UITextField *notebookNameTextField;
@property (weak, nonatomic) IBOutlet UIView *categoryContainerView;
@property (weak, nonatomic) IBOutlet UIView *propertyContainerView;
@property (strong,nonatomic) NotePropertyTableViewController * propertyViewController;
@property (strong,nonatomic) CategoryCollectionViewController * categoryViewController;
@end

@implementation OAAddPhotoNotebookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.notebookNameTextField.delegate = self;
    // Do any additional setup after loading the view.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"CategorySegue"]) {
        if ([segue.destinationViewController class] == [CategoryCollectionViewController class]) {
            self.categoryViewController = (CategoryCollectionViewController *)segue.destinationViewController;
            self.categoryViewController.photoNotebook = self.photoNotebook;
        }
    } else if([segue.identifier isEqualToString:@"PropertySegue"]){
        if ([segue.destinationViewController class] == [NotePropertyTableViewController class]) {
            self.propertyViewController = (NotePropertyTableViewController *)segue.destinationViewController;
            self.propertyViewController.photoNotebook = self.photoNotebook;
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - getters and setters
-(PhotoNotebook *)photoNotebook{
    if (!_photoNotebook) {
        _photoNotebook = [NSEntityDescription insertNewObjectForEntityForName:@"PhotoNotebook" inManagedObjectContext:self.managedObjectContext];
    }
    return _photoNotebook;
}
#pragma mark - text field delegate

-(void)textFieldDidEndEditing:(UITextField *)textField{
    self.photoNotebook.name = textField.text;
    NSError * error;
    [self.photoNotebook.managedObjectContext save:&error];
    if (error) {
        NSLog(@"error: %@",error.localizedDescription);
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}


#pragma mark - actions
- (IBAction)confirmToAdd:(id)sender {
    [self.notebookNameTextField resignFirstResponder];
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)cancel:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)dealloc{
    NSLog(@"%@ -- dealloc",self);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
