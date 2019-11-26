//
//  TabBarController.swift
//  UITableViewController-Sample01
//
//  Created by Kusokamayarou on 2019/11/26.
//  Copyright © 2019 Makurazakiutoya. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        // 「AutoLayoutをコードから指定する, アニメーションさせながらAutoLayoutを変更する - Qiita」
        // <https://qiita.com/yokurin/items/4932ab488b5b503f2dd5>
        // 「ios - Swift | Adding constraints programmatically - Stack Overflow」
        // <https://stackoverflow.com/questions/26180822/swift-adding-constraints-programmatically>
        let tabBarButtons = self.tabBarButtons()
        // item 1
        tabBarButtons![0].translatesAutoresizingMaskIntoConstraints = false
        self.view.addConstraints([
            NSLayoutConstraint(item: tabBarButtons![0], attribute: .top, relatedBy: .equal,
                toItem: tabBar, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: tabBarButtons![0], attribute: .bottom, relatedBy: .equal,
                toItem: tabBar, attribute: .bottom, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: tabBarButtons![0], attribute: .left, relatedBy: .equal,
                toItem: tabBar, attribute: .left, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: tabBarButtons![0], attribute: .width, relatedBy: .equal,
                toItem: nil, attribute: .notAnAttribute,  multiplier: 1, constant: 0)
            ])
        // item 2
        tabBarButtons![1].translatesAutoresizingMaskIntoConstraints = false
        self.view.addConstraints([
            NSLayoutConstraint(item: tabBarButtons![1], attribute: .top, relatedBy: .equal,
                toItem: tabBar, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: tabBarButtons![1], attribute: .bottom, relatedBy: .equal,
                toItem: tabBar, attribute: .bottom, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: tabBarButtons![1], attribute: .left, relatedBy: .equal,
                toItem: tabBarButtons![0], attribute: .right, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: tabBarButtons![1], attribute: .width,  relatedBy: .equal,
                toItem: tabBar, attribute: .width,  multiplier: 0.3333, constant: 0)
            ])
        // item 3
        tabBarButtons![2].translatesAutoresizingMaskIntoConstraints = false
        self.view.addConstraints([
            NSLayoutConstraint(item: tabBarButtons![2], attribute: .top, relatedBy: .equal,
                               toItem: tabBar, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: tabBarButtons![2], attribute: .bottom, relatedBy: .equal,
                               toItem: tabBar, attribute: .bottom, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: tabBarButtons![2], attribute: .left, relatedBy: .equal,
                               toItem: tabBarButtons![1], attribute: .right, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: tabBarButtons![2], attribute: .right, relatedBy: .equal,
                               toItem: tabBarButtons![3], attribute: .left, multiplier: 1, constant: 0)
            ])
        // item 4
        tabBarButtons![3].translatesAutoresizingMaskIntoConstraints = false
        self.view.addConstraints([
            NSLayoutConstraint(item: tabBarButtons![3], attribute: .top, relatedBy: .equal,
                               toItem: tabBar, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: tabBarButtons![3], attribute: .bottom, relatedBy: .equal,
                               toItem: tabBar, attribute: .bottom, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: tabBarButtons![3], attribute: .right, relatedBy: .equal,
                               toItem: tabBar, attribute: .right, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: tabBarButtons![3], attribute: .width,  relatedBy: .equal,
                               toItem: tabBar, attribute: .width,  multiplier: 0.3333, constant: 0)
            ])
        // ios - How to definitively set UITabBar background color and UITabBar tint color - Stack Overflow
        // https://stackoverflow.com/questions/37626377/how-to-definitively-set-uitabbar-background-color-and-uitabbar-tint-color
        self.tabBar.barTintColor = .systemBackground
    }
    // 「小ネタ：UITabBarControllerに「モーダル表示するボタン」を追加する(Swift) - Qiita」
    // <https://qiita.com/paming/items/a1413480358fa81728cf>
    override func viewDidLayoutSubviews() {
        let tabBarButtons = self.tabBarButtons()
        UIView.setAnimationsEnabled(false)
        // item 1
        tabBarButtons![0].alpha = 0.0
        tabBarButtons![0].backgroundColor = .red
        tabBarButtons![0].layoutIfNeeded()
        // item 2
        tabBarButtons![1].backgroundColor = .cyan
        tabBarButtons![1].layoutIfNeeded()
        // item 3
        tabBarButtons![2].backgroundColor = .green
        tabBarButtons![2].layoutIfNeeded()
        // item 4
        tabBarButtons![3].backgroundColor = .yellow
        tabBarButtons![3].layoutIfNeeded()
        UIView.setAnimationsEnabled(true)
    }
}

extension TabBarController: UITabBarControllerDelegate {
    // 「swiftでUITabBarの特定のタブをタップした時にモーダル - Qiita」
    // https://qiita.com/higan96/items/5ea742b59a48a34baa32
    internal func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        self.viewDidLayoutSubviews()
        return true
    }
    // 「[Swift]タブ切り替え時に切り替え先のメソッドを実行する」
    // https://nobuhiroharada.net/2018/04/06/change-tab/
    internal func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
    }
}

// 「Swift - UITabbarControllerにモーダル表示するボタンを追加(68046)｜teratail」
// <https://teratail.com/questions/68046>
extension TabBarController {
    func tabBarButtons() -> [UIView]? {
        return self.tabBar.subviews.reduce([], {
            (ret: [UIView], item:AnyObject) -> [UIView] in if let v = item as? UIView {
                if v.isKind(of: NSClassFromString("UITabBarButton")!) {
                    return ret + [v]
                }
            }
            return ret
        })
    }
}

