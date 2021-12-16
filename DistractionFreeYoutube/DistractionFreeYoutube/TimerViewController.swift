//
//  TimerViewController.swift
//  DistractionFreeYoutube
//
//  Created by Katrina Liu on 11/28/21.
//

import UIKit
import AVFoundation

class TimerViewController: UIViewController {
    
    @IBOutlet weak var setTimerButton: UIButton!
    @IBOutlet weak var timerTextField: UITextField!
    var minutesRemaining: Int = 0
    var secondsRemaining: Int = 0
    @IBOutlet weak var timeRemainingTextField: UILabel!
    var timer: Timer!
    
    var pause = false
    var firstPlay = true
    
    @IBOutlet weak var ringerSwitch: UISwitch!
    let systemSoundID: SystemSoundID = 1304
    var soundEnabled = true
    
    let shape = CAShapeLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTimerButton.layer.cornerRadius = 10
        
        let circlePath = UIBezierPath(
            arcCenter: CGPoint(
                x: UIScreen.main.bounds.size.width*0.5,
                y: UIScreen.main.bounds.size.height*0.36),
            radius: 100,
            startAngle: -(.pi / 2),
            endAngle: .pi * 3 / 2,
            clockwise: true)
        
        let trackShape = CAShapeLayer()
        trackShape.path = circlePath.cgPath
        trackShape.lineWidth = 15
        trackShape.strokeColor = UIColor.lightGray.cgColor
        trackShape.fillColor = UIColor.clear.cgColor
        view.layer.addSublayer(trackShape)
        
        shape.path = circlePath.cgPath
        shape.lineWidth = 15
        shape.strokeColor = UIColor(red: 250/255, green: 128/255, blue: 114/255, alpha: 1).cgColor
        shape.fillColor = UIColor.clear.cgColor
        shape.strokeEnd = 0
        view.layer.addSublayer(shape)
        
        
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
        
        //if first play do the following, else should continue animation
        if firstPlay {
            firstPlay = false
            let animation = CABasicAnimation(keyPath: "strokeEnd")
            animation.toValue = 1
            animation.duration = Double(timerTextField.text!)! * 60
            animation.isRemovedOnCompletion = false
            animation.fillMode = .forwards
            shape.add(animation, forKey: "animation")
        } else {
            changeState()
        }
    }
    
    @IBAction func pauseTapped(_ sender: Any) {
        timer.invalidate()
        changeState()
    }
    
    @objc func step() {
        if (minutesRemaining == 0 && secondsRemaining == 0) {
            timer.invalidate()
            secondsRemaining = 0
//            timeRemainingTextField.text = "\(Int(timerTextField.text!)!):00"
            timeRemainingTextField.text = "\(minutesRemaining):00"
            if soundEnabled {
                for _ in 1...5 {
                    AudioServicesPlaySystemSound(systemSoundID)
                }
            } else {
                AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
            }
            firstPlay = true
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
    
    @IBAction func switchDidChange(_ sender: UISwitch) {
        if sender.isOn {
            soundEnabled = true
        } else {
            soundEnabled = false
        }
    }
    
    func pauseLayer(layer: CALayer) {
        let pausedTime: CFTimeInterval = layer.convertTime(CACurrentMediaTime(), from: nil)
        layer.speed = 0.0
        layer.timeOffset = pausedTime
    }

    func resumeLayer(layer: CALayer) {
        let pausedTime: CFTimeInterval = layer.timeOffset
        layer.speed = 1.0
        layer.timeOffset = 0.0
        layer.beginTime = 0.0
        let timeSincePause: CFTimeInterval = layer.convertTime(CACurrentMediaTime(), from: nil) - pausedTime
        layer.beginTime = timeSincePause
    }
    
    @IBAction func changeState() {
        let layer = shape
        pause = !pause
        if pause {
            pauseLayer(layer: layer)
        } else {
            resumeLayer(layer: layer)
        }
    }
    
}
