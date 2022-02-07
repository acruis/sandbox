//
//  ViewController.m
//  FunctionCallValueTransform
//
//  Created by Nguyen Quoc Dat on 11/9/21.
//

#import "ViewController.h"
#import "MMFile.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [MMFile expectTwoNumbersSmallNumberOne:1201520507 numberTwo:48604582937378817];
}

@end
