//
//  ViewController.swift
//  Assignment3
//
//  Created by Hronek Joseph on 1/18/23.
//

import UIKit

class ViewController: UIViewController {
    var timer = Timer()
    let dateFormatter = DateFormatter()
    var countdownTimer = Timer()
    var secondsLeft : Int = 0
    var selectedTime = Date();
    
    @IBOutlet weak var liveClockLabel: UILabel!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var remainingTimeLabel: UILabel!
    @IBOutlet weak var userTimePicker: UIDatePicker!
    @IBOutlet weak var timerButton: UIButton!
    
    @IBAction func userTimePickerChanged(_ sender: UIDatePicker) {
        if (remainingTimeLabel.text == "Remaining Time") {
            //TODO
            selectedTime = userTimePicker.date
        }
    }
    
    @IBAction func startTimer(_ sender: UIButton) {
        if (timerButton.titleLabel!.text == "Start Timer" && remainingTimeLabel.text == "Remaining Time") {
            //TODO: bring hours and minutes out???
            var hours = Calendar.current.dateComponents([.hour], from: selectedTime).hour!
            var minutes = Calendar.current.dateComponents([.minute], from: selectedTime).minute!
            secondsLeft = hours * 3600 + minutes * 60
            
            //TODO: format date output????
            remainingTimeLabel.text = "Time Remaining: \(selectedTime)"
            
            countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateRemainingTimeLabel) , userInfo: nil, repeats: true)
        } else if (timerButton.titleLabel!.text == "Stop Music") {
            timerButton.titleLabel!.text = "Start Timer"
            remainingTimeLabel.text = "Remaining Time"
            secondsLeft = 0
            
            //TODO: stop music
        }
    }
    
    @objc func updateRemainingTimeLabel() {
        if (secondsLeft > 0) {
            var hoursRemaining = secondsLeft/3600 > 0 ? "\(secondsLeft/3600)" : "0"
            var minutesRemaining = (secondsLeft%3600)/60 > 0 ? "\((secondsLeft%3600)/60)" : "0"
            var secondsRemaining = (secondsLeft%3600)%60 > 0 ? "\((secondsLeft%3600)%60)" : "0"
            
            if (Int(hoursRemaining)! < 10) {
                hoursRemaining = "0" + hoursRemaining
            }
            if (Int(minutesRemaining)! < 10) {
                minutesRemaining = "0" + minutesRemaining
            }
            if (Int(secondsRemaining)! < 10) {
                secondsRemaining = "0" + secondsRemaining
            }
            
            remainingTimeLabel.text = "Time Remaining: \(hoursRemaining):\(minutesRemaining):\(secondsRemaining)"
        } else {
            timerButton.titleLabel!.text = "Stop Music"
            //TODO: start music
            countdownTimer.invalidate()
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        dateFormatter.dateFormat = "E, d MMM yyyy HH:mm:ss"
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateLiveClockLabel) , userInfo: nil, repeats: true)
    }

    @objc func updateLiveClockLabel() {
        liveClockLabel.text = dateFormatter.string(from: Date())
        if (Calendar.current.component(.hour, from: Date()) > 12) {
            backgroundImage.image = UIImage(named: "PM")
        } else {
            backgroundImage.image = UIImage(named: "AM")
        }
    }
}

