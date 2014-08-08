//
//  ListViewController.m
//  test
//
//  Created by Rockstar. on 7/2/14.
//  Copyright (c) 2014 Bnei Baruch. All rights reserved.
//

#import "ListViewController.h"
#import "SignInViewController.h"
#import "CDKUser.h"

NSString *const kCDISelectedListKey = @"HSISelectedListKey";

@interface ListViewController ()
@property (nonatomic, assign) BOOL adding;
@property (nonatomic, assign) BOOL checkForOneList;
- (void)_checkUser;


@end

@implementation ListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIImageView *title = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"nav-title"]];
    title.accessibilityLabel = @"Cheddar";
	title.frame = CGRectMake(0.0f, 0.0f, 116.0f, 21.0f);
	self.navigationItem.titleView = title;
	self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Lists" style:UIBarButtonItemStyleBordered target:nil action:nil];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"plus"] style:UIBarButtonItemStyleBordered target:self action:@selector(createList:)];
    
    [self setEditing:NO animated:NO];
    
//    self.noContentView = [[CDIListsPlaceholderView alloc] initWithFrame:CGRectZero];
    
	UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 50.0f)];
	footer.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
    UIView *shadow = self.tableView.tableFooterView;
	self.tableView.tableFooterView = footer;
	shadow.frame = CGRectMake(0.0f, 0.0f, 320.0f, 3.0f);
	[footer addSubview:shadow];
    
//	_archiveButton = [[CDIViewArchiveButton alloc] initWithFrame:CGRectMake(20.0f, 12.0f, 280.0f, 32.0)];
//	_archiveButton.alpha = 0.0f;
//	[footer addSubview:_archiveButton];
    
    

}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
		[self _checkUser];
	}
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
		[self _checkUser];
	}
	
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
	[super setEditing:editing animated:animated];
	
	if (editing) {
		self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleBordered target:self action:@selector(toggleEditMode:)];
		self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Settings" style:UIBarButtonItemStyleBordered target:self action:@selector(showSettings:)];
	} else {
		self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Edit" style:UIBarButtonItemStyleBordered target:self action:@selector(toggleEditMode:)];
        self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
		self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"plus"] style:UIBarButtonItemStyleBordered target:self action:@selector(createList:)];
        self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
	}
    
#pragma message("Need to update")
//	if (!editing && UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
//		[self.tableView selectRowAtIndexPath:[self.fetchedResultsController indexPathForObject:_selectedList] animated:YES scrollPosition:UITableViewScrollPositionNone];
//	}
}



#pragma mark - Gestures

- (BOOL)_shouldEditRowForGesture:(UIGestureRecognizer *)gestureRecognizer {
    BOOL didLongPressGestureSucceed = [gestureRecognizer isKindOfClass:[UITapGestureRecognizer class]] && gestureRecognizer.state == UIGestureRecognizerStateEnded;
    BOOL didTapGestureSucceed = [gestureRecognizer isKindOfClass:[UILongPressGestureRecognizer class]] && gestureRecognizer.state == UIGestureRecognizerStateBegan;
    return didTapGestureSucceed || didLongPressGestureSucceed;
}


- (void)_beginEditingWithGesture:(UIGestureRecognizer *)gestureRecognizer {
    if ([self _shouldEditRowForGesture:gestureRecognizer]) {
        if (![self isEditing]) {
            [self setEditing:YES animated:YES];
        }
        
        //[self editRow:gestureRecognizer];
    }
}


- (NSPredicate *)predicate {
	return [NSPredicate predicateWithFormat:@"archivedAt = nil && user = %@", [CDKUser currentUser]];
}

#pragma mark - Private

- (void)_checkUser {
	if (![CDKUser currentUser]) {
		UIViewController *viewController = [[SignInViewController alloc] init];
		UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
		navigationController.modalPresentationStyle = UIModalPresentationFormSheet;
		
		if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            [self.splitViewController presentViewController:navigationController animated:YES completion:nil];
		} else {
            
            [self.navigationController presentViewController:navigationController animated:NO completion:nil];
		}
		return;
	}
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	NSInteger rows = [super tableView:tableView numberOfRowsInSection:section];
    
	if (_adding) {
		return rows + 1;
	}
	
	return rows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *const cellIdentifier = @"cellIdentifier";
	static NSString *const addCellIdentifier = @"addCellIdentifier";
    
	if (_adding && indexPath.row == 0) {
		UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:addCellIdentifier];
		if (!cell) {
			cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:addCellIdentifier];
		}
        
		return cell;
	}
    
	UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
	if (!cell) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
	}
	
//	cell.list = [self objectForViewIndexPath:indexPath];
	
	return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_adding) {
        return NO;
    }
    
    return YES;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

}


- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
	if (sourceIndexPath.row == destinationIndexPath.row) {
		return;
	}
	
//	self.ignoreChange = YES;
//	NSMutableArray *lists = [self.fetchedResultsController.fetchedObjects mutableCopy];
//	CDKList *list = [self objectForViewIndexPath:sourceIndexPath];
//	[lists removeObject:list];
//	[lists insertObject:list atIndex:destinationIndexPath.row];
//	
//	NSInteger i = 0;
//	for (list in lists) {
//		list.position = [NSNumber numberWithInteger:i++];
//	}
//	
//	[self.managedObjectContext save:nil];
//	self.ignoreChange = NO;
//	
//	[CDKList sortWithObjects:lists];
}


- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
	return @"Archive";
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
	if (editingStyle != UITableViewCellEditingStyleDelete) {
		return;
	}
	
//	CDKList *list = [self objectForViewIndexPath:indexPath];
//	
//	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
//		CDITasksViewController *listViewController = [CDISplitViewController sharedSplitViewController].listViewController;
//		if ([listViewController.managedObject isEqual:list]) {
//			listViewController.managedObject = nil;
//		}
//	}
//	
//	list.archivedAt = [NSDate date];
//	[list save];
//	[list update];
}


- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
//	if ([cell isKindOfClass:[CDIAddListTableViewCell class]]) {
//		dispatch_async(dispatch_get_main_queue(), ^{
//			[[(CDIAddListTableViewCell *)cell textField] becomeFirstResponder];
//		});
//	}
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
	if (_adding) {
//		[self _cancelAddingList:scrollView];
	}
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	if (_adding) {
//		[self _createList:textField];
		return NO;
	}
    
//	CDKList *list = [self objectForViewIndexPath:self.editingIndexPath];
//	list.title = textField.text;
//	[list save];
//	[list update];
//	
//	[self endCellTextEditing];
	return NO;
}


- (void)textFieldDidEndEditing:(UITextField *)textField {
	if (_adding) {
//		[self _cancelAddingList:textField];
	}
}



@end
