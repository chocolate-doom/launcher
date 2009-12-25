/* All Rights reserved */

#include <AppKit/AppKit.h>

@interface IWADList : NSObject
{
    id iwadListTable;
    NSMutableArray *iwads;
}

- (void) addIwad: (id)sender;
- (void) deleteIwad: (id)sender;
- (NSString *) getSelectedIwad;

@end

