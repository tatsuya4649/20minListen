//
//  ViewControllerStartButton.swift
//  20minListen
//
//  Created by 下川達也 on 2020/04/18.
//  Copyright © 2020 下川達也. All rights reserved.
//

import Foundation
import UIKit

extension ViewController{
    public func settingStartButton(){
        startButton = UIButton()
        startButton.setTitle("タイマースタート(20分)", for: .normal)
        startButton.setTitleColor(.black, for: .normal)
        startButton.sizeToFit()
        startButton.titleLabel?.sizeToFit()
        startButton.isSelected = true
        startButton.center = self.view.center
        startButton.addTarget(self, action: #selector(startTimer), for: .touchUpInside)
        self.view.addSubview(startButton)
    }
    ///20分のタイマーをスタートして、タイマーが終了したらtimerEnglishを発動する
    @objc func startTimer(_ sender:UIButton){
        print("タイマーをスタートします。")
        if timer == nil{
            //単位は秒数だから、分にしたければminute*60,時間にしたければhour*60*60
            TIMERLENGTH = Double(60*20)
            timerLeft = TIMERLENGTH
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerEnglish), userInfo: nil, repeats: true)
            NotificationCenter.default.addObserver(self, selector: #selector(enterBackground), name: UIApplication.didEnterBackgroundNotification, object: nil)
        }
        switch sender.isSelected {
        case false:
            sender.isSelected = true
            startButton.setTitle("タイマーストップ中(20分)", for: .normal)
        case true:
            sender.isSelected = false
            startButton.setTitle("タイマースタート(20分)", for: .normal)
        default:
            break
        }
        startButton.sizeToFit()
        startButton.titleLabel?.sizeToFit()
    }
}
