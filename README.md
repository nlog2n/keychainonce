# keychainonce

Purpose: to allocate each iOS a unique ID for device identification and tracking. The ID, called device finger print, must be persistent information which can survive after app install and unstall. It must also be resistent from illegal tampering.

We want to achieve a device finger print solution without using Apple private API or jailbreaking/root. The idea is to get personalised information either from user preference or by hiding own DFP file somewhere like in keychain. In such cases there are two assumption ought to be satisfied:

      1. must work around with iOS sandbox r/w permission
      2. must find a persistent storage location in iOS file system

Method 1:  Collect Personal Info from preference files.
                  a. read content from user customised files, which should be persistent on mobile phone.
                  b. calculate a hash based digest as device finger print.

Method 2:  Hide my DFP file somewhere.
                  a. write in prior a file with unique identification number to a secret folder/keychain.
                  b. simply read this ID out as device finger print next time.
                


Main program:

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


Demo output:

2015-05-26 14:27:35.619 keychainonce[962:73388] generate nonce by keychain:
2015-05-26 14:27:35.641 keychainonce[962:73388] store a nonce OK
2015-05-26 14:27:35.647 keychainonce[962:73388] get the nonce:123
2015-05-26 14:27:35.654 keychainonce[962:73388] remove the nonce OK
