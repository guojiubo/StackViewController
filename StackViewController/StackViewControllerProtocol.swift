//
//  StackViewControllerProtocol.swift
//  StackViewControllerDemo
//
//  Created by guojiubo on 9/22/15.
//  Copyright (c) 2015 CocoaWind. All rights reserved.
//

import UIKit

@objc
protocol StackViewControllerProtocol {
    
    optional func nextViewControllerOnStackViewController(stackViewController: StackViewController) -> UIViewController?
    
    optional func scrollViewOnStackViewController(stackViewController: StackViewController) -> UIScrollView?
    
}
