//
//  ViewController.swift
//  DynamicSinMenu
//
//  Created by 覃子轩 on 2017/7/4.
//  Copyright © 2017年 覃子轩. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var circlesView:[UIView] = []
    var imgNames:[String] = []
    var menuView:UIView! = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initImgNames()
        self.initMenuView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func initImgNames() {
        for index in 0..<6 {
            imgNames.append("data\(index)")
        }
    }
    
    func initMenuView() {
        let w = self.view.frame.width
        self.menuView = SinMenuView.init(frame: CGRect.init(x: 0, y: 0, width: w, height: w),self.imgNames)
        self.menuView.center = self.view.center
        self.view.addSubview(self.menuView)
    }
    

}

