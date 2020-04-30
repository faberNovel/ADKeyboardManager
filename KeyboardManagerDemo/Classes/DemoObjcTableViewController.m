//
//  DemoObjcTableViewController.m
//  KeyboardManagerDemo
//
//  Created by Edouard Siegel on 02/05/2019.
//

#import "DemoObjcTableViewController.h"
#import "DemoObjcTableViewCell.h"
@import ADUtils;
@import ADKeyboardManager;

@interface DemoObjcTableViewController () {
    ADKeyboardManager * _keyboardManager;
}
@end

static NSString * sCellIdentifier = @"sDemoObjcTableViewControllerCellIdentifier";

@implementation DemoObjcTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Obj-C TableView Demo";
    [self.tableView registerClass:[DemoObjcTableViewCell class] forCellReuseIdentifier:sCellIdentifier];
    [self.tableView setEstimatedRowHeight:60];
    [self.tableView setRowHeight:60];
    [self.tableView reloadData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [_keyboardManager ad_startObservingKeyboard];
}

- (void)viewWillDisappear:(BOOL)animated {
    [_keyboardManager ad_stopObservingKeyboard];
    [super viewWillDisappear:animated];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DemoObjcTableViewCell * cell = (DemoObjcTableViewCell *)[tableView dequeueReusableCellWithIdentifier:sCellIdentifier
                                                                                            forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textField.placeholder = [NSString stringWithFormat:@"Row %ld", (long)indexPath.row];
    return cell;
}
@end
