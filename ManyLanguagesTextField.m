//
//  ItalianTextField.m
//  JapaneseTrainer
//
//  Created by Luca Gramaglia on 28/04/16.
//  Copyright © 2016 Luca Gramaglia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ManyLanguagesTextField.h"
#import "Utilities.h"

@implementation ManyLanguagesTextField
@synthesize userDefinedKeyboardLanguage;

- (UITextInputMode *) textInputMode {
    for (UITextInputMode *tim in [UITextInputMode activeInputModes]) {
        if ([[Utilities langFromLocale:userDefinedKeyboardLanguage] isEqualToString:[Utilities langFromLocale:tim.primaryLanguage]]) return tim;
    }
    return [super textInputMode];
}

- (void) setKeyboardLanguage: (NSString*) language {
    // I need to convert the parameter string with "stringWithFormat" if I don't want the app to crash.
    userDefinedKeyboardLanguage = [NSString stringWithFormat:@"%@", language];
}

@end
