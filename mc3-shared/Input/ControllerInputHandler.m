//
//  ControllerInputHandler.m
//  mc3
//
//  Created by André Carneiro on 18/09/18.
//  Copyright © 2018 André Carneiro. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ControllerInputHandler.h"

@interface ControllerInputHandler ()
@property (nonatomic,copy) void (^controllerConnectedCallback)(GCController *gameController);
@property (nonatomic,copy) void (^controllerDisconnectedCallback)(void);
@end

@implementation ControllerInputHandler

- (instancetype) initWith:(InputScheme *)inputScheme {
    self = [super initWith:inputScheme];
    
    [self startWatchingForControllers];
    
    
    return self;
}

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:GCControllerDidConnectNotification
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:GCControllerDidDisconnectNotification
                                                  object:nil];
}

- (void) foundController {
    NSLog(@"New controller connected");
    
    [self setupGameController:[[GCController controllers] firstObject]];
//    [NSNotificationCenter.defaultCenter removeObserver:self name:GCControllerDidConnectNotification object:nil];
    
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(controllerDisconnected) name:GCControllerDidDisconnectNotification object:nil];
    
}

- (void) controllerDisconnected {
    NSLog(@"Removed controller");
}

- (void) startWatchingForControllers {
    [GCController startWirelessControllerDiscoveryWithCompletionHandler:nil];
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(foundController) name:GCControllerDidConnectNotification object:nil];
}

- (void) stopWatchingForControllers {
    [GCController stopWirelessControllerDiscovery];
    [NSNotificationCenter.defaultCenter removeObserver:self name:GCControllerDidConnectNotification object:nil];
    [NSNotificationCenter.defaultCenter removeObserver:self name:GCControllerDidDisconnectNotification object:nil];
}

- (BOOL)hasControllerConnected {
    return [[GCController controllers] count] > 0;
}

- (void)discoverController:(void (^)(GCController *gameController))controllerConnectedCallback disconnectedCallback:(void (^)(void))controllerDisconnectedCallback{
    
    self.controllerConnectedCallback = controllerConnectedCallback;
    self.controllerDisconnectedCallback = controllerDisconnectedCallback;
    
    if ([self hasControllerConnected]) {
//        NSLog(@"Discovery finished on first pass");
        [self foundController];
    } else {
//        NSLog(@"Discovery happening patiently");
        [self startWatchingForControllers];
    }
}

- (void) setupGameController: (GCController*) gameController {
    
    
    GCControllerButtonInput* buttonA = nil;
    GCControllerButtonInput* buttonB = nil;
    GCControllerButtonInput* buttonX = nil;
    GCControllerButtonInput* buttonY = nil;
    
    GCControllerButtonInput* leftShoulder = nil;
    GCControllerButtonInput* rightShoulder = nil;
    
    GCControllerDirectionPad* dpad = nil;
    
    GCControllerDirectionPad* leftThumbstick = nil;
    
    
    
    if (gameController.extendedGamepad) {
        NSLog(@"Is an extended gamepad");
        
        buttonA = gameController.extendedGamepad.buttonA;
        buttonB = gameController.extendedGamepad.buttonB;
        buttonX = gameController.extendedGamepad.buttonX;
        buttonY = gameController.extendedGamepad.buttonY;
        
        leftShoulder = gameController.extendedGamepad.leftShoulder;
        rightShoulder = gameController.extendedGamepad.rightShoulder;
        
        dpad = gameController.extendedGamepad.dpad;
        leftThumbstick = gameController.extendedGamepad.leftThumbstick;
        
        
        
        
    }
    else if (gameController.gamepad) {
        NSLog(@"Is an simple gamepad");
        
        buttonA = gameController.gamepad.buttonA;
        buttonB = gameController.gamepad.buttonB;
        buttonX = gameController.gamepad.buttonX;
        buttonY = gameController.gamepad.buttonY;
        
        leftShoulder = gameController.gamepad.leftShoulder;
        rightShoulder = gameController.gamepad.rightShoulder;
        
        dpad = gameController.gamepad.dpad;
    }
    
    buttonA.valueChangedHandler = ^(GCControllerButtonInput *button, float value, BOOL pressed) {
        if (pressed) {
            [self.inputScheme pressButtonA];
        }
        else {
            [self.inputScheme releaseButtonA];
        }
    };
    
    buttonB.valueChangedHandler = ^(GCControllerButtonInput *button, float value, BOOL pressed) {
        if (pressed) {
            [self.inputScheme pressButtonB];
        }
        else {
            [self.inputScheme releaseButtonB];
        }
    };
    
    buttonX.valueChangedHandler = ^(GCControllerButtonInput *button, float value, BOOL pressed) {
        if (pressed) {
            [self.inputScheme pressButtonX];
        }
        else {
            [self.inputScheme releaseButtonX];
        }
    };
    
    buttonY.valueChangedHandler = ^(GCControllerButtonInput *button, float value, BOOL pressed) {
        if (pressed) {
            [self.inputScheme pressButtonY];
        }
        else {
            [self.inputScheme releaseButtonY];
        }
    };
    
    buttonA.valueChangedHandler = ^(GCControllerButtonInput *button, float value, BOOL pressed) {
        if (pressed) {
            [self.inputScheme pressButtonA];
        }
        else {
            [self.inputScheme releaseButtonA];
        }
    };
    
    dpad.valueChangedHandler = ^ (GCControllerDirectionPad *dpad, float xValue, float yValue) {
        if (xValue>0.1) {
            [self.inputScheme releaseButtonLeft];
            [self.inputScheme pressButtonRight];
            
        }
        else if (xValue<-0.1) {
            [self.inputScheme releaseButtonRight];
            [self.inputScheme pressButtonLeft];
        }
        else {
            [self.inputScheme releaseButtonLeft];
            [self.inputScheme releaseButtonRight];
        }
        
        if (yValue>0.1) {
            [self.inputScheme releaseButtonDown];
            [self.inputScheme pressButtonUp];
            
        }
        else if (yValue<-0.1) {
            [self.inputScheme releaseButtonUp];
            [self.inputScheme pressButtonDown];
        }
        else {
            [self.inputScheme releaseButtonUp];
            [self.inputScheme releaseButtonDown];
        }
        
        [self print];
    };
    
    if (leftThumbstick != nil) {
        leftThumbstick.valueChangedHandler = dpad.valueChangedHandler;
    }

    
}








@end
