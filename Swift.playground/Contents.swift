// import a module
import Foundation

struct LaunchTime {
       var hour:Int
       var minute:Int
   }

let launchTimes = [LaunchTime(hour: 8, minute: 30),
                  LaunchTime(hour: 11, minute: 30),
                  LaunchTime(hour: 15, minute: 30),
                  LaunchTime(hour: 18, minute: 0)]

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
let launchWindow:TimeInterval = 30 * 60.0 // 30m window
let fudgeFactor:TimeInterval = -2 * 60.0 // Allow a 2m too early window
print("Max launch interval: " + "\(launchWindow)")
for launchTime in launchTimesToday {
    let timeDelta = now.timeIntervalSince(launchTime)
    print("Interval: " +
          "\(timeDelta)")
    if (timeDelta >= fudgeFactor && timeDelta < launchWindow) {
        print("Launch!")
    } else {
        print("Not time.")
    }
}
