CCAudioAction
==================

Wrapper for SimpleAudioEngine written for Cocos2d-iPhone 2.x
Using SimpleAudioEngine in cocos2d is awesome but it's difficult to integrate inside out CCActions.
CCAudioAction easily allow a developer to insert SimpleAudioEngine features inside CCActions ( CCSequence, CCSpawn, ... )

How to use it
---------
```
...
[image runAction:
 [CCSequence actions:
  **[CCAudioPlaySound actionWithSoundName:@"swosh.wav"],**
  [CCEaseExponentialOut actionWithAction:[CCMoveBy actionWithDuration:0.4f position:ccp(moveHoriz, 0.0f)]],
  [CCDelayTime actionWithDuration:1.2f],
  **[CCAudioPlaySound actionWithSoundName:@"swosh.wav"],**
  [CCEaseExponentialIn actionWithAction:[CCMoveBy actionWithDuration:0.4f position:ccp(moveHoriz, 0.0f)]],
  [CCCallBlockN actionWithBlock:^(CCNode *n) { [n removeFromParentAndCleanup:YES]; }],
  nil]];
...
```