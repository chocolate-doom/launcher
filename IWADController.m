/* All Rights reserved */

#include <AppKit/AppKit.h>
#include "IWADController.h"

@implementation IWADController


- (void) closeConfigWindow: (id)sender
{
    [self->configWindow orderOut: sender];
}


- (void) openConfigWindow: (id)sender
{
    if (![self->configWindow isVisible])
    {
	[self->configWindow makeKeyAndOrderFront: sender];
    }
}

@end
