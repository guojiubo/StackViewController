//
//  StackPanGestureRecognizer.swift
//  StackViewControllerDemo
//
//  Created by guojiubo on 8/28/15.
//  Copyright (c) 2015 CocoaWind. All rights reserved.
//

import UIKit
import UIKit.UIGestureRecognizerSubclass

class StackPanGestureRecognizer: UIPanGestureRecognizer {
    
    enum StackPanGestureDirection {
        case Push, Pop
    }
    
    weak var scrollView: UIScrollView?
    
    private(set) var direction: StackPanGestureDirection?
    
    private var failed: Bool?
    
    override func reset() {
        super.reset()
        self.direction = nil
        self.failed = nil
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent) {
        super.touchesMoved(touches, withEvent: event)
        
        guard self.state != .Failed else {
            return
        }
        
        if let failed = self.failed {
            if failed {
                self.state = .Failed
            }
            return
        }
        
        guard let touch = touches.first else {
            return
        }
        
        let currentLocation = touch.locationInView(self.view)
        let previousLocation = touch.previousLocationInView(self.view)
        
        let translation = CGPoint(x: currentLocation.x - previousLocation.x, y: currentLocation.y - previousLocation.y)
        
        if fabs(translation.y) > fabs(translation.x) {
            self.state = .Failed
            self.failed = true
            return
        } else {
            self.failed = false
        }
        
        if (currentLocation.x > previousLocation.x) {
            self.direction = .Pop
        }
        else if (currentLocation.x < previousLocation.x) {
            self.direction = .Push
        }
        else {
            self.direction = nil
        }
        
        
        // deal with scroll view
        
        guard let scrollView = self.scrollView else {
            return
        }
        
        if self.direction == .Pop {
            let fixedOffsetX = scrollView.contentOffset.x + scrollView.contentInset.left
            if fixedOffsetX <= 0 {
                self.failed = false
            } else {
                self.state = .Failed
                self.failed = true
            }
            return
        }
        
        if self.direction == .Push {
            let fixedOffsetX = scrollView.contentOffset.x - scrollView.contentInset.right
            if fixedOffsetX + scrollView.bounds.size.width >= scrollView.contentSize.width {
                self.failed = false
            } else {
                self.state = .Failed
                self.failed = true
            }
        }
    }
   
}
