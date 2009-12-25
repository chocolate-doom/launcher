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
// Controller for the launcher program.
//
//-----------------------------------------------------------------------------

#include <AppKit/AppKit.h>
#include "LauncherManager.h"
#include "IWADList.h"

@implementation LauncherManager

// Callback invoked when the launch button is clicked.

- (void) launch: (id)sender
{
    printf("launch the game\n");
    printf("arguments: -iwad %s %s\n",
           [[iwadList getSelectedIwad] UTF8String],
           [[commandLineArguments stringValue] UTF8String]);
}

// Callback invoked when the setup tool button is clicked.

- (void) runSetup: (id)sender
{
    printf("run setup tool\n");
}

@end

