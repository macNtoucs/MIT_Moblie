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
    
    //建立物件與指定代理
    MFMailComposeViewController *controller = [[MFMailComposeViewController alloc] init];
    controller.mailComposeDelegate = self;
    
    //設定收件人與主旨等資訊
    [controller setToRecipients:[NSArray arrayWithObjects:@"給所有讀者", @"還有我自己", nil]];
    [controller setSubject:@"緊急事件"];
    
    //設定內文並且不使用HTML語法
    [controller setMessageBody:@"[照片]" isHTML:NO];
    
    //加入圖片
   // UIImage *theImage = [UIImage imageNamed:@"image.png"];
    NSData *imageData = UIImagePNGRepresentation(image);
    [controller addAttachmentData:imageData mimeType:@"image/png" fileName:@"image"];
    
    //顯示電子郵件畫面
    [self presentModalViewController:controller animated:YES];
    
    [controller release];
    
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
