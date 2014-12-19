//
//  AppDelegate.h
//  TemperatureConstraints
//
//  Created by Marcel Weiher on 9/21/14.
//  Copyright (c) 2014 Metaobject. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate>
{
    IBOutlet NSTextField *celsiusTextField;
    IBOutlet NSTextField *fahrenheitTextField;
    IBOutlet NSTextField *kelvinTextField;
}


@end

