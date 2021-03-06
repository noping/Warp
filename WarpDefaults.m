/*
 * WarpDefaults.m
 *
 * Copyright (c) 2007-2011 Kent Sutherland
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy of
 * this software and associated documentation files (the "Software"), to deal in
 * the Software without restriction, including without limitation the rights to use,
 * copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the
 * Software, and to permit persons to whom the Software is furnished to do so,
 * subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
 * FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
 * COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
 * IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
 * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

#import "WarpDefaults.h"
#import "WarpPreferences.h"

@implementation WarpDefaults

- (id)init
{
	if ( (self = [super init]) ) {
		if ([[NSUserDefaults standardUserDefaults] persistentDomainForName:WarpBundleIdentifier] == nil) {
			NSDictionary *defaultSettings = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithDouble:0.75], @"Delay",
																					[NSNumber numberWithBool:NO], @"WarpMouse",
																					[NSNumber numberWithBool:YES], @"CheckForUpdates",
																					[NSNumber numberWithInt:125], @"PagerCellWidth", nil];
			
			[[NSUserDefaults standardUserDefaults] setPersistentDomain:defaultSettings forName:WarpBundleIdentifier];
		}
	}
	return self;
}

- (void)setValue:(id)value forKey:(NSString *)key
{
	[self willChangeValueForKey:key];
	
	NSMutableDictionary *dictionary = [[[NSUserDefaults standardUserDefaults] persistentDomainForName:WarpBundleIdentifier] mutableCopy];
	[dictionary setValue:value forKey:key];
	[[NSUserDefaults standardUserDefaults] setPersistentDomain:dictionary forName:WarpBundleIdentifier];
	[dictionary release];
	
	[self didChangeValueForKey:key];
	
	[[NSDistributedNotificationCenter defaultCenter] postNotificationName:@"WarpDefaultsChanged" object:nil];
}

- (id)valueForKey:(NSString *)key
{
	return [[[NSUserDefaults standardUserDefaults] persistentDomainForName:WarpBundleIdentifier] valueForKey:key];
}

@end
