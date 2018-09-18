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

- (void) print {
    NSLog(@"\n#######################################\nButton A: %@",self.inputScheme.buttonA ? @"Yes" : @"No");
    NSLog(@"Button B: %@",self.inputScheme.buttonB ? @"Yes" : @"No");
    NSLog(@"Button X: %@",self.inputScheme.buttonX ? @"Yes" : @"No");
    NSLog(@"Button Y: %@",self.inputScheme.buttonY ? @"Yes" : @"No");
    
    NSLog(@"Button Left: %@",self.inputScheme.left ? @"Yes" : @"No");
    NSLog(@"Button Right: %@",self.inputScheme.right ? @"Yes" : @"No");
    NSLog(@"Button Up: %@",self.inputScheme.up ? @"Yes" : @"No");
    NSLog(@"Button Down: %@",self.inputScheme.down ? @"Yes" : @"No");
}

@end
