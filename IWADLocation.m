/* All Rights reserved */

#include <AppKit/AppKit.h>
#include "IWADLocation.h"

static id WAD_TYPES[] = {
    @"wad", @"WAD"
};

@implementation IWADLocation

- (void) setLocation: (id)sender
{
    NSArray *wadTypes = [NSArray arrayWithObjects: WAD_TYPES count: 2];
    NSOpenPanel *openPanel;
    NSString *filename;
    NSArray *filenames;
    int result;

    [wadTypes retain];

    // Open a file selector for the new file.

    openPanel = [NSOpenPanel openPanel];
    [openPanel setTitle: @"Add IWAD file"];
    [openPanel setCanChooseFiles: YES];
    [openPanel setCanChooseDirectories: NO];

    result = [openPanel runModalForTypes: wadTypes];

    // If the "OK" button was clicked, add the new IWAD file to the list.

    if (result == NSOKButton)
    {
        filenames = [openPanel filenames];
	filename = [filenames lastObject];
	[self->locationConfigBox setStringValue: filename];
    }
}

- (NSString *) getLocation
{
    return [self->locationConfigBox stringValue];
}

@end

