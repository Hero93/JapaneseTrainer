//
//  ItalianTextField.m
//  JapaneseTrainer
//
//  Created by Luca Gramaglia on 03/05/16.
//  Copyright © 2016 Luca Gramaglia. All rights reserved.
//

#import "ItalianTextField.h"
#import "Utilities.h"

@implementation ItalianTextField

@synthesize userDefinedKeyboardLanguage;

- (UITextInputMode *) textInputMode {
    
    userDefinedKeyboardLanguage = @"it-IT";
    
    for (UITextInputMode *tim in [UITextInputMode activeInputModes]) {
        if ([[Utilities langFromLocale:userDefinedKeyboardLanguage] isEqualToString:[Utilities langFromLocale:tim.primaryLanguage]]) return tim;
    }
    return [super textInputMode];
}
@end
