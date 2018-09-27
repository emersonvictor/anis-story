//
//  InputScheme.h
//  mc3
//
//  Created by André Carneiro on 13/09/18.
//  Copyright © 2018 André Carneiro. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum inputSchemeTypes {
    KEYBOARD,
    GAMEPAD,
    EXTENDEDGAMEPAD
} InputSchemeType;

@interface InputScheme : NSObject

@property (nonatomic) InputSchemeType profile;
@property (nonatomic, readonly) BOOL buttonA;
@property (nonatomic, readonly) BOOL buttonB;
@property (nonatomic, readonly) BOOL buttonX;
@property (nonatomic, readonly) BOOL buttonY;

@property (nonatomic, readonly) BOOL left;
@property (nonatomic, readonly) BOOL right;
@property (nonatomic, readonly) BOOL up;
@property (nonatomic, readonly) BOOL down;
@property (nonatomic, readonly) float xVector;
@property (nonatomic, readonly) float yVector;

- (instancetype) init;

- (void) pressButtonA;
- (void) releaseButtonA;

- (void) pressButtonB;
- (void) releaseButtonB;

- (void) pressButtonX;
- (void) releaseButtonX;

- (void) pressButtonY;
- (void) releaseButtonY;

- (void) pressButtonUp;
- (void) releaseButtonUp;

- (void) pressButtonDown;
- (void) releaseButtonDown;

- (void) pressButtonLeft;
- (void) releaseButtonLeft;

- (void) pressButtonRight;
- (void) releaseButtonRight;

@end
