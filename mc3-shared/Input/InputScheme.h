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

@protocol InputScheme <NSObject>

@property (nonatomic) InputSchemeType profile;
@property (nonatomic) NSString buttonA;
@property (nonatomic) NSString buttonB;
@property (nonatomic) NSString buttonX;
@property (nonatomic) NSString buttonY;

@property (nonatomic) NSString left;
@property (nonatomic) NSString right;
@property (nonatomic) NSString up;
@property (nonatomic) NSString down;





@end
