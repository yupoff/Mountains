//
//  UIColor+MountainsColor.m
//  Mountains
//
//  Created by Тимур Аюпов on 09.05.16.
//  Copyright © 2016 Тимур Аюпов. All rights reserved.
//

#import "UIColor+MountainsColor.h"

@implementation UIColor (MountainsColor)

+ (UIColor *)mountainsWhite
{

    return [UIColor colorWithRed:223.0f / 255.0f
                           green:255.0f / 255.0f
                            blue:255.0f / 255.0f
                           alpha:1.0f];
}

+ (UIColor *)mountainsRed
{

    return [UIColor colorWithRed:241.0f / 255.0f
                           green:64.0f / 255.0f
                            blue:75.0f / 255.0f
                           alpha:1.0f];
}

+ (UIColor *)mountainsBlue
{

    return [UIColor colorWithRed:0.0f / 255.0f
                           green:114.0f / 255.0f
                            blue:188.0f / 255.0f
                           alpha:1.0f];
}

+ (UIColor *)mountainsTransparentGray
{

    return [UIColor colorWithRed:216.0f / 255.0f
                           green:216.0f / 255.0f
                            blue:216.0f / 255.0f
                           alpha:0.25f];
}

@end
