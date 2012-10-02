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

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    //取得影像
    UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    
    //將影像縮小顯示於畫面中央（原圖是480*960）
    UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
    [imageView setFrame:CGRectMake(0.0, 0.0, 160.0, 240.0)];
    [imageView setCenter:self.view.center];
    
    [self.view addSubview:imageView];
    
    //移除Picker
    [picker dismissModalViewControllerAnimated:YES];
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
    imagePicker.sourceType=UIImagePickerControllerSourceTypeCamera;
    [self presentModalViewController:imagePicker animated:YES];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
