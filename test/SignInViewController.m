//
//  SignInViewController.m
//  test
//
//  Created by Rockstar. on 7/2/14.
//  Copyright (c) 2014 Bnei Baruch. All rights reserved.
//

#import "SignInViewController.h"
#import "UIFont+HipsteriOSAdditions.h"
#import "UIColor+HipsteriOSAdditions.h"

@interface SignInViewController ()
- (void)_toggleMode:(id)sender;
- (void)_toggleModeAnimated:(BOOL)animated;
- (void)_configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;
- (void)_validateButton;

@end

@implementation SignInViewController{
	UIButton *_footerButton;
	BOOL _signUpMode;
}

@synthesize usernameTextField = _usernameTextField;
@synthesize emailTextField = _emailTextField;
@synthesize passwordTextField = _passwordTextField;

- (UITextField *)usernameTextField {
	if (!_usernameTextField) {
		_usernameTextField = [[UITextField alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [[self class] textFieldWith], 30.0f)];
		_usernameTextField.keyboardType = UIKeyboardTypeEmailAddress;
		_usernameTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
		_usernameTextField.autocorrectionType = UITextAutocorrectionTypeNo;
		_usernameTextField.textColor = [UIColor hipsterBlueColor];
		_usernameTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
		_usernameTextField.delegate = self;
		_usernameTextField.returnKeyType = UIReturnKeyNext;
		_usernameTextField.font = [UIFont hipsterInterfaceFontOfSize:18.0f];
	}
	return _usernameTextField;
}


- (UITextField *)passwordTextField {
	if (!_passwordTextField) {
		_passwordTextField = [[UITextField alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [[self class] textFieldWith], 30.0f)];
		_passwordTextField.secureTextEntry = YES;
		_passwordTextField.textColor = [UIColor hipsterBlueColor];
		_passwordTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
		_passwordTextField.delegate = self;
		_passwordTextField.returnKeyType = UIReturnKeyGo;
		_passwordTextField.font = [UIFont hipsterInterfaceFontOfSize:18.0f];
	}
	return _passwordTextField;
}


- (UITextField *)emailTextField {
	if (!_emailTextField) {
		_emailTextField = [[UITextField alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [[self class] textFieldWith], 30.0f)];
		_emailTextField.keyboardType = UIKeyboardTypeEmailAddress;
		_emailTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
		_emailTextField.autocorrectionType = UITextAutocorrectionTypeNo;
		_emailTextField.textColor = [UIColor hipsterBlueColor];
		_emailTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
		_emailTextField.delegate = self;
		_emailTextField.returnKeyType = UIReturnKeyNext;
		_emailTextField.placeholder = @"Your email address";
		_emailTextField.font = [UIFont hipsterInterfaceFontOfSize:18.0f];
	}
	return _emailTextField;
}


#pragma mark - Class Methods

+ (CGFloat)textFieldWith {
	return UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ? 360.0f : 180.0f;
}


#pragma mark - NSObject

- (id)init {
	if ((self = [super initWithStyle:UITableViewStyleGrouped])) {
		self.title = @"Hipster";
//		UIImageView *title = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"nav-title"]];
//		title.frame = CGRectMake(0.0f, 0.0f, 116.0f, 21.0f);
//		self.navigationItem.titleView = title;
	}
	return self;
}


#pragma mark - UIViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	
	UIView *background = [[UIView alloc] initWithFrame:CGRectZero];
	background.backgroundColor = [UIColor hipsterArchesColor];
	self.tableView.backgroundView = background;
    
	_footerButton = [[UIButton alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 34.0f)];
	[_footerButton setTitleColor:[UIColor hipsterBlueColor] forState:UIControlStateNormal];
	[_footerButton setTitleColor:[UIColor hipsterTextColor] forState:UIControlStateHighlighted];
	[_footerButton addTarget:self action:@selector(_toggleMode:) forControlEvents:UIControlEventTouchUpInside];
	_footerButton.titleLabel.font = [UIFont hipsterInterfaceFontOfSize:16.0f];
	self.tableView.tableFooterView = _footerButton;
    
	_signUpMode = NO;
	[self _toggleModeAnimated:NO];
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
    
	// TODO: Terrible hack
	dispatch_async(dispatch_get_main_queue(), ^{
		[self.usernameTextField becomeFirstResponder];
	});
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
		return YES;
	}
	
	return toInterfaceOrientation != UIInterfaceOrientationPortraitUpsideDown;
}


