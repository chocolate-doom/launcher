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

#include "AppController.h"

@implementation AppController

+ (void)initialize
{
    NSMutableDictionary *defaults = [NSMutableDictionary dictionary];

    /*
     * Register your app's defaults here by adding objects to the
     * dictionary, eg
     *
     * [defaults setObject:anObject forKey:keyForThatObject];
     *
     */

    [[NSUserDefaults standardUserDefaults] registerDefaults:defaults];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (id)init
{
    if ((self = [super init]))
    {
    }

    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (void)awakeFromNib
{
    [[NSApp mainMenu] setTitle:@"ChocolateDoom"];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotif
{
// Uncomment if your application is Renaissance-based
//  [NSBundle loadGSMarkupNamed:@"Main" owner:self];
}

- (BOOL)applicationShouldTerminate:(id)sender
{
    return YES;
}

- (void)applicationWillTerminate:(NSNotification *)aNotif
{
}

- (BOOL)application:(NSApplication *)application openFile:(NSString *)fileName
{
    return NO;
}

- (void)showPrefPanel:(id)sender
{
}

@end

