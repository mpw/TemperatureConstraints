//
//  AppDelegate.m
//  TemperatureConstraints
//
//  Created by Marcel Weiher on 9/21/14.
//  Copyright (c) 2014 Metaobject. All rights reserved.
//

#import "AppDelegate.h"
#import <MethodServer/MethodServer.h>
#import <MPWFoundation/MPWFoundation.h>

@interface AppDelegate ()

@property (strong) IBOutlet NSWindow *window;

@end

@implementation AppDelegate


idAccessor(solver, setSolver)
objectAccessor(NSTextField, celsiusTextField, setCelsiusTextField )
objectAccessor(NSTextField, fahrenheitTextField, setFahrenheitTextField )
objectAccessor(NSTextField, kelvinTextField, setKelvinTextField )
objectAccessor(MethodServer, methodServer, setMethodServer)
intAccessor( c, setC)
intAccessor( k, setK)
intAccessor( f, setF)

-(MPWStCompiler*)interpreter
{
    return [[self methodServer] interpreter];
}


- (void)applicationWillFinishLaunching:(NSNotification *)aNotification {
    [self setMethodServer:[[[MethodServer alloc] initWithMethodDictName:@"temperatureconverter"] autorelease]];
    [[self methodServer] setupMethodServer];
    NSURL *stURL=[[NSBundle mainBundle] URLForResource:@"AppDelegate" withExtension:@"st"];
    NSLog(@"url: %@",stURL);
    NSString *st=[NSString stringWithContentsOfURL:stURL encoding:NSUTF8StringEncoding error:nil];
    NSLog(@"script: %@",st);
    [[self interpreter] bindValue:self toVariableNamed:@"delegate"];
    [[self interpreter] evaluateScriptString:@"scheme:ivar := ref:var:delegate asScheme."];
    [self setC:0];
    [self setF:32];
    [self setK:273];

    NSLog(@"compiler: %@",[self interpreter]);
    @try {
        [[self interpreter] evaluateScriptString:st];
    } @catch ( NSException *e) {
        NSLog(@"error evaluating: %@",e);
    }
    NSLog(@"interpreter: %@ solver: %@",[self interpreter],[[self interpreter] solver]);

    
    
    [[self interpreter] evaluateScriptString:@"stdout println: ivar:c."];
    [[self interpreter] evaluateScriptString:@"stdout println: ivar:f."];
    [[self interpreter] evaluateScriptString:@"stdout println: ivar:k."];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(methodsDefined) name:@"methodsDefined" object:nil];
}


- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    NSLog(@"will setupDeltablueConstraints");
    NSLog(@"method: %@",[[[self interpreter] methodForClass:[self className] name:@"setupDeltablueConstraints"] script]);
    
    [self methodsDefined];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

-(void)methodsDefined
{
    NSLog(@"=== methods defined, re-init");
    [self setSolver:[NSClassFromString(@"DBSolver") solver]];
    [[self interpreter] setSolver:[self solver]];
    [self setupDeltablueConstraints];
}

-(void)dump:(NSString*)message
{
    NSLog(@"=== %@ ===",message);
    NSLog(@"c=%d f=%d k=%d",c,f,k);
    NSLog(@"======");
}

@end

@implementation NSControl(objst_observing)

-(void)objst_addObserver:anObserver forKey:aKey
{
    [NSNotificationCenter.defaultCenter addObserverForName:NSControlTextDidChangeNotification object:self queue:nil usingBlock:^(NSNotification *note) {
        [[[NSApplication sharedApplication] delegate] dump:@"before"];
        NSLog(@"self value: %@ obserer: %@",[self objectValue],anObserver);
        NSLog(@"self value: %@ obserer: %@",[self objectValue],anObserver);
        [anObserver didChange];
        [[[NSApplication sharedApplication] delegate] dump:@"after"];
    }];
}

@end

