//
//  InputHandler.m
//  mc3
//
//  Created by André Carneiro on 12/09/18.
//  Copyright © 2018 André Carneiro. All rights reserved.
//

#import "InputHandler.h"

@implementation InputHandler

- (instancetype) initWith:(InputScheme *)inputScheme {
    self = [super init];
    
    self.inputScheme = inputScheme;
    
    return self;
}

@end
