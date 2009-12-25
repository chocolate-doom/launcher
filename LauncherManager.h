/* All Rights reserved */

#include <AppKit/AppKit.h>

@interface LauncherManager : NSObject
{
  id commandLineArguments;
  id iwadController;
}
- (void) launch: (id)sender;
- (void) runSetup: (id)sender;
@end
