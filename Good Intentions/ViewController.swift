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
    @IBOutlet weak var quitButtonCell: NSButtonCell!
    @IBOutlet weak var launchButton: NSButton!
    @IBOutlet weak var launchButtonCell: NSButtonCell!
    @IBOutlet weak var intentMsgField: NSTextField!
    @IBOutlet weak var nowField: NSTextField!

    struct LaunchTime {
        var hour:Int
        var minute:Int
    }

    // Future app config:
    let appName = "MailMate" // App to launch
    let launchTimes = [LaunchTime(hour: 8, minute: 30),
                       LaunchTime(hour: 11, minute: 30),
                       LaunchTime(hour: 15, minute: 30),
                       LaunchTime(hour: 18, minute: 0)]
    let launchWindow:TimeInterval = 30 * 60.0 // Allow a 30m launch window
    let fudgeFactor:TimeInterval = -2 * 60.0 // Allow a 2m too early window
    let appTimeout = 30.0 // Close the app in 30s if no decision was made
    
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
        let calendar = Calendar.current
        
        // Get the intended launch times
        var launchTimesToday = [Date]()
        for launchTime in launchTimes {
            launchTimesToday.append(calendar.date(bySettingHour:
                                                  launchTime.hour,
                                                  minute: launchTime.minute,
                                                  second: 0,
                                                  of: now)!)
        }
        // Immediately launch the app if in the time window
        for launchTime in launchTimesToday {
            let timeDelta = now.timeIntervalSince(launchTime)
            if (timeDelta >= fudgeFactor && timeDelta < launchWindow) {
                launchApp() // in the intended time window, so just launch
            }
        }

        // Monitor keystrokes
        NSEvent.addLocalMonitorForEvents(matching: .keyDown) {
            self.keyDown(with: $0)
            return $0
        }
        
        // Set the current time in the UI
        let formatter = DateFormatter()
        formatter.dateFormat = "H:mm"
        // This is more desirable to let user locale control the time
        // but then it's losing the 12/24h user preference switching
        // formatter.dateStyle = .none
        // formatter.timeStyle = .short
        nowField.stringValue = formatter.string(from: now)
        
        // Set the intent message in the UI
        let intentMsg = "Your intent is to check email at 8:30, 11:30, 15:30, and 18:00."
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
        intentMsgString.setAttributes(boldAttributes,range: NSRange(location: 46, length: 4))
        intentMsgString.setAttributes(boldAttributes,range: NSRange(location: 57, length: 4))
        intentMsgField.attributedStringValue = intentMsgString

        // Start the app timeout timer
        Timer.scheduledTimer(timeInterval: appTimeout,
                                   target: self,
                                 selector: #selector(timeout),
                                 userInfo: nil,
                                  repeats: false)
    }

    override func keyDown(with event: NSEvent) {
        if (event.keyCode == 76) {
            quit()
        }
    }
    
    @IBAction func quit(sender: NSButton) {
        quit()
    }

    @objc func timeout() {
        quit()
    }
    
    @IBAction func launch(sender: NSButton) {
        launchApp()
    }

    func quit() {
        exit(0)
    }
    
    func launchApp() {
        // On macOS 10.15+ the following is preferred
        // let appURL = URL(fileURLWithPath: "/Applications/MailMate.app")
        // NSWorkspace.shared.openApplication(at: appURL,
        //                                    configuration: <#T##NSWorkspace.OpenConfiguration#>,
        //                                    completionHandler: <#T##((NSRunningApplication?, Error?) -> Void)?##((NSRunningApplication?, Error?) -> Void)?##(NSRunningApplication?, Error?) -> Void#>)
        NSWorkspace.shared.launchApplication(appName)
        quit()
    }
}
