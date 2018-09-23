//
//  GameViewController.m
//  mc3
//
//  Created by André Carneiro on 10/09/18.
//  Copyright © 2018 André Carneiro. All rights reserved.
//

#import "GameViewController.h"
#import "GameLevel.h"

@implementation GameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.controllerUserInteractionEnabled = FALSE;
    
    // Load 'GameScene.sks' as a GKScene. This provides gameplay related content
    // including entities and graphs.
    GKScene *scene = [GKScene sceneWithFileNamed:@"GameLevel"];
    
    _ctrl = [GameController new];
    
    // Get the SKScene from the loaded GKScene
    GameLevel *sceneNode = (GameLevel *)scene.rootNode;
    
    sceneNode.delegate = _ctrl;
    // Copy gameplay related content over to the scene
    sceneNode.entities = [scene.entities mutableCopy];
    sceneNode.graphs = [scene.graphs mutableCopy];
    
    // Set the scale mode to scale to fit the window
    sceneNode.scaleMode = SKSceneScaleModeAspectFill;
//    sceneNode.delegate =
    
    SKView *skView = (SKView *)self.view;
    
    // Present the scene
    [skView presentScene:sceneNode];
    
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
    skView.showsPhysics = TRUE;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

@end
