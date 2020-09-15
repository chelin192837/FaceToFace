//
//  ANTLoadingView.m
//  Antelope
//
//  Created by mac on 2020/1/14.
//  Copyright © 2020 qsm. All rights reserved.
//

#import "ANTLoadingView.h"

@implementation ANTLoadingView

+(instancetype)initWithNib
{
    return [[NSBundle mainBundle] loadNibNamed:@"ANTLoadingView" owner:nil options:nil][0];
}

@end
