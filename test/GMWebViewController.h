//
//  GMWebViewController.h
//  Hipster
//
//  Created by Rockstar. on 8/18/14.
//  Copyright (c) 2014 Bnei Baruch. All rights reserved.
//

#import <MessageUI/MessageUI.h>
#import "GMWebView.h"

@interface GMWebViewController : UIViewController <GMWebViewDelegate, UIActionSheetDelegate, MFMailComposeViewControllerDelegate>

@property (nonatomic, strong) GMWebView *webView;

- (void)loadURL:(NSURL *)url;
- (NSURL *)currentURL;

- (void)close:(id)sender;
- (void)openSafari:(id)sender;
- (void)openActionSheet:(id)sender;
- (void)copyURL:(id)sender;
- (void)emailURL:(id)sender;


@end
