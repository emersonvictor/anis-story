//
//  GameController.m
//  mc3
//
//  Created by André Carneiro on 12/09/18.
//  Copyright © 2018 André Carneiro. All rights reserved.
//

#import "GameController.h"

@implementation GameController

#if TARGET_OS_OSX
- (void)handleKeyDown:(NSEvent *)event {
    NSLog(@"%u", event.keyCode);
}

- (void)handleKeyUp:(NSEvent *)event {
    NSLog(@"Soltou");
}
#endif

//- (void)update:(NSTimeInterval)currentTime forScene:(SKScene *)scene {
//    NSLog(@"LA FOI UM FRAME");
//}
@end


