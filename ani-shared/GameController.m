//
//  GameController.m
//  mc3
//
//  Created by André Carneiro on 12/09/18.
//  Copyright © 2018 André Carneiro. All rights reserved.
//

#import "GameController.h"
#import "PlayerStates.h"
#import "Categories.h"
#import "InteractiveObject.h"


@implementation GameController {
    NSTimeInterval _lastUpdateTime;
    BOOL whispersIsPlaying;
}

- (instancetype) init {
    self = [super init];
    self.inputScheme = [[InputScheme alloc] init];
    SKTextureAtlas* playerAtlas =  [SKTextureAtlas atlasNamed:@"PlayerRunning"];
    SKTexture* initialTexture = [playerAtlas textureNamed:@"running1.png"];
    self.playerNode = [[Player alloc] initWithTexture: initialTexture];
    SKTexture* normalMap = [self.playerNode.texture textureByGeneratingNormalMap];
    self.playerNode.normalTexture = normalMap;
    self.playerNode.lightingBitMask = 0;
    self.playerNode.shadowedBitMask=1;
    self->whispersIsPlaying =  FALSE;
    
    // MARK: Looking for the sound file URL
//    NSString *soundFilePath = [[NSBundle mainBundle] pathForResource:@"walking" ofType:@"mp3"];
//    NSURL *soundFileURL = [NSURL fileURLWithPath:soundFilePath];
//    NSError *error;
    
    
    // MARK: Configuring the audio player
    
    SKAudioNode* playerWalkingAudio = [[SKAudioNode alloc] initWithFileNamed:@"walking.mp3"];
    [playerWalkingAudio runAction:[SKAction stop]];
    playerWalkingAudio.name = @"walkingAudio";
    
    [self.playerNode addChild:playerWalkingAudio];
    
    self.camera = [[SKCameraNode alloc] init];
    [self.camera setScale:0.5];
    
    // MARK: Keyboard handler
    #if TARGET_OS_OSX
    self.keyboardInputHandler = [[KeyboardInputHandler alloc] initWith:self.inputScheme];
    #endif
    
    self.controllerInputHandler = [[ControllerInputHandler alloc] initWith:self.inputScheme];
    
    return self;
}

// MARK: - Keyboard Logic
#if TARGET_OS_OSX
- (void)handleKeyDown:(NSEvent *)event {
    [self.keyboardInputHandler handleKeyDown:event.keyCode];
}

- (void)handleKeyUp:(NSEvent *)event {
    [self.keyboardInputHandler handleKeyUp:event.keyCode];
}
#endif

- (void)update:(NSTimeInterval)currentTime forScene:(SKScene *)scene {
    
    // Initialize _lastUpdateTime if it has not already been
    if (_lastUpdateTime == 0) {
        _lastUpdateTime = currentTime;
    }
    
    // Calculate time since last update
    CGFloat delta = currentTime - _lastUpdateTime;
    
    [self processInput: delta];
    [self.playerNode updateWithDeltaTime:delta];
    [self updateCameraPosition:delta];
    
    _lastUpdateTime = currentTime;
}

- (void)sceneDidLoadFor:(BaseLevelScene *)scene {
    
    // Player
    SKSpriteNode* reference = (SKSpriteNode*)[scene childNodeWithName:@"player"];
    SKSpriteNode* bg = (SKSpriteNode*)[scene childNodeWithName:@"background"];
    bg.normalTexture = [bg.texture textureByGeneratingNormalMap];
    bg.lightingBitMask=1;
    self.playerNode.position = reference.position;
    self.playerNode.size = reference.size;
    self.playerNode.zPosition = reference.zPosition;
    
    [scene addChild: self.playerNode];
    
    //Ghost
    
    SKAction* moveFront = [SKAction moveBy:CGVectorMake(200, 0) duration:3];
//    SKAction *scaleUp = [SKAction scaleBy:0.5 duration:1];
    SKAction* moveBack = [SKAction moveBy:CGVectorMake(-200, 0) duration:3];
//    SKAction *scaleDown = [SKAction scale duration:1];
    
    SKAction *group1 = [SKAction group:@[moveFront]];
    SKAction *group2 = [SKAction group:@[moveBack]];
//    SKAction* group = [SKAction group:@[]];
    SKSpriteNode* g1 = (SKSpriteNode*)[scene childNodeWithName:@"ghost1"];
    SKAction *sequence = [SKAction sequence:@[group1, group2]];
    SKAudioNode *audio = [[SKAudioNode alloc] initWithFileNamed:@"whispers.mp3"];
    audio.autoplayLooped = FALSE;
    audio.name = @"whispers";
    [g1 addChild:audio];
    
    SKAudioNode *audio2 = [[SKAudioNode alloc] initWithFileNamed:@"Room.mp3"];
    audio2.autoplayLooped = FALSE;
    [scene addChild:audio2];
    
    [g1 runAction:[SKAction repeatActionForever:sequence]];
    
    
    [audio2 runAction:[SKAction sequence:@[[SKAction changeVolumeTo:0.2 duration:0], [SKAction waitForDuration:10], [SKAction play]]]];
    // Scene
    scene.listener = self.playerNode;
    scene.camera = self.camera;
    scene.camera.position = self.playerNode.position;
}

