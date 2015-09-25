//
//  StackViewControllerDemoTests.swift
//  StackViewControllerDemoTests
//
//  Created by guojiubo on 8/26/15.
//  Copyright (c) 2015 CocoaWind. All rights reserved.
//

import UIKit
import XCTest

//@testable
import StackViewControllerDemo

class StackViewControllerDemoTests: XCTestCase {
    
    let a = UIViewController()
    let b = UIViewController()
    let c = UIViewController()
    let d = UIViewController()
    let e = UIViewController()
    let f = UIViewController()
    
    func testInitializations() {
        let stack1 = StackViewController()
        XCTAssertNotNil(stack1)
        XCTAssert(stack1.viewControllers.isEmpty)
        
        let root = UIViewController()
        let stack2 = StackViewController(rootViewController: root)
        XCTAssertNotNil(stack2)
        XCTAssert(stack2.viewControllers.count == 1)
        XCTAssert(stack2.viewControllers == [root])
        XCTAssert(stack2.rootViewController == root)
        
        XCTAssert(root.stackViewController == stack2)
    }
    
    func testPushViewController() {
        let stack = StackViewController()
        
        stack.pushViewController(a, animated: false)
        XCTAssert(stack.topViewController! == a)
        
        stack.pushViewController(b, animated: false)
        XCTAssert(stack.topViewController! == b)
        
        stack.pushViewController(b, animated: false)
        XCTAssert(stack.topViewController! == b)
    }
    
    func testPopViewController() {
        let stack = StackViewController()
        stack.viewControllers = [a, b, c, d, e, f]
        
        var poppedViewController = stack.popViewControllerAnimated(false)
        XCTAssert(stack.viewControllers == [a, b, c, d, e])
        XCTAssert(poppedViewController == f)
        
        var poppedViewControllers = stack.popToViewController(c, animated: false)
        XCTAssert(stack.viewControllers == [a, b, c])
        XCTAssert(poppedViewControllers == [d, e])
        
        poppedViewControllers = stack.popToRootViewControllerAnimated(false)
        XCTAssert(stack.viewControllers == [a])
        XCTAssert(poppedViewControllers == [b, c])
        
        poppedViewController = stack.popViewControllerAnimated(false)
        XCTAssert(stack.viewControllers == [a])
        XCTAssertNil(poppedViewController)
    }
    
    func testSetViewControllers() {
        
        let stack = StackViewController()
        stack.viewControllers = [a, b, c]
        stack.viewControllers = [b, e]
        XCTAssert(stack.viewControllers.count == 2)
        XCTAssert(stack.viewControllers == [b, e])
        
        stack.pushViewController(c, animated: false)
        XCTAssert(stack.viewControllers == [b, e, c])
        
        stack.setViewControllers([f, e, c], animated: false)
        XCTAssert(stack.viewControllers == [f, e, c])
    }
    
    func testChildViewControllers() {
        let stack = StackViewController()
        stack.viewControllers = [a, b, c]
        XCTAssert(stack.childViewControllers.count == 3)
        XCTAssert(stack.childViewControllers.last == c)
        
        stack.setViewControllers([d, e], animated: false)
        XCTAssert(stack.childViewControllers.count == 2)
        XCTAssert(stack.childViewControllers.last == e)
        
        stack.pushViewController(f, animated: false)
        XCTAssert(stack.childViewControllers.count == 3)
        XCTAssert(stack.childViewControllers.last == f)
        
        stack.popViewControllerAnimated(false)
        XCTAssert(stack.childViewControllers.count == 2)
        XCTAssert(stack.childViewControllers.last == e)
        
        stack.popToRootViewControllerAnimated(false)
        XCTAssert(stack.childViewControllers.count == 1)
        XCTAssert(stack.childViewControllers.last == d)
                
        stack.viewControllers = [a, b, c, d]
        stack.viewControllers = [e, f, a]
        XCTAssert(stack.childViewControllers.count == 3)
        
        // those are expected since we cannot reorder childViewControllers
        
        XCTAssert(stack.childViewControllers == [a, e, f])
        
        stack.viewControllers = [a, b, c, d]
        stack.setViewControllers([d, a, c], animated: false)
        
        XCTAssert(stack.childViewControllers == [a, c, d])
        
        stack.viewControllers = []
        XCTAssert(stack.childViewControllers.isEmpty)
    }
    
    func testUIViewControllerExtension() {
        var viewControllers = [UIViewController]()
        for _ in 0..<10 {
            let viewController = UIViewController()
            viewControllers.append(viewController)
            XCTAssert(viewController.stackViewController == nil)
        }
        
        let stack = StackViewController()
        
        stack.viewControllers = viewControllers
        for viewController in viewControllers {
            XCTAssertNotNil(viewController.stackViewController)
            XCTAssert(viewController.stackViewController! == stack)
        }
        
        stack.popViewControllerAnimated(false)
        XCTAssertNil(viewControllers.last!.stackViewController)
        
        stack.viewControllers = []
        for viewController in viewControllers {
            XCTAssertNil(viewController.stackViewController)
        }
    }
    
}
