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
    
    let obviously = "test case very simple, no need to provide extra info"
    
    let a = UIViewController()
    let b = UIViewController()
    let c = UIViewController()
    let d = UIViewController()
    let e = UIViewController()
    let f = UIViewController()
    
    func testInitializations() {
        let stack1 = StackViewController()
        XCTAssertNotNil(stack1, obviously)
        XCTAssert(stack1.viewControllers.isEmpty, obviously)
        
        let root = UIViewController()
        let stack2 = StackViewController(rootViewController: root)
        XCTAssertNotNil(stack2, obviously)
        XCTAssert(stack2.viewControllers.count == 1, obviously)
        XCTAssert(stack2.viewControllers == [root], obviously)
        XCTAssert(stack2.rootViewController == root, obviously)
        
        XCTAssert(root.stackViewController == stack2, obviously)
    }
    
    func testPushViewController() {
        let stack = StackViewController()
        
        stack.pushViewController(a, animated: false)
        XCTAssert(stack.topViewController! == a, obviously)
        
        stack.pushViewController(b, animated: false)
        XCTAssert(stack.topViewController! == b, obviously)
        
        stack.pushViewController(b, animated: false)
        XCTAssert(stack.topViewController! == b, obviously)
    }
    
    func testPopViewController() {
        let stack = StackViewController()
        stack.viewControllers = [a, b, c, d, e, f]
        
        var poppedViewController = stack.popViewControllerAnimated(false)
        XCTAssert(stack.viewControllers == [a, b, c, d, e], obviously)
        XCTAssert(poppedViewController == f, obviously)
        
        var poppedViewControllers = stack.popToViewController(c, animated: false)
        XCTAssert(stack.viewControllers == [a, b, c], obviously)
        XCTAssert(poppedViewControllers == [d, e], obviously)
        
        poppedViewControllers = stack.popToRootViewControllerAnimated(false)
        XCTAssert(stack.viewControllers == [a], obviously)
        XCTAssert(poppedViewControllers == [b, c], obviously)
        
        poppedViewController = stack.popViewControllerAnimated(false)
        XCTAssert(stack.viewControllers == [a], obviously)
        XCTAssertNil(poppedViewController, obviously)
    }
    
    func testSetViewControllers() {
        
        let stack = StackViewController()
        stack.viewControllers = [a, b, c]
        stack.viewControllers = [b, e]
        XCTAssert(stack.viewControllers.count == 2, obviously)
        XCTAssert(stack.viewControllers == [b, e], obviously)
        
        stack.pushViewController(c, animated: false)
        XCTAssert(stack.viewControllers == [b, e, c], obviously)
        
        stack.setViewControllers([f, e, c], animated: false)
        XCTAssert(stack.viewControllers == [f, e, c], obviously)
    }
    
    func testChildViewControllers() {
        let stack = StackViewController()
        stack.viewControllers = [a, b, c]
        XCTAssert(stack.childViewControllers.count == 3, obviously)
        XCTAssert(stack.childViewControllers.last == c, obviously)
        
        stack.setViewControllers([d, e], animated: false)
        XCTAssert(stack.childViewControllers.count == 2, obviously)
        XCTAssert(stack.childViewControllers.last == e, obviously)
        
        stack.pushViewController(f, animated: false)
        XCTAssert(stack.childViewControllers.count == 3, obviously)
        XCTAssert(stack.childViewControllers.last == f, obviously)
        
        stack.popViewControllerAnimated(false)
        XCTAssert(stack.childViewControllers.count == 2, obviously)
        XCTAssert(stack.childViewControllers.last == e, obviously)
        
        stack.popToRootViewControllerAnimated(false)
        XCTAssert(stack.childViewControllers.count == 1, obviously)
        XCTAssert(stack.childViewControllers.last == d, obviously)
                
        stack.viewControllers = [a, b, c, d]
        stack.viewControllers = [e, f, a]
        XCTAssert(stack.childViewControllers.count == 3, obviously)
        
        // those are expected since we cannot reorder childViewControllers
        
        XCTAssert(stack.childViewControllers == [a, e, f], obviously)
        
        stack.viewControllers = [a, b, c, d]
        stack.setViewControllers([d, a, c], animated: false)
        
        XCTAssert(stack.childViewControllers == [a, c, d], obviously)
        
        stack.viewControllers = []
        XCTAssert(stack.childViewControllers.isEmpty, obviously)
    }
    
    func testUIViewControllerExtension() {
        var viewControllers = [UIViewController]()
        for _ in 0..<10 {
            let viewController = UIViewController()
            viewControllers.append(viewController)
            XCTAssert(viewController.stackViewController == nil, obviously)
        }
        
        let stack = StackViewController()
        
        stack.viewControllers = viewControllers
        for viewController in viewControllers {
            XCTAssertNotNil(viewController.stackViewController, obviously)
            XCTAssert(viewController.stackViewController! == stack, obviously)
        }
        
        stack.popViewControllerAnimated(false)
        XCTAssertNil(viewControllers.last!.stackViewController, obviously)
        
        stack.viewControllers = []
        for viewController in viewControllers {
            XCTAssertNil(viewController.stackViewController, obviously)
        }
    }
    
}