- (void)processInput:(NSTimeInterval) delta{
    if (self.inputScheme.right) {
        self.playerNode.sense = 1;
        [self.playerNode accelerate:delta];
        [self.playerNode.stateMachine enterState:WalkingState.class];
    }
    
    if (self.inputScheme.left) {
        self.playerNode.sense = -1;
        [self.playerNode accelerate:delta];
        [self.playerNode.stateMachine enterState:WalkingState.class];
    }
    if (!self.inputScheme.left && !self.inputScheme.right) {
        [self.playerNode deaccelerate:delta];
    }
    
    if (self.inputScheme.buttonA && (self.playerNode.stateMachine.currentState.class==IdleState.class || self.playerNode.stateMachine.currentState.class==WalkingState.class)) {
        [self.playerNode moveUp:delta];
        [self.playerNode.stateMachine enterState:JumpingState.class];
    } else {
//        NSLog(@"%@", self.playerNode.stateMachine.currentState.className);
//        [self.playerNode.stateMachine enterState:FallingState.class];
    }
    
    if (!self.inputScheme.right && !self.inputScheme.buttonA && !self.inputScheme.left && self.playerNode.stateMachine.currentState.class == WalkingState.class) {
        [self.playerNode.stateMachine enterState:IdleState.class];
    }
    
    if (self.inputScheme.buttonB) {
        for (SKPhysicsBody *body in [self.playerNode.physicsBody allContactedBodies]) {
            if (body.categoryBitMask == InteractiveCategory) {
                InteractiveObject *object = (InteractiveObject*)body.node;
                if (!(object.hasPerformedAction)) {
                    [object runInteraction:self.playerNode];
                }
            }
        }
    }
    
    if (self.inputScheme.buttonX) {
        [self.playerNode useMaskEffect];
    }
    
    NSLog(@"%@", self.playerNode.stateMachine.currentState);
}

- (void)updateCameraPosition:(NSTimeInterval)delta {
    float scaleFactorX = self.playerNode.scene.size.width/self.playerNode.scene.view.bounds.size.width;
    float scaleFactorY = self.playerNode.scene.size.height/self.playerNode.scene.view.bounds.size.height;
    
    float leftBoundary = -1*self.playerNode.scene.size.width/2+15;
    float rightBoundary = self.playerNode.scene.size.width/2-15;
    float bottomBoundary = -1*self.playerNode.scene.size.height/2+30;
    float topBoundary = self.playerNode.scene.size.height/2;
    
    
    float top = ((self.playerNode.scene.view.bounds.size.height/2.0)*scaleFactorY*self.camera.xScale) - (self.playerNode.size.height/2.0);
    float bottom = ((-self.playerNode.scene.view.bounds.size.height/2.0)*scaleFactorY) - (self.playerNode.size.height/2.0);
    
    float left = ((-self.playerNode.scene.view.bounds.size.width/2.0)*scaleFactorY) - (self.playerNode.size.width/2.0);
    float right = ((self.playerNode.scene.view.bounds.size.width/2.0)*scaleFactorY*self.camera.xScale) - (self.playerNode.size.width/2.0);
    
    float leftLimit = leftBoundary + right;
    float rightLimit = rightBoundary - right;
    float topLimit = topBoundary - top;
    float bottomLimit = bottomBoundary + top;
    
    float xPosition = self.camera.position.x;
    float yPosition = self.camera.position.y;
    
    if (self.playerNode.position.x > leftLimit && self.playerNode.position.x < rightLimit)  {
        xPosition = self.playerNode.position.x;
    }
    
    if (self.playerNode.position.x < leftLimit) {
        xPosition = leftLimit;
    }
    else if (self.playerNode.position.x > rightLimit) {
        xPosition = rightLimit;
    }
    else {
        xPosition = self.playerNode.position.x;
    }
    
    if (self.playerNode.position.y > bottomLimit && self.playerNode.position.y < topLimit)  {
        yPosition = self.playerNode.position.y;
    }
    
    if(self.playerNode.position.y < -480 && self.playerNode.position.x > - 480) {
        
        
        if (!whispersIsPlaying) {
            SKScene* scene = self.playerNode.scene;
            SKSpriteNode* g1 = (SKSpriteNode*)[scene childNodeWithName:@"ghost1"];
            SKAudioNode* whispers = (SKAudioNode*)[g1 childNodeWithName:@"whispers"];
            [whispers runAction:[SKAction changeVolumeTo:0.5 duration:0]];
            [whispers runAction:[SKAction play]];
            [whispers runAction:[SKAction changeVolumeTo:0.7 duration:2]];
        }
        
        whispersIsPlaying = TRUE;
    }
    else {
        
        
        if (whispersIsPlaying) {
            SKScene* scene = self.playerNode.scene;
            SKSpriteNode* g1 = (SKSpriteNode*)[scene childNodeWithName:@"ghost1"];
            SKAudioNode* whispers = (SKAudioNode*)[g1 childNodeWithName:@"whispers"];
            
            [whispers runAction:[SKAction sequence:@[[SKAction changeVolumeTo:0 duration:5], [SKAction stop]]]];
        }
        
        whispersIsPlaying = FALSE;

        
        
    }
    
    self.camera.position = CGPointMake(xPosition, yPosition);
}

@end
