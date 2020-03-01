//
//  UIImage+ColorPicker.h
//  hashBook
//
//  Created by Nikunj Prajapati on 15/02/20.
//  Copyright © 2020 Nikunj Prajapati. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@interface UIImage (ColorPicker)

- (UIColor *)pickColorWithPoint:(CGPoint)point;
- (CGPoint)convertPoint:(CGPoint)viewPoint fromImageView:(__kindof UIImageView *)imageView;

@end
NS_ASSUME_NONNULL_END
