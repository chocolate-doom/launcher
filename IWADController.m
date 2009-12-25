/* All Rights reserved */

#include <AppKit/AppKit.h>
#include "IWADController.h"
#include "IWADLocation.h"

typedef enum
{
    IWAD_DOOM1,
    IWAD_DOOM2,
    IWAD_TNT,
    IWAD_PLUTONIA,
    IWAD_CHEX,
    NUM_IWAD_TYPES
} IWAD;

static NSString *IWADLabels[NUM_IWAD_TYPES] =
{
    @"Doom",
    @"Doom II: Hell on Earth",
    @"Final Doom: TNT: Evilution",
    @"Final Doom: Plutonia Experiment",
    @"Chex Quest"
};

@implementation IWADController

- (void) getIWADList: (IWADLocation **) iwadList
{
    iwadList[IWAD_DOOM1] = self->doom1;
    iwadList[IWAD_DOOM2] = self->doom2;
    iwadList[IWAD_TNT] = self->tnt;
    iwadList[IWAD_PLUTONIA] = self->plutonia;
    iwadList[IWAD_CHEX] = self->chex;
}

// Set the dropdown list to include an entry for each IWAD that has
// been configured.

- (void) setDropdownList
{
    IWADLocation *iwadList[NUM_IWAD_TYPES];
    id location;
    unsigned int i;

    [self getIWADList: iwadList];
    [self->iwadSelector removeAllItems];

    for (i=0; i<NUM_IWAD_TYPES; ++i)
    {
        location = [iwadList[i] getLocation];

        if (location != nil && [location length] > 0)
        {
            [self->iwadSelector addItemWithTitle: IWADLabels[i]];
        }
    }
}

- (IWAD) getSelectedIWAD
{
    unsigned int i;

    for (i=0; i<NUM_IWAD_TYPES; ++i)
    {
        if ([self->iwadSelector titleOfSelectedItem] == IWADLabels[i])
        {
            return i;
        }
    }

    return NUM_IWAD_TYPES;
}

// Get the location of the selected IWAD.

- (NSString *) getIWADLocation
{
    IWAD selectedIWAD;
    IWADLocation *iwadList[NUM_IWAD_TYPES];

    selectedIWAD = [self getSelectedIWAD];

    if (selectedIWAD == NUM_IWAD_TYPES)
    {
        return nil;
    }
    else
    {
        [self getIWADList: iwadList];

	return [iwadList[selectedIWAD] getLocation];
    }
}

// Callback method invoked when the configuration button in the main
// window is clicked.

- (void) openConfigWindow: (id)sender
{
    if (![self->configWindow isVisible])
    {
        [self->configWindow makeKeyAndOrderFront: sender];
    }
}

// Callback method invoked when the close button is clicked.

- (void) closeConfigWindow: (id)sender
{
    [self->configWindow orderOut: sender];
    [self setDropdownList];
}

@end

