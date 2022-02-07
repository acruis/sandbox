//
//  ViewController.m
//  CaseSensitiveKeyAccess
//
//  Created by Nguyen Quoc Dat on 22/7/21.
//

#import "ViewController.h"

static NSString * const kHeaderName = @"Some-Header";

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSDictionary *headersDict = @{
        @"headerA": @"valueA",
        @"headerB": @"valueB",
        @"SoMe-HeAdEr": @"valueC"
    };

    NSLog(@"%@", [self caseInsensitiveValue:headersDict]);

    NSMutableDictionary *someDictionary = [NSMutableDictionary dictionary];
    someDictionary[@"a"] = @"a value";
    someDictionary[nil] = @"another value";
}

- (NSString *)caseInsensitiveValue:(NSDictionary *)headers
{
    NSString *lowercasedInjectionHeader = [kHeaderName lowercaseString];

    for (id headerKey in headers.allKeys) {
        if (![headerKey isKindOfClass:[NSString class]]) {
            continue;
        }

        NSString *headerName = (NSString *)headerKey;

        if (![[headerName lowercaseString] isEqualToString:lowercasedInjectionHeader]) {
            continue;
        }

        return headers[headerKey];
    }

    return nil;
}

@end
