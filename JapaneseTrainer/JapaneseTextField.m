//
//  JapaneseTextField.m
//  JapaneseTrainer
//
//  Created by Luca Gramaglia on 03/05/16.
//  Copyright © 2016 Luca Gramaglia. All rights reserved.
//

#import "JapaneseTextField.h"
#import "Utilities.h"

@implementation JapaneseTextField

@synthesize userDefinedKeyboardLanguage;

- (UITextInputMode *) textInputMode {
    
    userDefinedKeyboardLanguage = @"ja-JP";
    
    for (UITextInputMode *tim in [UITextInputMode activeInputModes]) {
        if ([[Utilities langFromLocale:userDefinedKeyboardLanguage] isEqualToString:[Utilities langFromLocale:tim.primaryLanguage]]) return tim;
    }
    return [super textInputMode];
}
@end
