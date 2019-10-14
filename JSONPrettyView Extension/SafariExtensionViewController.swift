//
//  SafariExtensionViewController.swift
//  JSONPrettyView Extension
//
//  Created by Guy on 12/10/2019.
//  Copyright © 2019 Houzz. All rights reserved.
//

import SafariServices

class SafariExtensionViewController: SFSafariExtensionViewController {
    
    static let shared: SafariExtensionViewController = {
        let shared = SafariExtensionViewController()
        shared.preferredContentSize = NSSize(width:320, height:240)
        return shared
    }()

}
