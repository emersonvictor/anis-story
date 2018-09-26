//
//  Categories.m
//  mc3
//
//  Created by Gabriel D'Luca on 19/09/18.
//  Copyright © 2018 Gabriel D'Luca. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSInteger {
    PlatformCategory = 0x1<<0,
    PlayerCategory = 0x1<<1,
    NonInteractiveCategory = 0x1<<2,
    InteractiveCategory = 0x1<<3
} Categories;
