//
//  ViewController.swift
//  chinaSchoolPickupViewDemo
//
//  Created by 梓简王 on 2017/8/10.
//  Copyright © 2017年 梓简王. All rights reserved.
//

import UIKit

class ViewController: UIViewController,schoolPickupViewDelegete {
    
    var schoolText = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 30))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let btn = UIButton(type: UIButtonType.System)
        btn.setTitle("弹 出", forState: UIControlState.Normal)
        btn.titleLabel?.font = UIFont(name: "Georgia", size: 14)
        btn.frame = CGRectMake(10, 5, 40, 35)
        btn.center = self.view.center
        btn.addTarget(self, action: "popUp", forControlEvents: UIControlEvents.TouchUpInside)
        self.schoolText.backgroundColor = UIColor.whiteColor()
        self.schoolText.center = CGPoint(x: self.view.center.x, y: self.view.center.y - 50)
        self.schoolText.textAlignment = .Center
        self.view.addSubview(schoolText)
        self.view.addSubview(btn)
        // Do any additional setup after loading the view, typically from a nib.
    }
    func popUp(){
        let tempData = UIScreen.mainScreen().bounds.size
        var pickView = schoolPickupView.init(frame: CGRectMake(20, tempData.height/2-110, tempData.width - 40, 220))
        pickView.delegate = self
        pickView.show()
    }
    func pickerDidSelectName(name: String!) {
        self.schoolText.text = name
    }
    func cancelBtn() {
        self.schoolText.text = ""
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

