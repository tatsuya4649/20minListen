//
//  TabBarController.swift
//  20minListen
//
//  Created by 下川達也 on 2020/04/18.
//  Copyright © 2020 下川達也. All rights reserved.
//

import UIKit
import FontAwesome_swift

class TabBarController: UITabBarController {
    var timerViewController : ViewController!
    var englishViewController : EnglishListViewController!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timerViewController = ViewController()
        timerViewController.tabBarItem = UITabBarItem(title: "タイマー", image: UIImage.fontAwesomeIcon(name: .hourglass, style: .solid, textColor: .black, size: CGSize(width: 30, height: 30)), tag: 0)
        englishViewController = EnglishListViewController()
        englishViewController.tabBarItem = UITabBarItem(title: "コレクション", image: UIImage.fontAwesomeIcon(name: .list, style: .solid, textColor: .black, size: CGSize(width: 30, height: 30)), tag: 1)
        self.setViewControllers([timerViewController,UINavigationController(rootViewController: englishViewController)], animated: false)
        // Do any additional setup after loading the view.
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
