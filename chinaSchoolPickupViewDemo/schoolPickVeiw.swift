//
//  File.swift
//  专业课
//
//  Created by 梓简王 on 2017/8/10.
//  Copyright © 2017年 梓简王. All rights reserved.
//

import Foundation
import UIKit

protocol schoolPickupViewDelegete{
    func pickerDidSelectName(name:String!)
    func cancelBtn()
}

class schoolPickupView: UIView,UIPickerViewDataSource,UIPickerViewDelegate {
    var cancelBtn:UIButton?
    var sureBtn:UIButton?
    var view:UIView?
    var picker:UIPickerView?
    var areaArr:NSMutableArray?
    var dataArr:NSMutableArray?
    var schoolName:NSMutableArray?
    var schoolArr:NSArray?
    var delegate:schoolPickupViewDelegete?
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.whiteColor()
        self.userInteractionEnabled = true
        self.layer.borderColor = UIColor.clearColor().CGColor
        self.layer.borderWidth =  1
        self.layer.cornerRadius = 2
        self.layer.masksToBounds = true
        cancelBtn = UIButton(type: UIButtonType.Custom)
        cancelBtn?.addTarget(self, action: "dismiss", forControlEvents: UIControlEvents.TouchUpInside)
        cancelBtn?.setTitle("取消", forState: UIControlState.Normal)
        cancelBtn?.titleLabel?.font = UIFont(name: "Georgia", size: 14)
        cancelBtn?.tag = 1
        cancelBtn?.frame = CGRectMake(10, 5, 40, 35)
        cancelBtn?.setTitleColor(UIColor.lightGrayColor(), forState: UIControlState.Normal)
        cancelBtn?.layer.masksToBounds = true
        self.addSubview(cancelBtn!)
        
        sureBtn = UIButton(type: UIButtonType.System)
        sureBtn?.addTarget(self, action: "selectSchool", forControlEvents: UIControlEvents.TouchUpInside)
        sureBtn?.setTitle("完成", forState: UIControlState.Normal)
        sureBtn?.tag = 2;
        
        sureBtn?.titleLabel?.font = UIFont(name: "Georgia", size: 14)
        sureBtn?.frame = CGRectMake(CGRectGetWidth(frame)-50, 5, 40, 35);
        self.addSubview(self.sureBtn!)
        
        picker = UIPickerView(frame: CGRectMake(10, 30, CGRectGetWidth(frame) - 10, CGRectGetHeight(frame)-50))
        
        picker!.delegate  = self;
        picker!.dataSource = self;
        picker!.showsSelectionIndicator = true;
        
        let plistPath = NSBundle.mainBundle().pathForResource("school", ofType: "plist")
        
        dataArr = NSMutableArray(contentsOfFile: plistPath!)
        
        areaArr = NSMutableArray(capacity: 0)
        schoolName = NSMutableArray(capacity: 0)
        
        
        for dic in dataArr!{
            let areaStr  =   (dic as! NSDictionary).valueForKey("area")
            areaArr?.addObject(areaStr!)
        }
        
        self.addSubview(picker!)
    }
    
    func dismiss(){
        self.delegate?.cancelBtn()
        hiddenSelf()
    }
    func selectSchool(){
        let rowOne:Int = (picker?.selectedRowInComponent(0))!
        let rowTwo:Int = (picker?.selectedRowInComponent(1))!
        var areaString:String = ""
        var schoolString:String = ""
        
        if(rowOne < areaArr?.count){
            areaString = areaArr![rowOne] as! String
        }
        if(rowTwo < schoolName?.count){
            schoolString = schoolName![rowTwo] as! String
        }
        self.delegate?.pickerDidSelectName(schoolString)
        hiddenSelf()
    }
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 2
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return (areaArr?.count)!
            break
        case 1:
            schoolName?.removeAllObjects()
            let selectIndex = picker?.selectedRowInComponent(0)
            if(selectIndex < dataArr?.count){
                let tempDic:NSDictionary = dataArr![selectIndex!] as! NSDictionary
                let tempArr:NSArray = tempDic["schoolArr"] as! NSArray
                for item in tempArr {
                    schoolName?.addObject(item)
                }
                schoolArr = tempArr
                return schoolName!.count;
            }
            break
        default:
            break
        }
        return 2
    }
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if (component==0) {
            if (row < areaArr!.count) {
                return areaArr![row] as! String;
            }
        }
        if (component==1) {
            
            if (row < schoolName!.count) {
                return schoolName![row] as! String;
            }
        }
        return nil
    }
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if (component == 0) {
            picker?.reloadComponent(1)
            picker?.selectRow(0, inComponent: 1, animated: true)
        }
    }
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView?) -> UIView {
        var pickLabel:UILabel?
        if (pickLabel == nil) {
            pickLabel = UILabel()
            pickLabel?.font = UIFont(name: "Georgia", size: 14)
            pickLabel?.backgroundColor = UIColor.clearColor()
            pickLabel?.text = self.pickerView(pickerView, titleForRow: row, forComponent: component)
        }
        return pickLabel!
    }
    func show(){
        let keyWindow:UIWindow = UIApplication.sharedApplication().keyWindow!
        view = UIView(frame: keyWindow.bounds)
        view?.alpha = 0.3
        view?.backgroundColor = UIColor.blackColor()
        keyWindow.addSubview(view!)
        
        self.alpha = 1;
        keyWindow.addSubview(self)
        keyWindow.bringSubviewToFront(self)
        
        let bounceAnimation:CAKeyframeAnimation = CAKeyframeAnimation()
        bounceAnimation.duration = 0.3;
        bounceAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        bounceAnimation.values = [NSNumber(float: 0.01),NSNumber(float: 1.10),NSNumber(float: 0.90),NSNumber(float: 1.0)]
        self.layer.addAnimation(bounceAnimation, forKey: "transform.scale")
    }
    
    func hiddenSelf(){
        UIView.animateWithDuration(0.25, delay: 0.0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            self.transform = CGAffineTransformConcat(self.transform, CGAffineTransformMakeScale(0.01, 0.01))
            }) { (finished) -> Void in
                self.view?.removeFromSuperview()
                self.removeFromSuperview()
        }
    }
}