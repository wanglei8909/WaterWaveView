//
//  WaveView.swift
//  WaveView
//
//  Created by 王蕾 on 16/2/24.
//  Copyright © 2016年 Apple inc. All rights reserved.
//

import UIKit

class WaveView: UIView {
    
    var shapeLayer : CAShapeLayer
    var displayLink : CADisplayLink?
    var waterWaveHeight : CGFloat
    var zoomY : CGFloat
    var translateX : CGFloat
    var flag : Bool
    var iWaterWavePath : CGMutablePathRef
    
    
    override init(frame: CGRect) {
        self.shapeLayer = CAShapeLayer.init()
        self.waterWaveHeight = 0;
        self.zoomY = 1.0
        self.translateX = 0.0
        self.flag = false
        self.iWaterWavePath = CGPathCreateMutable();
        
        super.init(frame: frame)
        
        self.commitInit()
        
        self.addShapeLayer()
        
        self.startDisplayLink()
    }
    
    func commitInit(){
        self.waterWaveHeight = self.frame.size.height/2;
    }
    
    func addShapeLayer(){
        self.shapeLayer.path = self.waterWavePath();
        self.shapeLayer.fillColor = UIColor.init(red: 125/255, green: 207/255, blue: 233/255, alpha: 1).CGColor
        self.shapeLayer.lineWidth = 0.1
        self.shapeLayer.strokeColor = UIColor.redColor().CGColor
        self.layer.addSublayer(self.shapeLayer)
        
    }
    
    func waterWavePath() -> CGPathRef{
        iWaterWavePath = CGPathCreateMutable();
        CGPathMoveToPoint(iWaterWavePath, nil, 0,self.waterWaveHeight)
        var y :CGFloat
        y = 0.0;
        var x :CGFloat
        for x = 0; (x<self.frame.size.width); x++ {
            y = CGFloat(self.zoomY * sin( x / 180 * CGFloat(M_PI) - 4 * self.translateX / CGFloat(M_PI)) * 5) + self.waterWaveHeight
            CGPathAddLineToPoint(iWaterWavePath, nil, x, y)
        }
        
        CGPathAddLineToPoint(iWaterWavePath, nil, self.frame.size.width, self.frame.size.height);
        CGPathAddLineToPoint(iWaterWavePath, nil, 0, self.frame.size.height);
        CGPathAddLineToPoint(iWaterWavePath, nil, 0, self.waterWaveHeight);
        return iWaterWavePath
    }
    
    func startDisplayLink(){
        self.displayLink = CADisplayLink.init(target: self, selector: Selector("handleDisplayLink:"))
        [self.displayLink! .addToRunLoop(NSRunLoop.currentRunLoop(), forMode: NSDefaultRunLoopMode)]
    }
    
    func handleDisplayLink(displayLink :CADisplayLink){
        self.translateX += 0.1;
        if(!self.flag){
            self.zoomY += 0.02;
            if(self.zoomY >= 1.5){
                self.flag = true
            }
        }
        else{
            self.zoomY -= 0.02
            if(self.zoomY <= 1.0){
                self.flag = false
            }
        }
        
        self.shapeLayer.path = self.waterWavePath()
    }
    
    func stopDisplayLink(){
        self.displayLink!.invalidate()
        self.displayLink = nil
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
