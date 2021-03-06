//
//  ViewControllerNotification.swift
//  20minListen
//
//  Created by 下川達也 on 2020/04/18.
//  Copyright © 2020 下川達也. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

extension ViewController:UNUserNotificationCenterDelegate{
    public func localNotification(){
        UNUserNotificationCenter.current().requestAuthorization(
        options: [.alert, .sound, .badge]){
            (granted, _) in
            if granted{
                UNUserNotificationCenter.current().delegate = self
            }
        }
    }
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound])  // 通知バナー表示、通知音の再生を指定
    }
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        guard let notification = response.notification as? UNNotification else{return}
        guard let request = notification.request as? UNNotificationRequest else{return}
        print(request)
        print(request.content.threadIdentifier)
        guard let nowEnglishString = nowEnglishString else{return}
        guard let parent = self.parent as? TabBarController else{return}
        if let collection = parent.viewControllers?.last?.children.first as? EnglishListViewController{
            guard let accessibility = request.content.summaryArgument as? String else {return}
            switch SelectAction(rawValue: response.actionIdentifier) {
            case .correct:
                collection.englishDataCollect![accessibility] = .correct
                collection.englishDataTimeString![accessibility] = nowEnglishString
            case .incorrect:
                collection.englishDataCollect![accessibility] = .incorrect
                collection.englishDataTimeString![accessibility] = nowEnglishString
            default:
                break
            }
            if collection.englihTabelView != nil{
                collection.englihTabelView.reloadData()
            }
        }
    }
}
