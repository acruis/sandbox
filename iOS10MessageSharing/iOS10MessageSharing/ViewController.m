//
//  ViewController.m
//  iOS10MessageSharing
//
//  Created by Nguyen Quoc Dat on 8/6/21.
//

#import "ViewController.h"
#import <MessageUI/MessageUI.h>
#import <MobileCoreServices/MobileCoreServices.h>

@interface ViewController () <MFMessageComposeViewControllerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];

    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:@"Open message VC" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(openMessageVC) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(100, 100, 100, 100);

    [self.view addSubview:button];
}

- (void)openMessageVC
{
    UIImage *icon = [UIImage imageNamed:@"wiki-logo"];
    NSData *iconData = UIImageJPEGRepresentation(icon, 1);

    NSString *pathToResource = [[NSBundle mainBundle] pathForResource:@"wiki_logo" ofType:@"jpeg"];
    NSLog(@"[nguyenqd] %s:%d %s pathToResource %@", __FILE__, __LINE__, __FUNCTION__, pathToResource);
    NSData *dataAtPath = [NSData dataWithContentsOfFile:pathToResource];
    NSLog(@"[nguyenqd] %s:%d %s dataAtPath.length %@", __FILE__, __LINE__, __FUNCTION__, @(dataAtPath.length));

    NSURL *URLPath = [NSURL URLWithString:pathToResource];

    MFMessageComposeViewController *messageVC = [[MFMessageComposeViewController alloc] init];
    messageVC.messageComposeDelegate = self;
    [messageVC addAttachmentData:dataAtPath typeIdentifier:(NSString *)kUTTypeJPEG filename:@"attachment_image.jpeg"];
//    [messageVC addAttachmentURL:URLPath withAlternateFilename:@"attachment_image.jpeg"];
    [messageVC setBody:@"Message body"];

    [self presentViewController:messageVC animated:YES completion:^{

    }];
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    [self dismissViewControllerAnimated:YES completion:^{

    }];
}


@end
