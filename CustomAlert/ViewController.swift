//
//  ViewController.swift
//  CustomAlert
//
//  Created by Ahmed Abd-elbaky on 19/05/16.
//  Copyright © 2016 HS. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var showAlertBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func showAlert(sender: AnyObject) {
        let alert:CustomAlertViewController = CustomAlertViewController()
        alert.displayMessage("Title", message: "Message is here", iconName: "hope-sun.net", buttonLabels: [], actions: [])
    }

}

