//
//  ActionRequestHandler.swift
//  ContentBlocker
//
//  Created by Francis Bailey on 2015-11-25.
//  Copyright © 2015 Francis Bailey. All rights reserved.
//

import UIKit
import MobileCoreServices


class ActionRequestHandler: NSObject, NSExtensionRequestHandling {

    func beginRequestWithExtensionContext(context: NSExtensionContext) {
        
        var attachment: NSItemProvider
        let fileManager = ContentBlockerFileManager.sharedInstance
        
        let url = NSURL(string: "blockerList.json", relativeToURL: fileManager.getSharedDirectoryURL())
        
        
        if fileManager.fileExists("blockerList.json") && url != nil  {
             
            attachment = NSItemProvider(contentsOfURL: url)!
        }
        else {
        
            attachment = NSItemProvider(contentsOfURL: NSBundle.mainBundle().URLForResource("blockerList", withExtension: "json"))!
        }
        
        
        let item = NSExtensionItem()
        item.attachments = [attachment]
    
        context.completeRequestReturningItems([item], completionHandler: nil);
    }
    
}
