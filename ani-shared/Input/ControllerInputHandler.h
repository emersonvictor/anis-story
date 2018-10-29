//
//  ControllerInputHandler.h
//  mc3
//
//  Created by André Carneiro on 18/09/18.
//  Copyright © 2018 André Carneiro. All rights reserved.
//

#import "InputHandler.h"
#import <GameController/GameController.h>

@interface ControllerInputHandler : InputHandler

- (void) startWatchingForControllers;
- (void) stopWatchingForControllers;

//@property (readonly, nonatomic) NSDictionary* translator;
//- (instancetype) init;
//- (void) handleKeyUp:(int) keycode;
//- (void) handleKeyDown:(int) keycode;

- (void) foundController;
- (void) controllerDisconnected;
- (BOOL) hasControllerConnected;
- (void)discoverController:(void (^)(GCController *gameController))controllerConnectedCallback disconnectedCallback:(void (^)(void))controllerDisconnectedCallback;
@end
