//
//  SideMenuView.swift
//  SideMenu
//
//  Created by prema janoti on 12/26/16.
//  Copyright © 2016 prema janoti. All rights reserved.
//

import UIKit

/** Enum representing different Side Panel direction*/
public enum Direction: Int {
    /** Enum representing Left direction.*/
    case left = 1
    /** Enum representing Right direction.*/
    case right = 2
}

class Item: NSObject {
    var title: String
    var iconName: String
    var isSelected: Bool
    
    init(title: String, iconName: String, isSelected: Bool) {
        self.title = title
        self.iconName = iconName
        self.isSelected = isSelected
    }
}

class SideMenuTVCell: UITableViewCell {
    
    @IBOutlet weak var iconIView: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    var item: Item?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        
        var imageName = self.item?.iconName
        if highlighted {
            self.lblTitle.textColor = UIColor.white
            if imageName != nil {
                imageName = imageName! + "_pressed.png"
            }
            self.backgroundColor = UIColor.lightGray
        } else {
            self.lblTitle.textColor = UIColor.black
            if imageName != nil {
                imageName = imageName! + "_normal.png"
            }
            self.backgroundColor = UIColor.white
        }
        if imageName != nil {
            self.iconIView.image = UIImage(named: imageName!)
        }
    }
    
    func updateUI(_ item: Item) {
        self.item = item
        self.lblTitle.text = item.title
    }
    
}

/** Protocol for side panel. */
protocol SideMenuViewDelegate {
    /** called on side Panel delegate whenever an item is selected from side Panel.
     
     @param selectedItem reference which is currently selected.
     */

    func didSelectItem(_ item: Item)
}

/**
  Custom Side Panel Menu.
 */

class SideMenuView: UIView {
    
    let kDefaultTransparentViewMargin = 75.0
    
    @IBOutlet weak var userIView: UIImageView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var menuTView: UITableView!
    @IBOutlet weak var userInfoView: UIView!
    
    /** Array containg Side Panel items. */
    var items: [Item]?
    
    var menuDirection: Direction?
    
    /** Delegate to recive events from side panel */
    var delegate: SideMenuViewDelegate?
    var userImageUrl: URL?
    var userName: String?
    var arrConstraints: [NSLayoutConstraint]?
    
    /** Float value containing transparent margin of container view. */
    var transparentViewMargin: Float?
    
    /** Background color for side panel. */
    var backGroundColor: UIColor?
    
    /** Seperator color of tableview in side panel. */
    var separatorColor: UIColor?
    
    /** Seperator type of tableview in side panel. */
    var separatorType: UITableViewCellSeparatorStyle?
    
    /** side panel backGround imageview.*/
    var backGroundImageView: UIImageView?
    
    var darkView: UIView?
    var mainView: UIView?
    var contView: UIView?
    var isSliderVisible: Bool?
    var leadingConst: NSLayoutConstraint?
    var trailingConst: NSLayoutConstraint?
    
  
    override func awakeFromNib() {
        super.awakeFromNib()
        self.containerView.backgroundColor = UIColor.clear
        self.menuTView.register(UINib.init(nibName: "SideMenuTVCell", bundle:nil ), forCellReuseIdentifier: "SideMenuTVCell")
        self.menuTView.separatorInset = .zero
        self.userIView.layoutIfNeeded()
        self.userIView.layer.borderWidth = 3.0
        self.userIView.layer.borderColor = UIColor.white.cgColor
        let radius = self.userIView.frame.size.width / 2
        self.userIView.layer.cornerRadius = radius
    }
    
    func setupViews() {
       
        if self.backGroundImageView == nil {
            self.backGroundImageView = UIImageView.init(frame: self.bounds)
            self.backGroundImageView?.backgroundColor = UIColor.clear
            self.backGroundImageView?.autoresizingMask = [.flexibleHeight, .flexibleWidth]
            self.addSubview(self.backGroundImageView!)
            self.sendSubview(toBack: self.backGroundImageView!)
        }
        self.menuTView.tableFooterView = UIView()
        self.menuTView.backgroundColor = UIColor.clear
  }
    
/** Initializes and returns a newly allocated side panel object with the specified delegate, and contents. Content is used as datasource for the side panel tableView
 - parameter contents : Array of contents for datasource.
 - parameter slideDirection : direction of side panel. (if No direction then, default direction will be Right).
 - parameter delegate : delegate for the side panel.
 
 */
    
