//
//  ImageData.h
//  firstGame
//
//  Created by apple on 14-3-16.
//
//

#import <Foundation/Foundation.h>

@interface ImageData : NSObject<UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate>
@property(retain,nonatomic)NSData * data;
-(void)chooseImage;
-(void)takePhone;
-(void)takePhoneLibrary;
@end
