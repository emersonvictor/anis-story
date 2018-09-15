//
//  GameController.m
//  mc3
//
//  Created by André Carneiro on 12/09/18.
//  Copyright © 2018 André Carneiro. All rights reserved.
//

#import "GameController.h"

@implementation GameController

- (instancetype) init {
    self = [super init];
    self.inputScheme = [InputScheme new];
    
//    Keyboard handler
#if TARGET_OS_OSX
    self.keyboardInputHandler = [KeyboardInputHandler new];
#endif
    
    return self;
}


//MARK: - Keyboard Logic
#if TARGET_OS_OSX
- (void)handleKeyDown:(NSEvent *)event {
    
    [self.keyboardInputHandler handleKeyDown:event.keyCode];
}

- (void)handleKeyUp:(NSEvent *)event {
    [self.keyboardInputHandler handleKeyUp:event.keyCode];
}
#endif

@end


