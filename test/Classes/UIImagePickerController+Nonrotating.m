//
//  UIImagePickerController+Nonrotating.m
//  firstGame
//
//  Created by apple on 14-3-16.
//
//

#import "UIImagePickerController+Nonrotating.h"

@implementation UIImagePickerController (Nonrotating)
-(BOOL)shouldAutorotate
{
    return NO;
    //如果需要横竖屏适应需要设置yes
//    return YES;
}
@end
