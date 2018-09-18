//
//  KeyboardInputHandler.m
//  mc3-macos
//
//  Created by André Carneiro on 14/09/18.
//  Copyright © 2018 André Carneiro. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KeyboardInputHandler.h"
#import <CoreGraphics/CoreGraphics.h>

@interface KeyboardInputHandler ()
    @property (nonatomic, strong, readwrite) NSDictionary* translator;
@end

@implementation KeyboardInputHandler

- (instancetype) init {
    self = [super init];
    return self;
}
- (instancetype) initWith:(InputScheme *)inputScheme {
    self = [super initWith:inputScheme];
    
    self.translator = @{
                        @(ButtonA): @(S),
                        @(ButtonB): @(D),
                        @(ButtonX): @(F),
                        @(ButtonY): @(G),
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
    
//    NSLog(@"keyCode: 0x%02X", keycode);
    int label = [self getButtonLabel:keycode];
    if (label==-1) return;

    switch (label) {
        case ButtonA:
            [self.inputScheme pressButtonA];
//            NSLog(@"%@", @"Button A");
            break;
        case ButtonB:
            [self.inputScheme pressButtonB];
//            NSLog(@"%@", @"Button B");
            break;
        case ButtonX:
            [self.inputScheme pressButtonX];
//            NSLog(@"%@", @"Button X");
            break;
        case ButtonY:
            [self.inputScheme pressButtonY];
//            NSLog(@"%@", @"Button Y");
            break;
        case UpBtn:
            [self.inputScheme pressButtonUp];
//            NSLog(@"%@", @"Up");
            break;
        case DownBtn:
            [self.inputScheme pressButtonDown];
//            NSLog(@"%@", @"Down");
            break;
        case LeftBtn:
            [self.inputScheme pressButtonLeft];
//            NSLog(@"%@", @"Left");
            break;
        case RightBtn:
            [self.inputScheme pressButtonRight];
//            NSLog(@"%@", @"Right");
            break;

        default:
            break;
    }
    [self print];
    
}

- (void) handleKeyUp:(int)keycode {
    int label = [self getButtonLabel:keycode];
    
    if (label==-1) return;
    
    switch (label) {
        case ButtonA:
            [self.inputScheme releaseButtonA];
//            NSLog(@"%@", @"Button A");
            break;
        case ButtonB:
            [self.inputScheme releaseButtonB];
//            NSLog(@"%@", @"Button B");
            break;
        case ButtonX:
            [self.inputScheme releaseButtonX];
//            NSLog(@"%@", @"Button X");
            break;
        case ButtonY:
            [self.inputScheme releaseButtonY];
//            NSLog(@"%@", @"Button Y");
            break;
        case UpBtn:
            [self.inputScheme releaseButtonUp];
//            NSLog(@"%@", @"Up");
            break;
        case DownBtn:
            [self.inputScheme releaseButtonDown];
//            NSLog(@"%@", @"Down");
            break;
        case LeftBtn:
            [self.inputScheme releaseButtonLeft];
//            NSLog(@"%@", @"Left");
            break;
        case RightBtn:
            [self.inputScheme releaseButtonRight];
//            NSLog(@"%@", @"Right");
            break;
            
        default:
            break;
    }
    
    
}

@end
