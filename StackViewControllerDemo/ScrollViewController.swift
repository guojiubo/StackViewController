//
//  ScrollViewController.swift
//  StackViewControllerDemo
//
//  Created by guojiubo on 9/23/15.
//  Copyright © 2015 CocoaWind. All rights reserved.
//

import UIKit

class ScrollViewController: UIViewController {
    @IBOutlet var scrollView: UIScrollView!
}

extension ScrollViewController: StackViewControllerProtocol {
    func nextViewControllerOnStackViewController(stackViewController: StackViewController) -> UIViewController? {
        return TableViewController(style: .Grouped)
    }
    
    func scrollViewOnStackViewController(stackViewController: StackViewController) -> UIScrollView? {
        return self.scrollView
    }
}
