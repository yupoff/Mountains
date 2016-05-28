//
//  UIFont+MountainsFont.m
//  Mountains
//
//  Created by Тимур Аюпов on 09.05.16.
//  Copyright © 2016 Тимур Аюпов. All rights reserved.
//

#import "UIFont+MountainsFont.h"

@implementation UIFont (MountainsFont)

+ (UIFont *)mountainsHelveticaNeueLightFontOfSize:(CGFloat)size
{
    return [UIFont fontWithName:@"HelveticaNeue-Light"
                           size:size];
}
#pragma mark - Style fonts

+ (UIFont *)mountainsFontHelveticaNeueLight14
{
    return [self mountainsHelveticaNeueLightFontOfSize:14.f];
}
+ (UIFont *)mountainsFontHelveticaNeueLight12
{
    return [self mountainsHelveticaNeueLightFontOfSize:12.f];
}

+ (UIFont *)mountainsFontHelveticaNeueLight18
{
    return [self mountainsHelveticaNeueLightFontOfSize:18.f];
}

@end
