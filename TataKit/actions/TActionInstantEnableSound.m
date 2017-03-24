//
//  TActionInstantEnableSound.m
//  TataViewer
//
//  Created by Albert Li on 10/16/14.
//  Copyright (c) 2014 Tataland. All rights reserved.
//

#import "TActionInstantEnableSound.h"
#import "SMXMLDocument.h"
#import "TUtil.h"

@implementation TActionInstantEnableSound

- (id)init {
    if (self = [super init]) {
        self.name = @"Ena./Dis. Sound";
        self.icon = [UIImage imageNamed:@"icon_action_enablesound"];
        
        self.enabled = NO;
    }
    
    return self;
}

- (void)clone:(TAction *)target {
    [super clone:target];
    
    TActionInstantEnableSound* targetAction = (TActionInstantEnableSound*)target;
    targetAction.enabled = self.enabled;
}

- (BOOL)parseXml:(SMXMLElement *)xml {
    if (xml == nil || ![xml.name isEqualToString:@"ActionInstantEnableSound"])
        return NO;
    
    if (![super parseXml:xml])
        return NO;
    
    @try {
        self.enabled = [TUtil parseBoolXElement:[xml childNamed:@"Enabled"] default:NO];
        return YES;
    } @catch (NSException* e) {
        NSLog(@"Error: %@", e);
        return NO;
    }
}

- (SMXMLElement*)toXml {
    NOT_IMPLEMENTED_METHOD
}

#pragma mark - Launch Methods

- (void)reset:(long long)time {
    [super reset:time];
}

- (BOOL)step:(id<TTataDelegate>)delegate time:(long long)time {
    
    [delegate toggleEffectByAuto:NO on:self.enabled];
    
    return [super step:delegate time:time];
}

@end
