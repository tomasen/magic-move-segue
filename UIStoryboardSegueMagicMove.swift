//
//  UIStoryboardSegueMagicMove.swift
//
//  Created by Tomasen on 1/10/16.
//  Copyright © 2016 PINIDEA LLC. All rights reserved.
//

import UIKit

class UIStoryboardSegueMagicMove: UIStoryboardSegue, UIViewControllerTransitioningDelegate {
    override func perform() {

        // TODO: 
        // implement UIViewControllerTransitioningDelegate
        // self.sourceViewController.transitioningDelegate = self

        let srcView = self.sourceViewController.view
        let dstView = self.destinationViewController.view
        
        // UIApplication.sharedApplication().keyWindow?.insertSubview(dstView, atIndex: 0)
        srcView.superview?.addSubview(dstView)
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
                
                if let nav = self.sourceViewController.navigationController {
                    nav.pushViewController(self.destinationViewController, animated: false)
                } else {
                    self.sourceViewController
                        .presentViewController(
                            self.destinationViewController,
                            animated:false,
                            completion:nil)
                }
        })
    }
    
    func magicmoveSubviewsOfView(view: UIView, dstView: UIView){
        if view.hidden {
            return
        }
        if view.tag != 0 {
            if let target = findSubviewInViewByTag(dstView, tag: view.tag) {
                // magic move animation
                
                let xScale = target.intrinsicContentSize().width / view.intrinsicContentSize().width
                let yScale = target.intrinsicContentSize().height / view.intrinsicContentSize().height
                
                view.transform = CGAffineTransformScale(view.transform, xScale, yScale)

                view.frame = target.frame
            } else {
                view.alpha = 0.0
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
                if let target = findSubviewInViewByTag(subview, tag: tag) {
                    return target
                }
            }
        }
        return nil
    }
}
