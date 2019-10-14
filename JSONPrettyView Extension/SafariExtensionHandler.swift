//
//  SafariExtensionHandler.swift
//  JSONPrettyView Extension
//
//  Created by Guy on 12/10/2019.
//  Copyright © 2019 Houzz. All rights reserved.
//

import SafariServices

class SafariExtensionHandler: SFSafariExtensionHandler {
    
    override func messageReceived(withName messageName: String, from page: SFSafariPage, userInfo: [String : Any]?) {
        // This method will be called when a content script provided by your extension calls safari.extension.dispatchMessage("message").
        page.getPropertiesWithCompletionHandler { properties in
            NSLog("The extension received a message (\(messageName)) from a script injected into (\(String(describing: properties?.url))) with userInfo (\(userInfo ?? [:]))")
        }
    }
    
    override func toolbarItemClicked(in window: SFSafariWindow) {
        // This method will be called when your toolbar item is clicked.
        window.getActiveTab { (tab) in
            tab?.getActivePage(completionHandler: { (page) in
                page?.dispatchMessageToScript(withName: "toggle", userInfo: nil)
            })
        }
    }
    
    override func validateToolbarItem(in window: SFSafariWindow, validationHandler: @escaping ((Bool, String) -> Void)) {
        // This is called when Safari's state changed in some way that would require the extension's toolbar item to be validated again.
        validationHandler(false, "")
    }
    
    override func validateContextMenuItem(withCommand command: String, in page: SFSafariPage, userInfo: [String : Any]? = nil, validationHandler: @escaping (Bool, String?) -> Void) {
        guard let isJson = userInfo?["json"] as? Bool, isJson else {
            validationHandler(true, nil)
            return
        }
        switch command {
        case "original":
            let isFormatted = (userInfo?["tree"] as? Bool) ?? false
            validationHandler(!isFormatted, nil)
            
        case "format":
            let isFormatted = (userInfo?["tree"] as? Bool) ?? true
            validationHandler(isFormatted, nil)
            
        case "expand":
            validationHandler(false, nil)
            
        case "collapse":
            validationHandler(false, nil)

        default:
            break
        }
    }
    
    override func contextMenuItemSelected(withCommand command: String, in page: SFSafariPage, userInfo: [String : Any]? = nil) {
        switch command {
        case "original", "format":
            page.dispatchMessageToScript(withName: "toggle", userInfo: nil)
            
        case "expand", "collapse", "expand1":
            page.dispatchMessageToScript(withName: command, userInfo: nil)
            
        default:
            break
        }
    }
    
    override func popoverViewController() -> SFSafariExtensionViewController {
        return SafariExtensionViewController.shared
    }

}
