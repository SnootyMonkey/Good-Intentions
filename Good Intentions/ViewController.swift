//
//  ViewController.swift
//  Good Intentions
//
//  Created by Sean Johnson on 10/14/20.
//  Copyright © 2020 Snooty Monkey. All rights reserved.
//

import Darwin
import Cocoa

// Future config:
// Launch app's name
// Time slots (begin, end)
// App time out

class ViewController: NSViewController {

    @IBOutlet weak var quitButton: NSButton!
    @IBOutlet weak var quitButtonCell: NSButtonCell!
    @IBOutlet weak var launchButton: NSButton!
    @IBOutlet weak var launchButtonCell: NSButtonCell!
    @IBOutlet weak var intentMsgField: NSTextField!
    @IBOutlet weak var nowField: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Set action button colors
        
        // CSS #265500
        quitButtonCell.backgroundColor = NSColor.init(red: 0.149019608,
                                                      green: 0.333333333,
                                                      blue: 0.0,
                                                      alpha: 1.0)
        // CSS #b7241b
        launchButtonCell.backgroundColor = NSColor.init(red: 0.717647059,
                                                        green: 0.141176471,
                                                        blue: 0.105882353,
                                                        alpha: 1.0)

        // Get the current time
        let now = Date()
        print(now)

        // Immediately launch the app if in the time window
     
        // let calendar = Calendar.current
        // let hour = calendar.component(.hour, from: now)
        // let minutes = calendar.component(.minute, from: now)

        // Set the current time in the UI
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.timeStyle = .short
        nowField.stringValue = formatter.string(from: now)
        
        // Set the intent message in the UI
        let intentMsg = "Your intent is to check email at 8:30, 11:30 and 15:30."
        let font = NSFont.systemFont(ofSize: 12)
        let boldFont = NSFont.boldSystemFont(ofSize: 12)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        let attributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: NSColor.white,
            .paragraphStyle: paragraphStyle
        ]
        let boldAttributes: [NSAttributedString.Key: Any] = [
            .font: boldFont,
            .foregroundColor: NSColor.white,
            .paragraphStyle: paragraphStyle
        ]
        let intentMsgString = NSMutableAttributedString(string: intentMsg,attributes: attributes)
        intentMsgString.setAttributes(boldAttributes,range: NSRange(location: 33, length: 4))
        intentMsgString.setAttributes(boldAttributes,range: NSRange(location: 40, length: 4))
        intentMsgString.setAttributes(boldAttributes,range: NSRange(location: 50, length: 4))
        intentMsgField.attributedStringValue = intentMsgString

        // Start the app timer
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
        // On macOS 10.15+ the following is preferred
        // let appURL = URL(fileURLWithPath: "/Applications/MailMate.app")
        // NSWorkspace.shared.openApplication(at: appURL,
        //                                    configuration: <#T##NSWorkspace.OpenConfiguration#>,
        //                                    completionHandler: <#T##((NSRunningApplication?, Error?) -> Void)?##((NSRunningApplication?, Error?) -> Void)?##(NSRunningApplication?, Error?) -> Void#>)
        NSWorkspace.shared.launchApplication("MailMate")
        exit(0)
    }

}