  class func initMenuView(_ contents: [Item], slideDirection: Direction?, delegate: SideMenuViewDelegate ) -> SideMenuView{
       let sideView = Bundle.main.loadNibNamed("SideMenuView", owner: self, options: nil)?.last as? SideMenuView
        if sideView != nil {
            if slideDirection != nil {
               sideView?.menuDirection = slideDirection
            } else {
               sideView?.menuDirection = .right
            }
            sideView?.items = contents
            sideView?.delegate = delegate
            sideView?.setupViews()
        }
    return sideView!
    
    }

/** Use this method to Add initial sidepanel over a view.
  - parameter view : UIView over which side panel is required.
  - parameter containerView : optional UIView over which side panel is required.

 */

    func setupInitialConstraintWRTView(_ view: UIView, containerView: UIView?) {
        self.mainView = view;
        if containerView != nil {
            self.contView = containerView;
        } else {
           self.contView = view
        }
        self.translatesAutoresizingMaskIntoConstraints = false
        var topConst: NSLayoutConstraint?
        var bottomConst: NSLayoutConstraint?
        
        topConst = NSLayoutConstraint.init(item: self, attribute: .top, relatedBy: .equal, toItem: self.mainView, attribute: .top, multiplier: 1.0, constant: 64.0)
        bottomConst = NSLayoutConstraint.init(item: self, attribute: .bottom, relatedBy: .equal, toItem: self.mainView, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        
        if self.menuDirection == .right {
           leadingConst = NSLayoutConstraint.init(item: self, attribute: .leading, relatedBy: .equal, toItem: self.contView, attribute: .trailing, multiplier: 1.0, constant: 0.0)
            
           trailingConst = NSLayoutConstraint.init(item: self, attribute: .trailing, relatedBy: .equal, toItem: self.contView, attribute: .trailing, multiplier: 1.0, constant: self.calculateSliderWidth())
        } else {
            leadingConst = NSLayoutConstraint.init(item: self, attribute: .leading, relatedBy: .equal, toItem: self.contView, attribute: .leading, multiplier: 1.0, constant: -(self.calculateSliderWidth()))
            
            trailingConst = NSLayoutConstraint.init(item: self, attribute: .trailing, relatedBy: .equal, toItem: self.contView, attribute: .leading, multiplier: 1.0, constant: 0.0)
        }
        view.addConstraints([topConst!, bottomConst!, leadingConst!, trailingConst!])
    }
    
    
    /** Using this method to calculate Slider Width on the basis of given transparent View Margin .
     
     */
    
   private func calculateSliderWidth() -> CGFloat {
        let screenScale = UIScreen.main.scale
        var panelWidth = (UIScreen.main.currentMode?.size.width)! / screenScale
        if self.transparentViewMargin != nil {
            panelWidth = CGFloat(panelWidth) - CGFloat(self.transparentViewMargin!)
        } else {
            panelWidth = CGFloat(panelWidth) - CGFloat(kDefaultTransparentViewMargin)
        }
        return panelWidth
    }
    
    
    /** Using this method to Add Dark View over a sidepanel.
    */
    
   private func addDarkView() {
        if self.darkView == nil {
            let darkView = UIView()
            self.darkView = darkView
            darkView.translatesAutoresizingMaskIntoConstraints = false
            darkView.backgroundColor = UIColor.black
            darkView.alpha = 0.0
         
            UIView.animate(withDuration: 0.3, animations: {
                darkView.alpha = 0.5
            }, completion: nil)
            self.mainView?.addSubview(darkView)
            self.mainView?.insertSubview(self.darkView!, belowSubview: self)
            
           let bottomSpace = NSLayoutConstraint.init(item: darkView, attribute: .bottom, relatedBy: .equal, toItem: self.mainView, attribute: .bottom, multiplier: 1.0, constant: 0.0)
            let topSpace = NSLayoutConstraint.init(item: darkView, attribute: .top, relatedBy: .equal, toItem: self.mainView, attribute: .top, multiplier: 1.0, constant: 0.0)
            let leadingSpace = NSLayoutConstraint.init(item: darkView, attribute: .leading, relatedBy: .equal, toItem: self.mainView, attribute: .leading, multiplier: 1.0, constant: 0.0)
            let trailingSpace = NSLayoutConstraint.init(item: darkView, attribute: .trailing, relatedBy: .equal, toItem: self.mainView, attribute: .trailing, multiplier: 1.0, constant: 0.0)
            self.mainView?.addConstraints([topSpace, bottomSpace, leadingSpace, trailingSpace])
        }
    }
    
    
    /** Using this method to remove Dark View over a sidepanel.
     
     */
   private func removeDarkView() {
        UIView.animate(withDuration: 0.3, animations: {
            self.darkView!.alpha = 0.0
            self.darkView?.removeFromSuperview()
            self.darkView = nil
        }, completion: {(finished) -> Void in
            
        })
    }
    
    /** Use this method to Show side panel over a view without slide effect on supper view. */
 
    func showSidePanelWithoutSlideEffectOnSuperView() {
        if self.isSliderVisible == true {
            self.removeSidePanelWithoutSlideEffectOnSuperView()
            return
        }
        self.isHidden = false
        self.mainView?.endEditing(true)
        self.mainView?.layoutIfNeeded()
        self.mainView?.bringSubview(toFront: self)
        self.addDarkView()
        self.mainView?.layoutIfNeeded()
        let popupWidth = self.calculateSliderWidth()
        UIView.animate(withDuration: 0.3, animations: {
            if popupWidth > 0 {
                self.layoutIfNeeded()
                if self.menuDirection == .right {
                    self.leadingConst?.constant = -popupWidth
                    self.trailingConst?.constant = 0
                } else {
                    self.leadingConst?.constant = 0
                    self.trailingConst?.constant = popupWidth
                }
                self.mainView?.layoutIfNeeded()
            }
        }, completion: {(finished) -> Void in
            self.mainView?.endEditing(false)
            self.isSliderVisible = true
        })

    }
    
    /** Use this method to Remove side panel from a view without slide efect on supper view. */

    func removeSidePanelWithoutSlideEffectOnSuperView() {
        if self.isSliderVisible == false {
            return
        }
        let popupWidth = self.calculateSliderWidth()
        self.mainView?.endEditing(true)
        self.mainView?.layoutIfNeeded()
        UIView.animate(withDuration: 0.3, animations: {
            if popupWidth > 0 {
                if self.menuDirection == .left {
                    self.leadingConst?.constant = -popupWidth
                    self.trailingConst?.constant = 0
                } else {
                    self.leadingConst?.constant = 0
                    self.trailingConst?.constant = popupWidth
                }
                self.mainView?.layoutIfNeeded()
            }
        }, completion: {(finished) -> Void in
            self.isHidden = false
            self.mainView?.endEditing(false)
            self.isSliderVisible = false
            self.mainView?.sendSubview(toBack: self)
            if self.darkView != nil {
            self.removeDarkView()
            }
        })

    }
}

extension SideMenuView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count = 0
        if (self.items?.count)! > 0 {
           count = (self.items?.count)!
        }
         return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SideMenuTVCell", for: indexPath) as? SideMenuTVCell
        cell?.selectionStyle = .none
        if (self.items?.count)! > 0 {
           let item = self.items?[indexPath.row]
           cell?.updateUI(item!)
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.resetAllSliderItemsSelectedState()
        tableView.deselectRow(at: indexPath, animated: true)
        let currentSelectedItem = self.items?[indexPath.row]
         currentSelectedItem?.isSelected = true
        if self.delegate != nil {
            self.delegate?.didSelectItem(currentSelectedItem!)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
    
    func resetAllSliderItemsSelectedState() {
        for item in self.items! {
            item.isSelected = false
        }
    }
}
