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
//
// Controller for managing the list of IWAD files.
//
//-----------------------------------------------------------------------------

#include <AppKit/AppKit.h>
#include "IWADList.h"

static id WAD_TYPES[] = {
    @"wad", @"WAD"
};

@implementation IWADList

// Constructor.

- init
{
    self = [super init];

    iwads = [NSMutableArray array];
    [iwads retain];

    return self;
}

// Callback invoked when the add IWAD button is clicked.

- (void) addIwad: (id)sender
{
    NSArray *wadTypes = [NSArray arrayWithObjects: WAD_TYPES count: 2];
    NSArray *filenames;
    id filename;
    NSOpenPanel *openPanel;
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
        [filename retain];
        [iwads addObject: filename];
        [iwadListTable reloadData];
    }
}

// Callback invoked when the delete IWAD button is clicked.

- (void) deleteIwad: (id)sender
{
    int row;
    id str;

    [iwadListTable setHeaderView: nil];

    // Check that a valid IWAD is selected.

    row = [iwadListTable selectedRow];

    if (row >= 0 && row < [iwads count])
    {
        str = [iwads objectAtIndex:row];

        // Remove from the list.

        [iwads removeObjectAtIndex: row];
        [str release];
        [iwadListTable reloadData];
    }
}

// Used by the table controller - returns number of rows for the table.

- (int) numberOfRowsInTableView:(NSTableView *)aTableView
{
printf("numberOfRowsInTableView\n");
    return [iwads count];
}

// Used by the table controller to get the contents for a cell.

- (id) tableView:(NSTableView *) aTableView
       objectValueForTableColumn: (NSTableColumn *) aTableColumn
       row: (int) rowIndex
{
printf("tableView\n");
    return [iwads objectAtIndex:rowIndex];
}

// Public interface to get the selected IWAD.

- (NSString *) getSelectedIwad
{
    if ([iwads count] <= 0)
    {
        return nil;
    }
    else
    {
        return [iwads objectAtIndex:[iwadListTable selectedRow]];
    }
}

@end

