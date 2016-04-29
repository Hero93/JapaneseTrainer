//
//  ItalianTextField.h
//  JapaneseTrainer
//
//  Created by Luca Gramaglia on 28/04/16.
//  Copyright © 2016 Luca Gramaglia. All rights reserved.
//

#ifndef MultipleLanguageTextField_h
#define MultipleLanguageTextField_h

@import UIKit;

@interface ManyLanguagesTextField : UITextField

- (UITextInputMode *) textInputMode;
- (void) setKeyboardLanguage: (NSString*) language;

@property (nonatomic, assign) NSString* userDefinedKeyboardLanguage;

@end

#endif /* MultipleLanguageTextField_h */
