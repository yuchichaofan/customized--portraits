//
//  ImageData.m
//  firstGame
//
//  Created by apple on 14-3-16.
//
//

#import "ImageData.h"
#import "UIImagePickerController+Nonrotating.h"
#import "Mask.h"

@implementation ImageData
-(void)dealloc{
    [super dealloc];
}
-(id)init{
   self = [super init];
    if (self) {
    }
    return self;
}

-(void)chooseImage
{
    UIActionSheet * actionSheet =  [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"手机拍照" otherButtonTitles:@"手机相册", nil];
     [actionSheet showInView:[[[UIApplication sharedApplication].windows objectAtIndex:0] rootViewController].view];
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
            [self takePhone];
            break;
        case 1:
            [self takePhoneLibrary];
            break;
        default:
            break;
    }
}
-(void)takePhone
{
 if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController * imagePicker = [[[UIImagePickerController alloc]init]autorelease];
        [imagePicker setEditing:YES animated:YES];
        [imagePicker setSourceType:UIImagePickerControllerSourceTypeCamera];
        [imagePicker setDelegate:self];
        [[[[UIApplication sharedApplication].windows objectAtIndex:0] rootViewController] presentViewController:imagePicker animated:YES completion:nil];
    }else{
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"相机不可用" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
        
    }
}

-(void)takePhoneLibrary
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        UIImagePickerController * imagePicker = [[[UIImagePickerController alloc]init]autorelease];
        [imagePicker setEditing:YES animated:YES];
        [imagePicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        [imagePicker setDelegate:self];
        [[[[UIApplication sharedApplication].windows objectAtIndex:0] rootViewController] presentViewController:imagePicker animated:YES completion:nil];
    }else{
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"相册不可用" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
    }
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    
    UIImage * image = [info objectForKey:UIImagePickerControllerOriginalImage];
    //保存图片
//    UIImageWriteToSavedPhotosAlbum(image, nil, nil , nil);
//    NSData * data = UIImagePNGRepresentation(image);
    NSData * data = UIImageJPEGRepresentation(image, 0.001);
    void * datapoint = (void *)[data bytes];
    unsigned int length = [data length];
    CCImage * _image = new CCImage();
    _image->initWithImageData(datapoint, length);
    CCNode * node = new CCNode();
    node->setUserObject(_image);
    [[[[UIApplication sharedApplication].windows objectAtIndex:0] rootViewController] dismissViewControllerAnimated:true completion:^{
        CCNotificationCenter::sharedNotificationCenter()->postNotification("shao", node);
    }];
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [[[[UIApplication sharedApplication].windows objectAtIndex:0] rootViewController] dismissModalViewControllerAnimated:true];
}

@end
