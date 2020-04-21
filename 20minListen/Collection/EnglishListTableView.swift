//
//  EnglishListTableView.swift
//  20minListen
//
//  Created by 下川達也 on 2020/04/18.
//  Copyright © 2020 下川達也. All rights reserved.
//

import Foundation
import UIKit

extension EnglishListViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return englishData != nil ? englishData.count : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "englishCell") as! EnglishListCell
        for view in cell.contentView.subviews{
            view.removeFromSuperview()
        }
        let time = englishTimeData[indexPath.item]
        if let english = englishDataTimeString[time],
            let correct = englishDataCollect[time]
        {
            cell.setUp(self.view.frame.size.width,english,time,correct)
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        print(index)
        print("tableViewの高さを算出します。")
        let time = englishTimeData[indexPath.item]
        if let english = englishDataTimeString[time],
            let correct = englishDataCollect[time]
        {
            return EnglishListCell.returnHeight(tableView.frame.size.width,english,time,correct)
        }
        return 0
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let time = englishTimeData[indexPath.row]
        englishTimeData.remove(at: indexPath.row)
        englishData.remove(at: indexPath.row)
        englishDataCollect.removeValue(forKey: time)
        englishDataTimeString.removeValue(forKey: time)
        //tableViewCellの削除
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    
    public func settingTableView(){
        englihTabelView = UITableView(frame: CGRect(x: 0, y: self.navigationController!.navigationBar.frame.size.height + UIApplication.shared.statusBarFrame.height, width: self.view.frame.size.width, height: self.view.frame.size.height - (self.tabBarController!.tabBar.frame.size.height + self.navigationController!.navigationBar.frame.size.height + UIApplication.shared.statusBarFrame.height)), style: .plain)
        englihTabelView.register(EnglishListCell.self, forCellReuseIdentifier: "englishCell")
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshTable), for: .valueChanged)
        englihTabelView.refreshControl = refreshControl
        englihTabelView.dataSource = self
        englihTabelView.delegate = self
        self.view.addSubview(englihTabelView)
        guard let englishData = englishData else{return}
        guard englishData.count > 0 else{return}
        englihTabelView.reloadData()
    }
    @objc func refreshTable(_ sender:UIRefreshControl){
        sender.endRefreshing()
    }
}
