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

#include <AppKit/AppKit.h>
#include "LauncherManager.h"
#include "config.h"

@implementation LauncherManager

- (void) launch: (id)sender
{
    NSString *iwad;
    NSString *args;

    iwad = [self->iwadController getIWADLocation];
    args = [self->commandLineArguments stringValue];

    printf("Command line: %s %s\n", [iwad UTF8String], [args UTF8String]);
}

- (void) runSetup: (id)sender
{
}

- (void) awakeFromNib
{
    [self->packageLabel setStringValue: @PACKAGE_STRING];
    [self->launcherWindow setTitle: @PACKAGE_NAME " Launcher"];
}

@end

