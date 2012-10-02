//
//  CameraViewController.h
//  MIT Mobile
//
//  Created by R MAC on 12/10/2.
//
//

#import <UIKit/UIKit.h>

@interface CameraViewController : UIViewController <UIImagePickerControllerDelegate>{
    UIImagePickerController * imagePicker;
    bool hasCamera;
}
@property (nonatomic, retain) UIImagePickerController * imagePicker;
@end
