//
//  KeyboardInputHandler.m
//  mc3-macos
//
//  Created by André Carneiro on 14/09/18.
//  Copyright © 2018 André Carneiro. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KeyboardInputHandler.h"

@interface KeyboardInputHandler ()
    @property (nonatomic, strong, readwrite) NSDictionary* translator;
@end

@implementation KeyboardInputHandler

- (instancetype) init {
    self = [super init];
    
    self.translator = @{
                        @(ButtonA): @(S),
                        @(ButtonB): @(D),
                        @(ButtonX): @(X),
                        @(ButtonY): @(C),
                        @(UpBtn): @(Up),
                        @(DownBtn): @(Down),
                        @(LeftBtn): @(Left),
                        @(RightBtn): @(Right)
                        };
    
    return self;
}

- (int) getButtonLabel:(NSInteger)keycode {
    NSArray* labels = [self.translator allKeysForObject:@(keycode)];
    if ([labels count] == 1) {
        return [labels[0] intValue];
    }
    
    return -1;
}

- (void) handleKeyDown:(int)keycode {
//    NSLog(@"%@", [self getButtonLabel:keycode]);
    
    int label = [self getButtonLabel:keycode];
    
    if (label==-1) return;
    
    switch (label) {
        case ButtonA:
            NSLog(@"%@", @"Button A");
            break;
        case ButtonB:
            NSLog(@"%@", @"Button B");
            break;
        case ButtonX:
            NSLog(@"%@", @"Button X");
            break;
        case ButtonY:
            NSLog(@"%@", @"Button Y");
            break;
        case UpBtn:
            NSLog(@"%@", @"Up");
            break;
        case DownBtn:
            NSLog(@"%@", @"Down");
            break;
        case LeftBtn:
            NSLog(@"%@", @"Left");
            break;
        case RightBtn:
            NSLog(@"%@", @"Right");
            break;
            
        default:
            break;
    }
    
}

- (void) handleKeyUp:(int)keycode {
//    NSLog(@"%@", [self getButtonLabel:keycode]);
}

@end
