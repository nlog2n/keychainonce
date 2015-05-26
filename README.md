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
                

