//
//  TableViewController.swift
//  StackViewControllerDemo
//
//  Created by guojiubo on 9/23/15.
//  Copyright © 2015 CocoaWind. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    let menus = ["Push", "Pop", "Push scroll view"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "MenuCell")
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.menus.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MenuCell", forIndexPath: indexPath)
        cell.accessoryType = .DisclosureIndicator
        cell.textLabel?.text = self.menus[indexPath.section]

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch indexPath.section {
        case 0:
            self.stackViewController?.pushViewController(TableViewController(style: .Grouped), animated: true)
        case 1:
            self.stackViewController?.popViewControllerAnimated(true)
        case 2:
            self.stackViewController?.pushViewController(ScrollViewController(nibName: "ScrollViewController", bundle: nil), animated: true)
        default:
            break
        }
    }
}

extension TableViewController: StackViewControllerProtocol {
    func nextViewControllerOnStackViewController(stackViewController: StackViewController) -> UIViewController? {
        return TableViewController(style: .Grouped)
    }
}

