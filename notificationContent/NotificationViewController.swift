//
//  NotificationViewController.swift
//  notificationCOntent
//
//  Created by 下川達也 on 2020/04/19.
//  Copyright © 2020 下川達也. All rights reserved.
//

import UIKit
import UserNotifications
import UserNotificationsUI
import FontAwesome_swift
import AVFoundation

class NotificationViewController: UIViewController, UNNotificationContentExtension {
    
    var repeatButton : UIButton!
    var notification : UNNotification!
    var talker : AVSpeechSynthesizer!
    var repeatButtonAnimation : CABasicAnimation!
    override func viewDidLoad() {
        super.viewDidLoad()
        settingButton()
        do{
            let audioSession: AVAudioSession = AVAudioSession.sharedInstance()
            try! audioSession.setCategory(AVAudioSession.Category.playback)
        }catch{
            print("Audio再生のセットカテゴリに失敗しました。")
        }
        // Do any required interface initialization here.
    }
    private func settingButton(){
        repeatButton = UIButton()
        repeatButton.setTitle(String.fontAwesomeIcon(name: .volumeUp), for: .normal)
        repeatButton.setTitleColor(.white, for: .normal)
        repeatButton.titleLabel?.font = UIFont.fontAwesome(ofSize: 25, style: .solid)
        repeatButton.sizeToFit()
        repeatButton.titleLabel?.sizeToFit()
        repeatButton.titleLabel?.textAlignment = .center
        repeatButton.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        repeatButton.backgroundColor = .black
        repeatButton.layer.cornerRadius = repeatButton.frame.size.height/2
        repeatButton.addTarget(self, action: #selector(clickRepeat), for: .touchUpInside)
        self.preferredContentSize = CGSize(width: self.view.frame.size.width, height: repeatButton.frame.size.height + 10)
        repeatButton.center = CGPoint(x: self.preferredContentSize.width/2, y: self.preferredContentSize.height/2)
        self.view.addSubview(repeatButton)
    }
    
    func didReceive(_ notification: UNNotification) {
        self.notification = notification
    }

}
