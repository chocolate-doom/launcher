/* All Rights reserved */

#include <AppKit/AppKit.h>

@interface IWADController : NSObject
{
  id chex;
  id doom1;
  id doom2;
  id iwadSelector;
  id configWindow;
  id plutonia;
  id tnt;
}
- (void) closeConfigWindow: (id)sender;
- (void) openConfigWindow: (id)sender;
@end
