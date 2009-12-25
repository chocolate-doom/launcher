/* All Rights reserved */

#include <AppKit/AppKit.h>

@interface LauncherManager : NSObject
{
    id commandLineArguments;
    id iwadList;
}

- (void) launch: (id)sender;
- (void) runSetup: (id)sender;

@end

