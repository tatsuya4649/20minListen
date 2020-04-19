//
//  EnglishListViewControllerData.swift
//  20minListen
//
//  Created by 下川達也 on 2020/04/18.
//  Copyright © 2020 下川達也. All rights reserved.
//

import Foundation
import UIKit

extension EnglishListViewController{
    public func settingEnglishData(){
        if englishData == nil{
            englishData = Array<String>()
        }
        if englishTimeData == nil{
            englishTimeData = Array<String>()
        }
        if englishDataCollect == nil{
            englishDataCollect = Dictionary<String,SelectAction>()
        }
        if englishDataTimeString == nil{
            englishDataTimeString = Dictionary<String,String>()
        }
    }
}
