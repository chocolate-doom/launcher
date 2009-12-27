/* ... */
//-----------------------------------------------------------------------------
//
// Copyright(C) 2009 Simon Howard
//
// This program is free software; you can redistribute it and/or
// modify it under the terms of the GNU General Public License
// as published by the Free Software Foundation; either version 2
// of the License, or (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program; if not, write to the Free Software
// Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
// 02111-1307, USA.
//
//-----------------------------------------------------------------------------

#include <stdlib.h>
#include <string.h>
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

static NSString *IWADFilenames[NUM_IWAD_TYPES + 1] =
{
    @"doom.wad",
    @"doom2.wad",
    @"tnt.wad",
    @"plutonia.wad",
    @"chex.wad",
    @"undefined"
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

- (void) setIWADConfig
{
    IWADLocation *iwadList[NUM_IWAD_TYPES];
    NSUserDefaults *defaults;
    NSString *key;
    NSString *value;
    unsigned int i;

    [self getIWADList: iwadList];

    // Load IWAD filename paths

    defaults = [NSUserDefaults standardUserDefaults];

    for (i=0; i<NUM_IWAD_TYPES; ++i)
    {
        key = IWADFilenames[i];
        value = [defaults stringForKey:key];

        if (value != nil)
        {
            [iwadList[i] setLocation:value];
        }
    }
}

// On startup, set the selected item in the IWAD dropdown

- (void) setDropdownSelection
{
    NSUserDefaults *defaults;
    NSString *selected;
    unsigned int i;

    defaults = [NSUserDefaults standardUserDefaults];
    selected = [defaults stringForKey: @"selected_iwad"];

    if (selected == nil)
    {
        return;
    }

    // Find this IWAD in the filenames list, and select it.

    for (i=0; i<NUM_IWAD_TYPES; ++i)
    {
        if ([selected isEqualToString:IWADFilenames[i]])
        {
            [self->iwadSelector selectItemWithTitle:IWADLabels[i]];
            break;
        }
    }
}

// Set the dropdown list to include an entry for each IWAD that has
// been configured.  Returns true if at least one IWAD is configured.

- (BOOL) setDropdownList
{
    IWADLocation *iwadList[NUM_IWAD_TYPES];
    BOOL have_wads;
    id location;
    unsigned int i;
    unsigned int enabled_wads;

    // Build the new list.

    [self getIWADList: iwadList];
    [self->iwadSelector removeAllItems];

    enabled_wads = 0;

    for (i=0; i<NUM_IWAD_TYPES; ++i)
    {
        location = [iwadList[i] getLocation];

        if (location != nil && [location length] > 0)
        {
            [self->iwadSelector addItemWithTitle: IWADLabels[i]];
            ++enabled_wads;
        }
    }

    // Enable/disable the dropdown depending on whether there
    // were any configured IWADs.

    have_wads = enabled_wads > 0;
    [self->iwadSelector setEnabled: have_wads];

    // Restore the old selection.

    [self setDropdownSelection];

    return have_wads;
}

- (void) saveConfig
{
    IWADLocation *iwadList[NUM_IWAD_TYPES];
    IWAD selectedIWAD;
    NSUserDefaults *defaults;
    NSString *key;
    NSString *value;
    unsigned int i;

    [self getIWADList: iwadList];

    // Store all IWAD locations to user defaults.

    defaults = [NSUserDefaults standardUserDefaults];

    for (i=0; i<NUM_IWAD_TYPES; ++i)
    {
        key = IWADFilenames[i];
        value = [iwadList[i] getLocation];

        [defaults setObject:value forKey:key];
    }

    // Save currently selected IWAD.

    selectedIWAD = [self getSelectedIWAD];
    [defaults setObject:IWADFilenames[selectedIWAD]
              forKey:@"selected_iwad"];
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
    [self saveConfig];
    [self setDropdownList];
}

- (void) awakeFromNib
{
    // Set configuration for all IWADs from configuration file.

    [self setIWADConfig];

    // Populate the dropdown IWAD list, and open the configuration
    // dialog if not yet configured.

    if ([self setDropdownList])
    {
        [self setDropdownSelection];
    }
    else
    {
        [self openConfigWindow: nil];
    }
}

// Set the DOOMWADPATH environment variable to contain the path to each
// of the configured IWAD files.

- (void) setEnvironment
{
    IWADLocation *iwadList[NUM_IWAD_TYPES];
    NSString *location;
    unsigned int i;
    unsigned int len;
    BOOL first;
    char *env;

    [self getIWADList: iwadList];

    // Calculate length of environment string.

    len = 30;

    for (i=0; i<NUM_IWAD_TYPES; ++i)
    {
        location = [iwadList[i] getLocation];

        if (location != nil && [location length] > 0)
        {
            len += [location length] + 1;
        }
    }

    // Build string.

    env = malloc(len);
    strcpy(env, "DOOMWADPATH=");

    first = YES;

    for (i=0; i<NUM_IWAD_TYPES; ++i)
    {
        location = [iwadList[i] getLocation];

        if (location != nil && [location length] > 0)
        {
            if (!first)
            {
                strcat(env, ":");
            }

            strcat(env, [location UTF8String]);
            first = NO;
        }
    }

    // Load into environment:

    putenv(env);

    //free(env);
}

@end

