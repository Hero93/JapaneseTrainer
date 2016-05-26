//
//  FileSystemUtility.swift
//  JapaneseTrainer
//
//  Created by Luca Gramaglia on 29/04/16.
//  Copyright © 2016 Luca Gramaglia. All rights reserved.
//

import Foundation

public class FileSystemUtility {
    
    func initApplicationSupportFolder() {
        
        if let appSupportDir = NSSearchPathForDirectoriesInDomains(.ApplicationSupportDirectory, .UserDomainMask, true).last {
            
            /* Check "ApplicationSupport" directory existence */
            if !NSFileManager.defaultManager().fileExistsAtPath(appSupportDir, isDirectory: nil) {
                
                /* Create "ApplicationSupport" directory */
                do {
                    try NSFileManager.defaultManager().createDirectoryAtPath(appSupportDir, withIntermediateDirectories: true, attributes: nil)
                } catch {
                    print(error)
                }
            }
            
            /* Mark the directory as excluded from iCloud backups */
            let url = NSURL.fileURLWithPath(appSupportDir)
            do {
                try url.setResourceValue(appSupportDir, forKey: NSURLIsExcludedFromBackupKey)
            } catch {
                print(error)
            }
        }
    }
    
    static func applicationSupportDirectory() -> String {
        return NSSearchPathForDirectoriesInDomains(.ApplicationSupportDirectory, .UserDomainMask, true)[0] as String
    }
    
    static func getCompletePathOfFileNameInApplicationSupport(fileName: String) -> String {        
        return applicationSupportDirectory().stringByAppendingString(fileName)
    }
}