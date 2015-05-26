//
//  main.m
//  keychainonce
//
//  Created by nlog2n on 26/5/15.
//  Copyright (c) 2015 nlog2n. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "keychain.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"generate nonce by keychain:");
        
        NSError *anyError;
        
        BOOL success = [STKeychain storeUsername:@"User" andPassword:@"123"
                   forServiceName:@"TestService" updateExisting:YES error:&anyError];
        if (!success) {
            NSLog(@"store a nonce with error: %@", anyError);
            // present error to user
            return 1;
        }
        NSLog (@"store a nonce OK");
        
        NSString *nonce = [STKeychain getPasswordForUsername:@"User" andServiceName:@"TestService" error:&anyError];
        NSLog (@"get the nonce:%@", nonce);
        
        success = [STKeychain deleteItemForUsername:@"User" andServiceName:@"TestService" error:&anyError];
        if (!success) {
            NSLog(@"remove the nonce with error: %@", anyError);
            // present error to user
            return 1;
        }
        NSLog (@"remove the nonce OK");
        
    }
    return 0;
}
