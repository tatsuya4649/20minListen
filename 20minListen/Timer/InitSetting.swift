//
//  ViewController.swift
//  20minListen
//
//  Created by 下川達也 on 2020/04/16.
//  Copyright © 2020 下川達也. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var startButton : UIButton!
    var timer : Timer!
    var englishArray : Array<String>!
    var timerLeft : Double!
    var timerLabel : UILabel!
    var TIMERLENGTH : Double!
    var backgroundTask: UIBackgroundTaskIdentifier = .invalid
    var nowEnglishString : String!
    var downloadTask:URLSessionDownloadTask!
    var badgeValue : Int!
    var appBadgeValue : Int!
    var audioRecorder : AVAudioRecorder!
    var talker : AVSpeechSynthesizer!
    var recordingSession: AVAudioSession!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        //ローカル通知を行う設定をする
        localNotification()
        //タイマーをスタートさせるボタンをセッティングする
        settingStartButton()
        //英語の配列を準備する関数
        englishSetting()
        do{
            print("音声を流します")
            let audioSession: AVAudioSession = AVAudioSession.sharedInstance()
            try audioSession.setCategory(AVAudioSession.Category.playAndRecord,mode: .default,options: [.defaultToSpeaker])
            try audioSession.setActive(true, options: [.notifyOthersOnDeactivation])
        }catch{
            print("Audio再生のセットカテゴリに失敗しました。")
        }
        // Do any additional setup after loading the view.
    }

    @objc func enterBackground(_ notification:Notification){
        print(notification)
        self.backgroundTask = UIApplication.shared.beginBackgroundTask(){
            [weak self] in
            UIApplication.shared.endBackgroundTask(self!.backgroundTask)
            self?.backgroundTask = .invalid
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
