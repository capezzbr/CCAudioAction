//
//  MyAudioAction.m
//
//  Created by Bruno Capezzali on 23/02/12.
//  Copyright 2012 Bruno Capezzali. All rights reserved.
//

#import "CCAudioAction.h"

#pragma mark CCAudioPlayBackground

@implementation CCAudioPlayBackground

+(id)actionWithBackgroundName:(NSString *)backName {
	return [[[self alloc] initWithBackgroundName:backName] autorelease];
}

-(id)initWithBackgroundName:(NSString *)backName {
    
	if( (self=[super init]) ) {
		_backgroundName = [backName retain];
    }
	
	return self;
}

-(id)copyWithZone: (NSZone*) zone {
	CCActionInstant *copy = [[[self class] allocWithZone:zone] initWithBackgroundName:_backgroundName];
	return copy;
}

-(void)startWithTarget:(id)aTarget {
	[super startWithTarget:aTarget];
    [[SimpleAudioEngine sharedEngine] playBackgroundMusic:_backgroundName loop:YES];
}

-(void)dealloc {
	[_backgroundName release];
	[super dealloc];
}

@end

#pragma mark -
#pragma mark CCAudioFadeBackgroundTo

@implementation CCAudioFadeBackgroundTo

+(id)actionWithDuration:(ccTime)t volume:(float)v stop:(BOOL)s {	
	return [[[self alloc] initWithDuration:t volume:v stop:s] autorelease];
}

// In a CCSequence all actions are pre-allocated
-(id)initWithDuration:(ccTime)t volume:(float)v stop:(BOOL)s {
    
	if( (self=[super initWithDuration:t]) ) {
        _dstVolume = v;
        _stop = s;
    }
	
	return self;
}

-(id)copyWithZone: (NSZone*) zone {
	CCAction *copy = [[[self class] allocWithZone: zone] initWithDuration:[self duration] volume:_dstVolume stop:_stop];
	return copy;
}

// startWithTarget is called when an action is starting
-(void)startWithTarget:(id)aTarget {
	[super startWithTarget:aTarget];	

    // Background music is mapped to the left "channel"
    CDLongAudioSource *player = [[CDAudioManager sharedManager] audioSourceForChannel:kASC_Left];
    _modifier = [[CDLongAudioSourceFader alloc] init:player interpolationType:kIT_Linear startVal:player.volume endVal:_dstVolume];
    [_modifier setStopTargetWhenComplete:_stop];
    
    _lastSetValue = [_modifier _getTargetProperty];
}

-(void)update:(ccTime)t {
    
	// Check if modified property has been externally modified and if so bail out
	if ([_modifier _getTargetProperty] != _lastSetValue) {
        [[[CCDirector sharedDirector] actionManager] removeAction:self];
		return;
	}	
	[_modifier modify:t];
	_lastSetValue = [_modifier _getTargetProperty];
}

-(void) dealloc {
	[_modifier release];
	[super dealloc];
}

@end

#pragma mark -
#pragma mark CCAudioPlaySound

@implementation CCAudioPlaySound

+(id)actionWithSoundName:(NSString *)soundName {
	return [[[self alloc] initWithSoundName:soundName pitch:1.0f pan:0.0f gain:1.0f] autorelease];
}

+(id)actionWithSoundName:(NSString *)soundName pitch:(Float32)pitch pan:(Float32)pan gain:(Float32)gain {
    return [[[self alloc] initWithSoundName:soundName pitch:pitch pan:pan gain:gain] autorelease];
}

-(id)initWithSoundName:(NSString *)soundName pitch:(Float32)pitch pan:(Float32)pan gain:(Float32)gain {
	if( (self=[super init]) ) {
		_soundName = [soundName retain];
        _pitch = pitch;
        _pan = pan;
        _gain = gain;
    }
	
	return self;
}

-(id)copyWithZone: (NSZone*) zone {
	CCActionInstant *copy = [[[self class] allocWithZone:zone] initWithSoundName:_soundName pitch:_pitch pan:_pan gain:_gain];
	return copy;
}

-(void)startWithTarget:(id)aTarget {
	[super startWithTarget:aTarget];
    [[SimpleAudioEngine sharedEngine] playEffect:_soundName pitch:_pitch pan:_pan gain:_gain];
}

-(void)dealloc {
	[_soundName release];
	[super dealloc];
}

@end

