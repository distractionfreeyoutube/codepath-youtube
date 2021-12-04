//
//  TimerViewController.swift
//  DistractionFreeYoutube
//
//  Created by Katrina Liu on 11/28/21.
//

import UIKit

class TimerViewController: UIViewController {
    
    @IBOutlet weak var setTimerButton: UIButton!
    @IBOutlet weak var timerTextField: UITextField!
    var minutesRemaining: Int = 0
    var secondsRemaining: Int = 0
    @IBOutlet weak var timeRemainingTextField: UILabel!
    var timer: Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTimerButton.layer.cornerRadius = 10
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func setTimer(_ sender: Any) {
        minutesRemaining = Int(timerTextField.text!)!
        secondsRemaining = 0
        timeRemainingTextField.text = "\(minutesRemaining):00"
    }
    
    @IBAction func playTapped(_ sender: Any) {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(step), userInfo: nil, repeats: true)
    }
    
    @IBAction func pauseTapped(_ sender: Any) {
        timer.invalidate()
    }
    
    @objc func step() {
        if (minutesRemaining == 0 && secondsRemaining == 0) {
            timer.invalidate()
            secondsRemaining = 0
            timeRemainingTextField.text = "\(Int(timerTextField.text!)!):00"
        } else if (secondsRemaining == 0) {
            secondsRemaining = 59
            minutesRemaining -= 1
            timeRemainingTextField.text = "\(minutesRemaining):\(secondsRemaining)"
        } else if (secondsRemaining <= 10){
            secondsRemaining -= 1
            timeRemainingTextField.text = "\(minutesRemaining):0\(secondsRemaining)"
        } else {
            secondsRemaining -= 1
            timeRemainingTextField.text = "\(minutesRemaining):\(secondsRemaining)"
        }
    }
}
