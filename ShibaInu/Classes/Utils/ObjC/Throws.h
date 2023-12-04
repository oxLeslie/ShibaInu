//
//  Throws.h
//  ShibaInu
//
//  Created by zQiu on 2022/4/6.
//

#import <Foundation/Foundation.h>

#ifndef Throws_h
#define Throws_h

static inline
void OCCatcher(void (NS_NOESCAPE ^ _Nonnull trier)(void),
               void (NS_NOESCAPE ^ _Nullable catcher)(NSException * _Nonnull exception))
{
    @try {
        trier();
    }
    @catch (NSException *exception) {
        if (catcher) {
            catcher(exception);
        }
    }
}

#endif /* Throws_h */
