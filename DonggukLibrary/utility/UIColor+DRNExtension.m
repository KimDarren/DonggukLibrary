//
//  UIColor+DRNExtension.m
//  DonggukLibrary
//
//  Created by 1001246 on 2015. 6. 7..
//  Copyright (c) 2015년 USAIU. All rights reserved.
//

#import "UIColor+DRNExtension.h"

@implementation UIColor (DRNExtension)

+ (UIColor *)drn_darkGrayColor
{
    return [UIColor colorWithHexString:@"3b3b3b"];
}

+ (UIColor *)drn_darkOrangeColor
{
    return [UIColor colorWithHexString:@"f15a28"];
}

+ (UIColor *)drn_orangeColor
{
    return [UIColor colorWithHexString:@"f7901d"];
}

+ (UIColor *)drn_yellowColor
{
    return [UIColor colorWithHexString:@"febe0e"];
}

+ (UIColor *)colorWithHexString:(NSString *)hexString
{
    return [self colorWithHexString:hexString alpha:1.0f];
}

+ (UIColor *)colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha
{
    if('#' != [hexString characterAtIndex:0])
        hexString = [NSString stringWithFormat:@"#%@", hexString];
    
    // check for string length
    assert(7 == hexString.length || 4 == hexString.length);
    
    // check for 3 character HexStrings
    hexString = [self hexStringTransformFromThreeCharacters:hexString];
    
    NSString *redHex    = [NSString stringWithFormat:@"0x%@", [hexString substringWithRange:NSMakeRange(1, 2)]];
    unsigned redInt = [self hexValueToUnsigned:redHex];
    
    NSString *greenHex  = [NSString stringWithFormat:@"0x%@", [hexString substringWithRange:NSMakeRange(3, 2)]];
    unsigned greenInt = [self hexValueToUnsigned:greenHex];
    
    NSString *blueHex   = [NSString stringWithFormat:@"0x%@", [hexString substringWithRange:NSMakeRange(5, 2)]];
    unsigned blueInt = [self hexValueToUnsigned:blueHex];
    
    UIColor *color = [UIColor colorWith8BitRed:redInt green:greenInt blue:blueInt alpha:alpha];
    
    return color;
}

+ (UIColor *)colorWith8BitRed:(NSInteger)red green:(NSInteger)green blue:(NSInteger)blue
{
    return [self colorWith8BitRed:red green:green blue:blue alpha:1.0f];
}

+ (UIColor *)colorWith8BitRed:(NSInteger)red green:(NSInteger)green blue:(NSInteger)blue alpha:(CGFloat)alpha
{
    UIColor *color = [UIColor colorWithRed:(float)red/255 green:(float)green/255 blue:(float)blue/255 alpha:alpha];
    return color;
}

+ (NSString *)hexStringTransformFromThreeCharacters:(NSString *)hexString
{
    if(hexString.length == 4)
    {
        hexString = [NSString stringWithFormat:@"#%@%@%@%@%@%@",
                     [hexString substringWithRange:NSMakeRange(1, 1)],[hexString substringWithRange:NSMakeRange(1, 1)],
                     [hexString substringWithRange:NSMakeRange(2, 1)],[hexString substringWithRange:NSMakeRange(2, 1)],
                     [hexString substringWithRange:NSMakeRange(3, 1)],[hexString substringWithRange:NSMakeRange(3, 1)]];
    }
    
    return hexString;
}

+ (unsigned)hexValueToUnsigned:(NSString *)hexValue
{
    unsigned value = 0;
    
    NSScanner *hexValueScanner = [NSScanner scannerWithString:hexValue];
    [hexValueScanner scanHexInt:&value];
    
    return value;
}

@end
