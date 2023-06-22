//
//  DemoObjcTableViewCell.m
//  KeyboardManagerDemo
//
//  Created by Edouard Siegel on 02/05/2019.
//

#import "DemoObjcTableViewCell.h"
@import ADUtils;

@interface DemoObjcTableViewCell () <UITextFieldDelegate> {}
@property (nonatomic, readwrite) UITextField * textField;
@end

@implementation DemoObjcTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self != nil) {
        self.textField = [[UITextField alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:self.textField];
        [self.textField ad_pinToSuperviewWithInsets:UIEdgeInsetsMake(8, 16, 8, 16)];
        self.textField.delegate = self;
    }
    return self;
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}
@end