#pragma mark - Actions

- (void)signIn:(id)sender {
	if (!self.navigationItem.rightBarButtonItem.enabled) {
		return;
	}
}


- (void)signUp:(id)sender {
	if (!self.navigationItem.rightBarButtonItem.enabled) {
		return;
	}
	
}


- (void)forgot:(id)sender {
//	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://cheddarapp.com/forgot"]];
}


#pragma mark - Private

- (void)_toggleMode:(id)sender {
	[self _toggleModeAnimated:YES];
}


- (void)_toggleModeAnimated:(BOOL)animated {
	NSArray *email = @[[NSIndexPath indexPathForRow:1 inSection:0]];
    
	BOOL focusPassword = [self.emailTextField isFirstResponder];
	UITableViewRowAnimation animation = animated ? UITableViewRowAnimationTop : UITableViewRowAnimationNone;
    
	// Switch to sign in
	if (_signUpMode) {
		_signUpMode = NO;
        
		[self.tableView beginUpdates];
		[self.tableView deleteRowsAtIndexPaths:email withRowAnimation:animation];
		[self.tableView endUpdates];
        
		[_footerButton setTitle:@"Don't have an account? Sign Up →" forState:UIControlStateNormal];
        
		self.usernameTextField.placeholder = @"Username or email";
		self.passwordTextField.placeholder = @"Your password";
        
		if (focusPassword) {
			[self.passwordTextField becomeFirstResponder];
		}
        
		self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Sign In" style:UIBarButtonItemStylePlain target:self action:@selector(signIn:)];
	}
    
	// Switch to sign up
	else {
		_signUpMode = YES;
        
		[self.tableView beginUpdates];
		[self.tableView insertRowsAtIndexPaths:email withRowAnimation:animation];
		[self.tableView endUpdates];
        
		[_footerButton setTitle:@"Already have an account? Sign In →" forState:UIControlStateNormal];
        
		self.usernameTextField.placeholder = @"Choose a username";
		self.passwordTextField.placeholder = @"Choose a password";
        
		self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Sign Up" style:UIBarButtonItemStylePlain target:self action:@selector(signUp:)];
	}
    
	[self _validateButton];
}


- (void)_configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
	if (indexPath.row == 0) {
		cell.textLabel.text = @"Username";
		cell.accessoryView = self.usernameTextField;
		return;
	}
    
	if (_signUpMode) {
		if (indexPath.row == 1) {
			cell.textLabel.text = @"Email";
			cell.accessoryView = self.emailTextField;
			return;
		}
	}
    
	cell.textLabel.text = @"Password";
	cell.accessoryView = self.passwordTextField;
}


- (void)_validateButton {
	BOOL valid = self.usernameTextField.text.length >= 3 && self.passwordTextField.text.length >= 6;
    
	if (_signUpMode && valid) {
		valid = self.emailTextField.text.length >= 5;
	}
    
	self.navigationItem.rightBarButtonItem.enabled = valid;
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return _signUpMode ? 3 : 2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *const cellIdentifier = @"cellIdentifier";
    
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
	if (!cell) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
		cell.textLabel.textColor = [UIColor hipsterTextColor];
		cell.textLabel.font = [UIFont hipsterInterfaceFontOfSize:18.0f];
	}
    
	[self _configureCell:cell atIndexPath:indexPath];
    
	return cell;
}


#pragma mark - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
	// TODO: Terrible hack #shipit
	dispatch_async(dispatch_get_main_queue(), ^{
		[self _validateButton];
	});
	return YES;
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	if (textField == self.usernameTextField) {
		if (_signUpMode) {
			[self.emailTextField becomeFirstResponder];
		} else {
			[self.passwordTextField becomeFirstResponder];
		}
	} else if (textField == self.emailTextField) {
		[self.passwordTextField becomeFirstResponder];
	} else if (textField == self.passwordTextField) {
		if (_signUpMode) {
			[self signUp:textField];
		} else {
			[self signIn:textField];
		}
	}
	return NO;
}

@end
