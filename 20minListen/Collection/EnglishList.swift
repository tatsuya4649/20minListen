//
//  EnglishListViewController.swift
//  20minListen
//
//  Created by 下川達也 on 2020/04/18.
//  Copyright © 2020 下川達也. All rights reserved.
//

import UIKit

class EnglishListViewController: UIViewController {
    var englihTabelView : UITableView!
    var englishData : Array<String>!
    var englishTimeData : Array<String>!
    var englishDataCollect : Dictionary<String,SelectAction>!
    var englishDataTimeString : Dictionary<String,String>!
    var refreshControl : UIRefreshControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.title = "コレクション"
        self.navigationItem.leftBarButtonItem = editButtonItem
        settingEnglishData()
        settingTableView()
        NotificationCenter.default.addObserver(self, selector: #selector(viewWillEnterForeground(_:)), name: .NSExtensionHostWillEnterForeground, object: nil)
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarItem.badgeValue = nil
        UIApplication.shared.applicationIconBadgeNumber = 0
        guard let parent = self.parent as? TabBarController else{return}
        if let timer = parent.viewControllers?.first?.children.first as? ViewController{
            timer.appBadgeValue = nil
        }
    }
    override func setEditing(_ editing: Bool, animated: Bool) {
        //override前の処理を継続してさせる
        super.setEditing(editing, animated: animated)
        //tableViewの編集モードを切り替える
        englihTabelView.isEditing = editing //editingはBool型でeditButtonに依存する変数
    }
    @objc private func viewWillEnterForeground(_ notification:Notification){
        UIApplication.shared.applicationIconBadgeNumber = 0
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
