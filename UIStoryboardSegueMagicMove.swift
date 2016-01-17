//
//  UIStoryboardSegueMagicMove.swift
//  MuLan
//
//  Created by Tomasen on 1/10/16.
//  Copyright © 2016 PINIDEA LLC. All rights reserved.
//

import UIKit

class UIStoryboardSegueMagicMove: UIStoryboardSegue {
    override func perform() {
        let srcView = self.sourceViewController.view
        let dstView = self.destinationViewController.view
        
        UIApplication.sharedApplication().keyWindow?.insertSubview(dstView, atIndex: 0)
        dstView.setNeedsLayout()
        dstView.layoutIfNeeded()
        dstView.removeFromSuperview()
        
        UIView.animateWithDuration(0.5,
            delay: 0,
            options:UIViewAnimationOptions.CurveEaseInOut,
            animations: {
                self.magicmoveSubviewsOfView(srcView, dstView: dstView)
            }, completion: {
                (value: Bool) in
                
                self.sourceViewController
                    .presentViewController(
                        self.destinationViewController,
                        animated:false,
                        completion:nil)
        })
    }
    
    func magicmoveSubviewsOfView(view: UIView, dstView: UIView){
        if view.hidden {
            return
        }
        if view.tag != 0 {
            if let target = findSubviewInViewByTag(dstView, tag: view.tag) {
                // begin move animation
                view.frame = target.frame
                
            }
        }
        if view.subviews.count > 0{
            for subview in view.subviews {
                magicmoveSubviewsOfView(subview, dstView: dstView)
            }
        }
    }
    
    func findSubviewInViewByTag(view: UIView, tag: Int) -> UIView? {
        assert(tag != 0)
        if view.hidden {
            return nil
        }
        if view.tag == tag {
            return view
        }
        if view.subviews.count > 0{
            for subview in view.subviews {
                return findSubviewInViewByTag(subview, tag: tag)
            }
        }
        return nil
    }
}
