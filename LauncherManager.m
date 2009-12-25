/* All Rights reserved */

#include <AppKit/AppKit.h>
#include "LauncherManager.h"
#include "config.h"

@implementation LauncherManager

- (void) launch: (id)sender
{
    NSString *iwad;
    NSString *args;

    iwad = [self->iwadController getIWADLocation];
    args = [self->commandLineArguments stringValue];

    printf("Command line: %s %s\n", [iwad UTF8String], [args UTF8String]);
}

- (void) runSetup: (id)sender
{
}

- (void) awakeFromNib
{
    [self->packageLabel setStringValue: @PACKAGE_STRING];
    [self->launcherWindow setTitle: @PACKAGE_NAME " Launcher"];
}

@end

