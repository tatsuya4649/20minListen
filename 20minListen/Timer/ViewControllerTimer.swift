//
//  ViewControllerTimerLabel.swift
//  20minListen
//
//  Created by 下川達也 on 2020/04/18.
//  Copyright © 2020 下川達也. All rights reserved.
//

import Foundation
import UIKit
import UserNotifications
import AVFoundation

enum SelectAction:String{
    case notAnswered
    case correct
    case incorrect
}
extension ViewController{
    @objc func timerEnglish(_ timer:Timer){
        guard let timerLeft = timerLeft else { return }
        guard startButton.isSelected == false else{return}
        changeTimerLabel()
        if self.timerLeft <= 0{
            guard let englishArray = englishArray else{return}
            //配列の要素からランダムに取り出すために乱数を取得
            let int = Int.random(in: 0..<englishArray.count)
            //乱数から取得した整数を元に英文を取得
            nowEnglishString = englishArray[int]
            let content = UNMutableNotificationContent()
            content.title = "what do you mean?"
            content.sound = UNNotificationSound(named: UNNotificationSoundName(rawValue: "lesson.mp3"))
            content.body = nowEnglishString
            content.categoryIdentifier = "categorySelect"
            let request = UNNotificationRequest(identifier: self.nowGetTime(), content: content, trigger: nil)
            let actionOne = UNNotificationAction(identifier: SelectAction.correct.rawValue,
                                                title: "正解",
                                                options: [.foreground])
            let actionTwo = UNNotificationAction(identifier: SelectAction.incorrect.rawValue,
                                                title: "不正解",
                                                options: [.destructive])
            let category = UNNotificationCategory(identifier: "categorySelect",
                                                  actions: [actionOne, actionTwo],
                                                  intentIdentifiers: [],
                                                  options: [])
            UNUserNotificationCenter.current().setNotificationCategories([category])
            UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
            
            self.timerLeft = TIMERLENGTH
            addingEnglishArray()
        }else{
            self.timerLeft -= Double(1.0)
        }
    }
    
    private func downLoadURL(_ url:URL,completion:((URL)->Void)?){
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let task = session.dataTask(with: url, completionHandler: {[weak self] (data, response, error) in
            guard let _ = self else{return}
            do{
                if let writePath = NSURL(fileURLWithPath:NSTemporaryDirectory()).appendingPathComponent("tmp.mp3") {
                    try data?.write(to: writePath)
                    completion?(writePath)
                }
            }catch{
                
            }
        })
        task.resume()
    }
    private func nowGetTime() -> String{
        let now = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "yyyy/MM/dd HH:mm:ss", options: 0, locale: Locale(identifier: "ja_JP"))
        let string = formatter.string(from: now)
        return string
    }
    func changeTimerLabel(){
        if timerLabel == nil{
            timerLabel = UILabel()
            timerLabel.font = .systemFont(ofSize: 30)
            self.view.addSubview(timerLabel)
        }
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .positional
        formatter.allowedUnits = [.minute,.second]
        let outputString = formatter.string(from: timerLeft)
        timerLabel.text = outputString
        timerLabel.sizeToFit()
        timerLabel.center = CGPoint(x: self.view.center.x, y: startButton.frame.minY - 10 - timerLabel.frame.size.height/2)
    }
    private func addingEnglishArray(){
        guard let parent = self.parent as? TabBarController else{return}
        if let collection = parent.viewControllers?.last?.children.first as? EnglishListViewController{
            if collection.englishData == nil{
                collection.englishData = Array<String>()
            }
            if collection.englishTimeData == nil{
                collection.englishTimeData = Array<String>()
            }
            if collection.englishDataCollect == nil{
                collection.englishDataCollect = Dictionary<String,SelectAction>()
            }
            if collection.englishDataTimeString == nil{
                collection.englishDataTimeString = Dictionary<String,String>()
            }
            collection.englishDataCollect![nowGetTime()] = .notAnswered
            collection.englishDataTimeString![nowGetTime()] = nowEnglishString
            collection.englishData.append(nowEnglishString)
            collection.englishTimeData.append(nowGetTime())
            if collection.englihTabelView != nil{
                collection.englihTabelView.reloadData()
            }
            if parent.selectedIndex == 0{
                if badgeValue == nil{
                    badgeValue = Int(0)
                }
                badgeValue += 1
                collection.tabBarItem.badgeValue = "\(badgeValue!)"
                UIApplication.shared.applicationIconBadgeNumber = badgeValue
            }else{
                badgeValue = nil
                collection.tabBarItem.badgeValue = nil
                if appBadgeValue == nil{
                    appBadgeValue = Int(0)
                }
                appBadgeValue += 1
                UIApplication.shared.applicationIconBadgeNumber = appBadgeValue
            }
        }
    }
}
