/* All Rights reserved */

#include <AppKit/AppKit.h>
#include "IWADController.h"

@interface LauncherManager : NSObject
{
    id commandLineArguments;
    IWADController *iwadController;
}

- (void) launch: (id)sender;
- (void) runSetup: (id)sender;

@end

