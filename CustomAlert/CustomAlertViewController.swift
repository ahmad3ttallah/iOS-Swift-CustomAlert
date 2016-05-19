//
//  CustomAlertViewController.swift
//  CustomAlert
//
//  Created by Ahmed Abd-elbaky on 19/05/16.
//  Copyright © 2016 HS. All rights reserved.
//

import Foundation
import UIKit

typealias CustomAlertAction = () -> Void

class CustomAlertViewController: UIViewController {
    
    var container:UIView!
    var titleTxt:UILabel!
    var messageTxt:UILabel!
    var imageView:UIImageView!
    var buttons:[UIButton]!
    var actions:[CustomAlertAction]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let backgroundImage = UIImageView(frame: UIScreen.mainScreen().bounds)
//        backgroundImage.image = UIImage(named: "behind_alert_view")
//        self.view.insertSubview(backgroundImage, atIndex: 0)
        self.modalPresentationStyle = UIModalPresentationStyle.OverFullScreen
    }
    
    // MARK:- Methods
    func displayMessage(title:String, message:String, iconName: String, buttonLabels:[String], actions:[CustomAlertAction]){
        if self.container == nil{
            self.container = UIView(frame: CGRectMake(0, 0, 300, 500))
            self.container.backgroundColor = UIColor.grayColor()
            self.view.addSubview(self.container)
        }
        let iconImage = UIImage(named: iconName)
        if self.imageView == nil && iconImage != nil {
            self.imageView = UIImageView(frame: CGRectMake(20, 0, self.container.frame.size.width - 20, 0))
            self.imageView.image = iconImage
            self.container.addSubview(self.imageView)
        }
        
        if self.titleTxt == nil{
            self.titleTxt = UILabel(frame: CGRectMake(20, 0, self.container.frame.size.width - 20, 10))
            self.titleTxt.numberOfLines = 0
            self.container.addSubview(self.titleTxt)
        }
        
        if self.messageTxt == nil{
            self.messageTxt = UILabel(frame: CGRectMake(20, 0, self.container.frame.size.width - 20, 10))
            self.messageTxt.numberOfLines = 0
            self.container.addSubview(self.messageTxt)
        }
        
        var yPosition:CGFloat = 25.0
        
        self.imageView.sizeToFit()
        
        self.titleTxt.text = title.uppercaseString
        self.titleTxt.sizeToFit()
        
        self.messageTxt.text = message.uppercaseString
        self.messageTxt.sizeToFit()
        
        var frame = self.imageView.frame
        frame.origin.y = yPosition
        frame.origin.x = (self.container.frame.size.width - self.imageView.frame.size.width) / 2
        self.imageView.frame = frame
        
        yPosition = self.imageView.frame.origin.y + self.imageView.image!.size.height + 10
        
        frame = self.titleTxt.frame
        frame.origin.y = yPosition
        frame.origin.x = (self.container.frame.size.width - self.titleTxt.frame.size.width) / 2
        self.titleTxt.frame = frame
        
        yPosition = self.titleTxt.frame.origin.y + self.titleTxt.frame.size.height + 10
        
        frame = self.messageTxt.frame
        frame.origin.y = yPosition
        frame.origin.x = (self.container.frame.size.width - self.messageTxt.frame.size.width) / 2
        self.messageTxt.frame = frame
        
        yPosition = self.messageTxt.frame.origin.y + self.messageTxt.frame.size.height + 5
        
        if self.buttons != nil{
            for button in self.buttons{
                button.removeFromSuperview()
            }
        }
        
        self.buttons = []
        self.actions = actions
        
        for (var i = 0; i < buttonLabels.count; i++){
            let button:UIButton = UIButton(frame:CGRectMake(0, yPosition, self.container.frame.size.width, 55))
            self.container.addSubview(button)
            button.setTitle(buttonLabels[i].uppercaseString, forState: UIControlState.Normal)
            self.buttons.append(button)
            button.addTarget(self, action: "button_press_handler:", forControlEvents: UIControlEvents.TouchUpInside)
            yPosition += 55
        }
        
        frame = self.container.frame
        frame.size.height = yPosition
        self.container.frame = frame
        self.container.center = self.view.center
        self.container.layer.cornerRadius = 5
//        self.container.layer.borderWidth = 1
//        self.container.layer.borderColor = UIColor.whiteColor().CGColor
        
        self.view.alpha = 0
        
        let delegate:UIApplicationDelegate = UIApplication.sharedApplication().delegate!
        let window:UIWindow! = delegate.window!
        window.rootViewController?.dismissViewControllerAnimated(false, completion: nil)
        window.rootViewController!.presentViewController(self, animated: true, completion: nil)
        
        UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
            self.view.alpha = 1
            }) { (Bool) -> Void in
                
            }
    }
    
    // MARK:- Handlers
    func button_press_handler(target: UIButton) {
        UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
            self.container.center = CGPointMake(self.view.center.x, self.view.center.y + 50)
            self.view.alpha = 0
            }) { (Bool) -> Void in
                self.dismissViewControllerAnimated(false, completion: nil)
            }
        
        if self.actions.count == 0{
            return
        }
        
        if let idx = self.buttons.indexOf(target){
            let action = self.actions[idx]
            action()
        }
    }
}