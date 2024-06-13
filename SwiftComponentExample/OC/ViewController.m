//
//  ViewController.m
//  OC
//
//  Created by Jingfu Li on 2024/6/12.
//

#import "ViewController.h"
#import "AudioHelper.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    NSString *path = [NSBundle.mainBundle pathForResource:@"Chasing Dreams" ofType:@"mp3"];

    NSString *toPath = [NSHomeDirectory() stringByAppendingString:@"/result"];

    [AudioHelper covertMP3ToPCM:path pcmFile:toPath];

    NSLog(@"end\n");
}


@end
