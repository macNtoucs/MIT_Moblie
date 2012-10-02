//
//  CameraViewController.m
//  MIT Mobile
//
//  Created by R MAC on 12/10/2.
//
//

#import "CameraViewController.h"

@interface CameraViewController ()

@end

@implementation CameraViewController
@synthesize imagePicker;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        hasCamera=YES;
    }else {
        hasCamera=NO;
    }
    imagePicker = [UIImagePickerController new];
    imagePicker.delegate = self;
    imagePicker.sourceType=UIImagePickerControllerCameraCaptureModePhoto;
    [self presentModalViewController:imagePicker animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
