//
//  BaseViewController.swift
//  SideMenu
//
//  Created by prema janoti on 1/19/17.
//  Copyright © 2017 prema janoti. All rights reserved.
//

import UIKit
import SidePanelMenu

class BaseViewController: UIViewController, SideMenuViewDelegate {
    
 var slideView: SideMenuView?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addSidePanel()
        self.leftBarButton()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func leftBarButton() {
        var leftBarButtons = [UIBarButtonItem]()
            let barButtonItem = UIBarButtonItem.init(image: UIImage(named: "menu_normal"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.menuButtonTapped))
            leftBarButtons.append(barButtonItem)
        if leftBarButtons.count > 0 {
            self.navigationItem.leftBarButtonItems = leftBarButtons
        }
        let backButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: nil)
        self.navigationItem.backBarButtonItem = backButton
    }
    
    func menuButtonTapped() {
        self.showSidePanel()
    }
    
    func addSidePanel() {
        if self.slideView != nil {
            self.slideView?.removeFromSuperview()
            self.slideView = nil
        }
        
        let contents = self.sidePanelContents()
        self.slideView = SideMenuView.initMenuView(contents, slideDirection: .left, delegate: self)
        self.slideView?.isHidden = true
        self.slideView?.backGroundColor = UIColor.white
        self.slideView?.separatorColor = UIColor.init(colorLiteralRed: 86.0/255.0, green: 119.0/255.0, blue: 133.0/255.0, alpha: 1.0)
        self.slideView?.separatorType = UITableViewCellSeparatorStyle.singleLine
        self.slideView?.transparentViewMargin = 120
        self.view.addSubview(self.slideView!)
        self.slideView?.setupInitialConstraintWRTView(self.view, containerView: nil)
    }
    
    func sidePanelContents() -> [Item] {
        var sideContents = [Item]()
        let item1 = Item.init(title: "Feedback", iconName: "feedback", isSelected: false)
        sideContents.append(item1)
        let item2 = Item.init(title: "My Job", iconName: "myjobs", isSelected: false)
        sideContents.append(item2)
        
        return sideContents
    }
    
    
    func showSidePanel() {
        self.slideView?.lblUserName.text = "Guest User"
        self.slideView?.userIView.image = UIImage(named: "placeholder")
        self.slideView?.menuTView.reloadData()
        self.slideView?.showSidePanelWithoutSlideEffectOnSuperView()
    }
    
    func removeSidePanel() {
        self.slideView?.removeSidePanelWithoutSlideEffectOnSuperView()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.removeSidePanel()
    }
    
    func didSelectItem(_ item: Item) {
       
        if item.title.caseInsensitiveCompare("Feedback") == ComparisonResult.orderedSame {
            
        } else if item.title.caseInsensitiveCompare("My Jobs") == ComparisonResult.orderedSame {
//            self.showMyJobs()
        }
        
        self.removeSidePanel()
    }

}
