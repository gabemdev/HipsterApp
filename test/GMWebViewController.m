//
//  GMWebViewController.m
//  Hipster
//
//  Created by Rockstar. on 8/18/14.
//  Copyright (c) 2014 Bnei Baruch. All rights reserved.
//

#import "GMWebViewController.h"
#import "UIColor+HipsteriOSAdditions.h"

@interface GMWebViewController ()
- (void)_updateBrowserUI;
@end

@implementation GMWebViewController {
    NSURL *_url;
    UIActivityIndicatorView *_indicator;
    UIBarButtonItem *_backBarButton;
    UIBarButtonItem *_forwardBarButton;
    UIBarButtonItem *_reloadBarButton;
    UIBarButtonItem *_shareBarButton;
}

@synthesize webView = _webView;

#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    
    _indicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 22.0f, 22.0f)];
    _indicator.hidesWhenStopped = YES;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_indicator];
    
    _webView = [[GMWebView alloc] initWithFrame:self.view.bounds];
    _webView.backgroundColor = [UIColor hipsterStaticColor];
    _webView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _webView.delegate = self;
    _webView.scalesPageToFit = YES;
    [_webView loadURL:_url];
    [self.view addSubview:_webView];
    
    _backBarButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back-button"] landscapeImagePhone:[UIImage imageNamed:@"back-button-mini"] style:UIBarButtonItemStylePlain target:_webView action:@selector(goBack)];
    _backBarButton.tintColor = [UIColor whiteColor];
    
    _forwardBarButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"forward-button"] landscapeImagePhone:[UIImage imageNamed:@"forward-button-mini"] style:UIBarButtonItemStylePlain target:_webView action:@selector(goForward)];
    _forwardBarButton.tintColor = [UIColor whiteColor];
    
    _reloadBarButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"safari-button"] landscapeImagePhone:[UIImage imageNamed:@"safari-button-mini"] style:UIBarButtonItemStylePlain target:self action:@selector(openSafari:)];
    _reloadBarButton.tintColor = [UIColor whiteColor];
    
    _shareBarButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"action-button"] landscapeImagePhone:[UIImage imageNamed:@"action-button-mini"] style:UIBarButtonItemStylePlain target:self action:@selector(openActionSheet:)];
    _shareBarButton.tintColor = [UIColor whiteColor];
    
    UIBarButtonItem *flex = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    self.navigationController.toolbar.tintColor = [UIColor whiteColor];
    self.toolbarItems = [NSArray arrayWithObjects:
                         _backBarButton,
                         flex,
                         _forwardBarButton,
                         flex,
                         _reloadBarButton,
                         flex,
                         _shareBarButton,
                         nil];
    
    for (UIBarButtonItem *button in self.toolbarItems) {
        button.imageInsets = UIEdgeInsetsMake(3.0f, 0.0f, 0.0f, 0.0f);
    }
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"close" style:UIBarButtonItemStyleBordered target:self action:@selector(close:)];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (![_url isFileURL]) {
        [self.navigationController setToolbarHidden:NO animated:animated];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.navigationController setToolbarHidden:YES animated:animated];
}

#pragma mark - URL Loading

- (void)loadURL:(NSURL *)url {
    _url = url;
}

- (NSURL *)currentURL {
    NSURL *url = _webView.lastRequest.mainDocumentURL;
    if (!url) {
        url = _url;
    }
    
    return url;
}

#pragma mark - Actions

- (void)close:(id)sender {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)openSafari:(id)sender {
    [[UIApplication sharedApplication] openURL:self.currentURL];
}

- (void)openActionSheet:(id)sender {
    UIActionSheet *actionSheet = nil;
    
    if ([MFMailComposeViewController canSendMail] == NO) {
        actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Copy URL", nil];
    } else {
        actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Copy URL", @"Email URL", nil];
    }
    
    actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
    [actionSheet showInView:self.navigationController.view];
}

- (void)copyURL:(id)sender {
    [[UIPasteboard generalPasteboard] setURL:self.currentURL];
}

- (void)emailURL:(id)sender {
    if ([MFMailComposeViewController canSendMail] == NO) {
        return;
    }
    
    MFMailComposeViewController *viewController = [[MFMailComposeViewController alloc] init];
    viewController.mailComposeDelegate = self;
    [viewController setSubject:self.title];
    [viewController.navigationBar setTintColor:[UIColor whiteColor]];
    [viewController setMessageBody:_webView.lastRequest.mainDocumentURL.absoluteString isHTML:YES];
    [self.navigationController presentViewController:viewController animated:YES completion:^{
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    }];
    
}

#pragma mark - Private

- (void)_updateBrowserUI {
    _backBarButton.enabled = [_webView canGoBack];
    _forwardBarButton.enabled = [_webView canGoForward];
    
    UIBarButtonItem *reloadButton = nil;
    
    if ([_webView isLoadingPage]) {
        [_indicator startAnimating];
        reloadButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"stop-button"] landscapeImagePhone:[UIImage imageNamed:@"stop-button-mini"] style:UIBarButtonItemStylePlain target:_webView action:@selector(stopLoading)];
    } else {
        [_indicator stopAnimating];
        reloadButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"reload-button"] landscapeImagePhone:[UIImage imageNamed:@"reload-button-mini"] style:UIBarButtonItemStylePlain target:_webView action:@selector(reload)];
    }
    reloadButton.imageInsets = UIEdgeInsetsMake(3.0f, 0.0f, 0.0f, 0.0f);
    
    NSMutableArray *items = [self.toolbarItems mutableCopy];
    [items replaceObjectAtIndex:4 withObject:reloadButton];
    self.toolbarItems = items;
}

#pragma mark - GMWebVieDelegate

- (void)webViewDidStartLoadingPage:(GMWebView *)aWebView {
    NSURL *url = _webView.lastRequest.mainDocumentURL;
    self.title = url.absoluteString;
    [self _updateBrowserUI];
    
    [self.navigationController setToolbarHidden:[url isFileURL] animated:YES];
}

- (void)webViewDidLoadDOM:(GMWebView *)aWebView {
    NSString *title = [_webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    if (title && title.length > 0) {
        self.title = title;
    }
}

- (void)webViewDidFinishLoadingPage:(GMWebView *)aWebView {
    [self _updateBrowserUI];
}

#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        [self copyURL:actionSheet];
    } else if (buttonIndex == 1 && [MFMailComposeViewController canSendMail]) {
        [self emailURL:actionSheet];
    }
}

#pragma mark - MFMailComposeViewControllerDelegate

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    [controller dismissViewControllerAnimated:YES completion:nil];
    
    if (result == MFMailComposeResultSent) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sent" message:nil delegate:self cancelButtonTitle:@"Done" otherButtonTitles:nil, nil];
        [alert show];
    }
}

@end
