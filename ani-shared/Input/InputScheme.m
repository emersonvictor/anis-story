//
//  InputScheme.m
//  mc3
//
//  Created by André Carneiro on 14/09/18.
//  Copyright © 2018 André Carneiro. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "InputScheme.h"

@interface InputScheme ()

@property (nonatomic, readwrite) BOOL buttonA;
@property (nonatomic, readwrite) BOOL buttonB;
@property (nonatomic, readwrite) BOOL buttonX;
@property (nonatomic, readwrite) BOOL buttonY;

@property (nonatomic, readwrite) BOOL left;
@property (nonatomic, readwrite) BOOL right;
@property (nonatomic, readwrite) BOOL up;
@property (nonatomic, readwrite) BOOL down;
@property (nonatomic, readwrite) float xVector;
@property (nonatomic, readwrite) float yVector;

@end

@implementation InputScheme

- (instancetype) init {
    self = [super init];
    
    self.buttonA = FALSE;
    self.buttonB = FALSE;
    self.buttonX = FALSE;
    self.buttonY = FALSE;
    
    self.left = FALSE;
    self.right = FALSE;
    self.up = FALSE;
    self.down = FALSE;
    
    self.xVector = 0.0;
    self.yVector = 0.0;
    
    return self;
}

- (void) pressButtonA {
    self.buttonA = TRUE;
}

- (void) releaseButtonA {
    self.buttonA = FALSE;
}

- (void) pressButtonB {
    self.buttonB = TRUE;
}

- (void) releaseButtonB {
    self.buttonB = FALSE;
}

- (void) pressButtonX {
    self.buttonX = TRUE;
}

- (void) releaseButtonX {
    self.buttonX = FALSE;
}

- (void) pressButtonY {
    self.buttonY = TRUE;
}

- (void) releaseButtonY {
    self.buttonY = FALSE;
}

- (void) pressButtonUp {
    self.up = TRUE;
}

- (void) releaseButtonUp {
    self.up = FALSE;
}

- (void) pressButtonDown {
    self.down = TRUE;
}

- (void) releaseButtonDown {
    self.down = FALSE;
}

- (void) pressButtonLeft {
    self.left = TRUE;
}

- (void) releaseButtonLeft {
    self.left = FALSE;
}

- (void) pressButtonRight {
    self.right = TRUE;
}

- (void) releaseButtonRight {
    self.right = FALSE;
}


@end
