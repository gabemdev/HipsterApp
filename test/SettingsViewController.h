//
//  SettingsViewController.h
//  Hipster
//
//  Created by Rockstar. on 8/13/14.
//  Copyright (c) 2014 Bnei Baruch. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *const kCDIFontDidChangeNotificationName;

@interface SettingsViewController : UITableViewController

- (void)close:(id)sender;
- (void)upgrade:(id)sender;
- (void)signOut:(id)sender;

@end
