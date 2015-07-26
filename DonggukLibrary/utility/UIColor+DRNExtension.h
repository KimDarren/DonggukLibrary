//
//  UIColor+DRNExtension.h
//  DonggukLibrary
//
//  Created by 1001246 on 2015. 6. 7..
//  Copyright (c) 2015년 USAIU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (DRNExtension)

+ (UIColor *)drn_darkGrayColor;
+ (UIColor *)drn_darkOrangeColor;
+ (UIColor *)drn_orangeColor;
+ (UIColor *)drn_yellowColor;

+ (UIColor *)colorWithHexString:(NSString *)hexString;
+ (UIColor *)colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha;

+ (UIColor *)colorWith8BitRed:(NSInteger)red green:(NSInteger)green blue:(NSInteger)blue;
+ (UIColor *)colorWith8BitRed:(NSInteger)red green:(NSInteger)green blue:(NSInteger)blue alpha:(CGFloat)alpha;

@end
