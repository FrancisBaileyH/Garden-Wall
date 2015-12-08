//
//  FileViewController.swift
//  Garden Wall
//
//  Created by Francis Bailey on 2015-12-08.
//  Copyright © 2015 Francis Bailey. All rights reserved.
//

import UIKit


class FileViewController: UIViewController, UITextViewDelegate {
    
    
    
    @IBOutlet weak var fileTextView: UITextView!
    
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let fileManager = ContentBlockerFileManager()
        
        if let fileContents = fileManager.read("blockerList.json") {
            
            let ruleManager = ContentBlockerRuleManager(data: fileContents)
            
            self.fileTextView.text = ruleManager.getRawJSONString()
        }
        
    }
    
    
}