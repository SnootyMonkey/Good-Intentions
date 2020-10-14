//
//  ViewController.swift
//  Good Intentions
//
//  Created by Sean Johnson on 10/14/20.
//  Copyright © 2020 Snooty Monkey. All rights reserved.
//

import Darwin
import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var quitButton: NSButton!
    @IBOutlet weak var launchButton: NSButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    @IBAction func quit(sender: NSButton) {
        exit(0)
    }

    @IBAction func launch(sender: NSButton) {
        // let appURL = URL(fileURLWithPath: "/Applications/MailMate.app")
        // 10.15+
        // NSWorkspace.shared.openApplication(at: appURL,
        //                                    configuration: <#T##NSWorkspace.OpenConfiguration#>,
        //                                    completionHandler: <#T##((NSRunningApplication?, Error?) -> Void)?##((NSRunningApplication?, Error?) -> Void)?##(NSRunningApplication?, Error?) -> Void#>)
        NSWorkspace.shared.launchApplication("MailMate")
        exit(0)
    }

}

