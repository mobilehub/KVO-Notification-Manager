//
//  CTester.m
//  TouchCode
//
//  Created by Jonathan Wight on 06/30/10.
//  Copyright 2011 toxicsoftware.com. All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without modification, are
//  permitted provided that the following conditions are met:
//
//     1. Redistributions of source code must retain the above copyright notice, this list of
//        conditions and the following disclaimer.
//
//     2. Redistributions in binary form must reproduce the above copyright notice, this list
//        of conditions and the following disclaimer in the documentation and/or other materials
//        provided with the distribution.
//
//  THIS SOFTWARE IS PROVIDED BY TOXICSOFTWARE.COM ``AS IS'' AND ANY EXPRESS OR IMPLIED
//  WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND
//  FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL TOXICSOFTWARE.COM OR
//  CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
//  CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
//  SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
//  ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
//  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
//  ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//
//  The views and conclusions contained in the software and documentation are those of the
//  authors and should not be interpreted as representing official policies, either expressed
//  or implied, of toxicsoftware.com.

#import "CTester.h"

#import "NSObject_KVOBlock.h"

@interface CTester ()
- (void)testIdentifiers;
- (void)testTokens;
- (void)testOneShot;
@end

#pragma mark -

@implementation CTester

@synthesize testValue;

- (void)test
    {
    [self testIdentifiers];
    [self testTokens];
    [self testOneShot];
    }

- (void)testIdentifiers
    {
    NSLog(@"##### IDENTIFIERS #####");

    [self addKVOBlockForKeyPath:@"testValue" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld identifier:@"my_handler" handler:^(NSString *keyPath, id object, NSDictionary *change) {
        NSLog(@"I see you changed value from \"%@\" to \"%@\"", [change objectForKey:NSKeyValueChangeOldKey], [change objectForKey:NSKeyValueChangeNewKey]);
        }];

    self.testValue = @"A horse";
    self.testValue = @"is a horse";
    self.testValue = @"of course";
    self.testValue = @"of course.";
    self.testValue = NULL;

    [self removeKVOBlockForKeyPath:@"testValue" identifier:@"my_handler"];
    }

- (void)testTokens
    {
    NSLog(@"##### TOKENS #####");

    id theToken = [self addKVOBlockForKeyPath:@"testValue" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld handler:^(NSString *keyPath, id object, NSDictionary *change) {
        NSLog(@"I see you changed value from \"%@\" to \"%@\"", [change objectForKey:NSKeyValueChangeOldKey], [change objectForKey:NSKeyValueChangeNewKey]);
        }];

    self.testValue = @"A horse";
    self.testValue = @"is a horse";
    self.testValue = @"of course";
    self.testValue = @"of course.";
    self.testValue = NULL;

    [self removeKVOBlockForToken:theToken];
    }

- (void)testOneShot
    {
    NSLog(@"##### ONE SHOT #####");
    
    id theToken = [self addOneShotKVOBlockForKeyPath:@"testValue" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld handler:^(NSString *keyPath, id object, NSDictionary *change) {
        NSLog(@"I see you changed value from \"%@\" to \"%@\"", [change objectForKey:NSKeyValueChangeOldKey], [change objectForKey:NSKeyValueChangeNewKey]);
        }];

    self.testValue = @"A horse";
    self.testValue = @"is a horse";
    self.testValue = @"of course";
    self.testValue = @"of course.";
    self.testValue = NULL;

    [self removeKVOBlockForToken:theToken];
    }

@end
