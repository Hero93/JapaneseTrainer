//
//  ItalianTextField.h
//  JapaneseTrainer
//
//  Created by Luca Gramaglia on 03/05/16.
//  Copyright © 2016 Luca Gramaglia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ItalianTextField : UITextField

- (UITextInputMode *) textInputMode;
@property (nonatomic, assign) NSString* userDefinedKeyboardLanguage;

@end
