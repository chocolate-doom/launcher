/* All Rights reserved */

#include <AppKit/AppKit.h>

@interface IWADLocation : NSObject
{
    id locationConfigBox;
}

- (void) setLocation: (id)sender;
- (NSString *) getLocation;

@end

