//
//  AppDelegate.m
//  TemperatureConstraints
//
//  Created by Marcel Weiher on 9/21/14.
//  Copyright (c) 2014 Metaobject. All rights reserved.
//

#import "AppDelegate.h"
#import <MethodServer/MethodServer.h>


@interface AppDelegate ()

@property (strong) IBOutlet NSWindow *window;
@property (strong) MethodServer *methodServer;
@end

@implementation AppDelegate

-interpreter
{
    return [[self methodServer] interpreter];
}


- (void)applicationWillFinishLaunching:(NSNotification *)aNotification {
    [self setMethodServer:[[[MethodServer alloc] initWithMethodDictName:@"temperatureconstraints"] autorelease]];
    [[self methodServer] setupWithoutStarting];
    [[self interpreter] bindValue:self toVariableNamed:@"delegate"];
    [[self interpreter] evaluateScriptString:@"scheme:ivar := ref:var:delegate asScheme."];
    NSLog(@"will setupDeltablueConstraints");
    
    [self setupDeltablueConstraints];
}


- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

@end
