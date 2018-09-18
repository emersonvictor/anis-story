//
//  KeyboardInputHandler.h
//  mc3-macos
//
//  Created by André Carneiro on 13/09/18.
//  Copyright © 2018 André Carneiro. All rights reserved.
//

#ifndef KeyboardInputHandler_h
#define KeyboardInputHandler_h

#import "InputHandler.h"

typedef enum : NSUInteger {
    A = 0x00, // = 0
    S = 0x01,
    D = 0x02,
    F = 0x03,
    H = 0x04,
    G = 0x05,
    Z = 0x06,
    X = 0x07,
    C = 0x08,
    V = 0x09,
    B = 0x0B,
    Q = 0x0C,
    W = 0x0D,
    E = 0x0E,
    R = 0x0F,
    Y = 0x10,
    T = 0x11,
    One = 0x12,
    Two = 0x13,
    Three = 0x14,
    Four = 0x15,
    Six = 0x16,
    Five = 0x17,
    Equals = 0x18,
    Nine = 0x19,
    Seven = 0x1A,
    Minus = 0x1B,
    Eight = 0x1C,
    Zero = 0x1D,
    RightBracket = 0x1E,
    O = 0x1F,
    U = 0x20,
    LeftBracket = 0x21,
    ILetter = 0x22,
    P = 0x23,
    Return = 0x24,
    L = 0x25,
    J = 0x26,
    Quote = 0x27,
    K = 0x28,
    Semicolon = 0x29,
    Backslash = 0x2A,
    Comma = 0x2B,
    Slash = 0x2C,
    N = 0x2D,
    M = 0x2E,
    Period = 0x2F,
    Tab = 0x30,
    Space = 0x31,
    Grave = 0x32,
    Delete = 0x33,
    
    Escape = 0x35,
    
    Command = 0x37,
    LeftShift = 0x38,
    CapsLock = 0x39,
    LeftOption = 0x3A,
    LeftControl = 0x3B,
    RightShift = 0x3C,
    RightOption = 0x3D,
    RightControl = 0x3E,
    Function = 0x3F,
    F17 = 0x40,
    KeypadDecimal = 0x41,
    
    KeypadMultiply = 0x43,
    
    KeypadPlus = 0x45,
    
    KeypadClear = 0x47,
    VolumeUp = 0x48,
    VolumeDown = 0x49,
    Mute = 0x4A,
    KeypadDivide = 0x4B,
    KeypadEnter = 0x4C,
    
    KeypadMinus = 0x4E,
    F18 = 0x4F,
    F19 = 0x50,
    KeypadEquals = 0x51,
    KeypadZero = 0x52,
    KeypadOne = 0x53,
    KeypadTwo = 0x54,
    KeypadThree = 0x55,
    KeypadFour = 0x56,
    KeypadFive = 0x57,
    KeypadSix = 0x58,
    KeypadSeven = 0x59,
    F20 = 0x5A,
    KeypadEight = 0x5B,
    KeypadNine = 0x5C,
    
    F5 = 0x60,
    F6 = 0x61,
    F7 = 0x62,
    F3 = 0x63,
    F8 = 0x64,
    F9 = 0x65,
    F11 = 0x67,
    F13 = 0x69,
    F16 = 0x6A,
    F14 = 0x6B,
    F10 = 0x6D,
    F12 = 0x6F,
    F15 = 0x71,
    Help = 0x7,
    Home = 0x73,
    PageUp = 0x74,
    ForwardDelete = 0x75,
    F4 = 0x76,
    End = 0x77,
    F2 = 0x78,
    PageDown = 0x79,
    F1 = 0x7A,
    Left = 0x7B,
    Right = 0x7C,
    Down = 0x7D,
    Up = 0x7E, // = 126
    Count = 0x7F
} Keys;

//#define BTN_A ((int) 0)
//#define BTN_B ((int) 1)
//#define BTN_X ((int) 2)
//#define BTN_Y ((int) 3)
//
//#define BTN_UP ((int) 4)
//#define BTN_DOWN ((int) 5)
//#define BTN_LEFT ((int) 6)
//#define BTN_RIGHT ((int) 7)


typedef enum : NSUInteger {
    ButtonA,
    ButtonB,
    ButtonX,
    ButtonY,
    UpBtn,
    DownBtn,
    LeftBtn,
    RightBtn
    
} ControllerScheme;


@interface KeyboardInputHandler : InputHandler

@property (readonly, nonatomic) NSDictionary* translator;
- (instancetype) init;
- (void) handleKeyUp:(int) keycode;
- (void) handleKeyDown:(int) keycode;

- (void) print;

@end

#endif /* KeyboardInputHandler_h */
