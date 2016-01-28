//
//  ViewController2.swift
//  demo
//
//  Created by Tomasen on 1/28/16.
//  Copyright © 2016 PINIDEA LLC. All rights reserved.
//

import UIKit

class ViewController2: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        for subview in view.subviews {
            print(subview.tag, subview.frame, subview.bounds)
        }
    }
    
    @IBAction func pushButton(sender: AnyObject) {
        self.performSegueWithIdentifier("MagicMove", sender: self)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
