//
//  NotificationViewControllerSpeak.swift
//  notificationContent
//
//  Created by 下川達也 on 2020/04/19.
//  Copyright © 2020 下川達也. All rights reserved.
//

import Foundation
import AVFoundation
import UIKit

extension NotificationViewController:AVSpeechSynthesizerDelegate{
    @objc func clickRepeat(_ sender:UIButton){
        let sounds = notification.request.content.body
        let speech = AVSpeechUtterance(string: sounds)
        speech.voice = AVSpeechSynthesisVoice(language: "en-US")
        talker = AVSpeechSynthesizer()
        talker.delegate = self
        
        talker.speak(speech)
    }
    //スピーカーが喋り出したときに発動するメソッド
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didStart utterance: AVSpeechUtterance) {
        repeatButtonAnimation = CABasicAnimation(keyPath: "transform.scale")
        repeatButtonAnimation.fromValue = 1
        repeatButtonAnimation.toValue = 0.8
        repeatButtonAnimation.duration = 0.5
        repeatButtonAnimation.autoreverses = true
        repeatButtonAnimation.repeatCount = .infinity
        repeatButton.titleLabel?.layer.add(repeatButtonAnimation, forKey: "anima")
        repeatButton.backgroundColor = .lightGray
    }
    //スピーカーが喋り終わったときに発動するメソッド
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        repeatButton.titleLabel!.layer.removeAllAnimations()
        repeatButtonAnimation = nil
        repeatButton.backgroundColor = .black
    }
}
