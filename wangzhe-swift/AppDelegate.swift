//
//  AppDelegate.swift
//  wangzhe-swift
//
//  Created by Joint on 2019/7/22.
//  Copyright © 2019年 Joint. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let mainWindows = UIWindow(frame: UIScreen.main.bounds)
        
        let hero = ViewController()
        hero.title = "英雄"
        hero.tabBarItem.title = "英雄"
        hero.tabBarItem.image = UIImage.init(named: "hero")
        let n1 = UINavigationController(rootViewController: hero)
        n1.navigationBar.tintColor = CustomColor.textColorWhite
        n1.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: CustomColor.textColorWhite]
        n1.navigationBar.barTintColor = CustomColor.mainColor
        n1.navigationBar.isTranslucent = false //关闭导航栏半透明效果
        
        let equip = EquiqViewController()
        equip.title = "装备"
        equip.tabBarItem.title = "英雄"
        equip.tabBarItem.image = UIImage.init(named: "hero")
        let n2 = UINavigationController(rootViewController: equip)
        n2.navigationBar.tintColor = CustomColor.textColorWhite
        n2.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: CustomColor.textColorWhite]
        n2.navigationBar.barTintColor = CustomColor.mainColor
        n2.navigationBar.isTranslucent = false //关闭导航栏半透明效果
        
        let ming = MingViewController()
        ming.title = "铭文"
        ming.tabBarItem.title = "英雄"
        ming.tabBarItem.image = UIImage.init(named: "hero")
        let n3 = UINavigationController(rootViewController: ming)
        n3.navigationBar.tintColor = CustomColor.textColorWhite
        n3.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: CustomColor.textColorWhite]
        n3.navigationBar.barTintColor = CustomColor.mainColor
        n3.navigationBar.isTranslucent = false //关闭导航栏半透明效果
        
        let sum = SummonViewController()
        sum.title = "技能"
        sum.tabBarItem.title = "英雄"
        sum.tabBarItem.image = UIImage.init(named: "hero")
        let n4 = UINavigationController(rootViewController: sum)
        n4.navigationBar.tintColor = CustomColor.textColorWhite
        n4.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: CustomColor.textColorWhite]
        n4.navigationBar.barTintColor = CustomColor.mainColor
        n4.navigationBar.isTranslucent = false //关闭导航栏半透明效果
        
        let tabbar = UITabBarController()
        tabbar.tabBar.tintColor = CustomColor.textColorWhite
        tabbar.tabBar.barTintColor = CustomColor.mainColor
        tabbar.tabBar.unselectedItemTintColor = UIColor.gray
        tabbar.viewControllers = [n1, n2, n3, n4]
        
        mainWindows.rootViewController = tabbar
        window = mainWindows
        window?.makeKeyAndVisible()
        
        Video.creatTable()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

