//
//  SinMenuView.swift
//  DynamicSinMenu
//
//  Created by 覃子轩 on 2017/7/4.
//  Copyright © 2017年 覃子轩. All rights reserved.
//

import UIKit

class SinMenuView: UIView {
    
    var beginPoint:CGPoint! = nil
    var centerImg:UIImageView! = nil
    var imgCout:Int = 0
    
    init(frame: CGRect,_ imgNames:[String]) {
        super.init(frame: frame)
        
        self.imgCout = imgNames.count
        self.initCenterImg()
        self.initSinCircle(imgNames)
        
    }
    
    /// 初始化中间显示图案
    ///
    /// - returns:
    func initCenterImg() {
        let w = self.frame.width*0.3
        centerImg = UIImageView.init(frame: CGRect.init(x: 0, y: 0,width: w, height: w))
        centerImg.center = self.center
        centerImg.image = UIImage.init(named: "water")
        self.addSubview(centerImg)
    }
    
    /// 初始化图片包围的圆
    ///
    /// - parameter imgNames:
    ///
    /// - returns:
    func initSinCircle(_ imgNames:[String]) {
        
        for index in 0..<self.imgCout {
            
            let radius = self.frame.width*0.5
            let width = radius*0.4
            
            // 使用sin和cos构建一个圆
            let x:CGFloat = (radius-width*0.5)*CGFloat(sin(M_PI*2/Double(self.imgCout)*Double(index)))
            let y:CGFloat = (radius-width*0.5)*CGFloat(cos(M_PI*2/Double(self.imgCout)*Double(index)))
            
            let tempView:UIImageView = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: width, height: width))
            tempView.center = CGPoint.init(x: radius+x, y:radius-y)
            tempView.image = UIImage.init(named: imgNames[index])
            // tag标记，用于寻找
            tempView.tag = 100+index
            self.addSubview(tempView)
            
        }
    }
    
    /// 开始按下屏幕
    ///
    /// - parameter touches:
    /// - parameter event:
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.beginPoint = touches.first?.location(in: self.superview)
    }
    
    /// 按下并移动的过程中
    ///
    /// - parameter touches:
    /// - parameter event:
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let orginPoint = self.center
        let currentPoint = touches.first!.location(in: self.superview)
        
        // 使用拖动绘出的直线计算偏离角
        let angleBegin = atan2(self.beginPoint.y-orginPoint.y, self.beginPoint.x-orginPoint.x)
        let angleAfter = atan2(currentPoint.y-orginPoint.y,currentPoint.x-orginPoint.x)
        let angle = angleAfter-angleBegin
        
        // 改变自身的朝向
        self.transform = self.transform.rotated(by: angle)
        self.centerImg.transform = self.centerImg.transform.rotated(by: -angle)
        
        for index in 0..<self.imgCout {
            let view:UIView = self.viewWithTag(100+index)!
            view.transform = view.transform.rotated(by: -angle)
        }
        
        self.beginPoint = currentPoint
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
