//
//  SignInViewController.h
//  test
//
//  Created by Rockstar. on 7/2/14.
//  Copyright (c) 2014 Bnei Baruch. All rights reserved.
//

@interface SignInViewController : UITableViewController <UITextFieldDelegate>

@property (nonatomic, strong, readonly) UITextField *usernameTextField;
@property (nonatomic, strong, readonly) UITextField *emailTextField;
@property (nonatomic, strong, readonly) UITextField *passwordTextField;
@property (nonatomic, strong, readonly) UITextField *nameTextField;
@property (nonatomic, strong, readonly) UITextField *lastNameTextField;

+ (CGFloat)textFieldWith;

- (void)signIn:(id)sender;
- (void)signUp:(id)sender;
- (void)forgot:(id)sender;

@end
