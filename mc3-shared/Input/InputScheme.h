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

@property (nonatomic) BOOL left;
@property (nonatomic) BOOL right;
@property (nonatomic) BOOL up;
@property (nonatomic) BOOL down;
@property (nonatomic) float xVector;
@property (nonatomic) float yVector;

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
