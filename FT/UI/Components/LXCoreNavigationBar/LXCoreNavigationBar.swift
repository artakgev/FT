//
//  LXCoreNavigationBar.swift
//  FT
//
//  Created by Artak Gevorgyan on 17 Oct, 2023
//  Copyright © 2023 Artak Gevorgyan. All rights reserved.
//

import UIKit

enum LXCoreNavigationBarMode: String {
    case back
    case no
    case filter
    case leaveGroup
//    case close
}


/// Notifies about LXCoreNavigationBar event
protocol LXCoreNavigationBarDelegate: AnyObject {

    /// Left button pressed event
    func leftButtonPressed()
    
    /// Right button pressed event
    func rightButtonPressed(mode: LXCoreNavigationBarMode)
    
}

class LXCoreNavigationBar: UIView {

    // MARK: - Public properties
    
    weak var delegate: LXCoreNavigationBarDelegate?

    // MARK: - IBOutlets
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var leftButton: UIButton!
    @IBOutlet private weak var rightButton: UIButton!
        
    // MARK: - Private properties
    
    private let nibName = "LXCoreNavigationBar"
    private var contentView: UIView?
    private var leftButtonBarMode: LXCoreNavigationBarMode = .back
    private var rightButtonBarMode: LXCoreNavigationBarMode = .no

    private var leftButtonAction: (() -> Void)?
    private var rightButtonAction: (() -> Void)?

    // MARK: - Initialization
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        guard let view = loadViewFromNib() else { return }
        view.frame = self.bounds
        self.addSubview(view)
        contentView = view
        self.initUIElements()
    }
    
    // MARK: - Public
    
    /// Initialization
    /// - Parameters:
    ///   - title: title
    ///   - leftViewMode: mode of left view @LXCoreNavigationBarMode
    ///   - rightViewMode: mode of right view @LXCoreNavigationBarMode
    func initWith(title: String,
                  leftViewMode: LXCoreNavigationBarMode = .back,
                  rightViewMode: LXCoreNavigationBarMode = .no) {
        self.titleLabel.text = title
        self.leftButtonBarMode = leftViewMode
        self.rightButtonBarMode = rightViewMode
        self.updateLeftAndRightViewsRegardingMode()
    }
    
    func getLeftButtonMode() -> LXCoreNavigationBarMode {
        return self.leftButtonBarMode
    }

    func getRightButtonMode() -> LXCoreNavigationBarMode {
        return rightButtonBarMode
    }
    
    /// Add custom action to handle left button click
    /// - In case of not providing custom action, left button click will be handled in BaseVC
    ///  via LXCoreNavigationBarDelegate event
    /// - Parameter action: action to handel left button click
    func addLeftButtonAction(action: @escaping () -> Void) {
        self.leftButtonAction = action
    }

    /// Add custom action to handle right button click
    /// - In case of not providing custom action, right button click will be handled in BaseVC
    ///  via YTPaymentsNavigationBarDelegate event
    /// - Parameter action: action to handel right button click
    func addRightButtonAction(action: @escaping () -> Void) {
        self.rightButtonAction = action
    }

    // MARK: - Private
    
    // TODO: Move this to UIView+Extension
    private func loadViewFromNib() -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
    
    private func initUIElements() {
//        self.contentView?.backgroundColor = Styling.NavigationBar.bgColor
//        self.titleLabel.setStyle(typography: Styling.NavigationBar.titleFont,
//                                 color: UIColor.primaryText)
    }
    
    private func updateLeftAndRightViewsRegardingMode() {
        self.updateLeftView()
//        self.updateRightView()
    }
    
    private func updateLeftView() {
        self.leftButton.addTarget(self, action: #selector(leftButtonPressed), for: UIControl.Event.touchUpInside)
        self.leftButton.isHidden = self.leftButtonBarMode == .no
        if self.leftButtonBarMode == .back {
//            self.leftButton.setImage(UIImage.backArrow, for: .normal)
        } else if self.leftButtonBarMode == .no {
            self.leftButton.setImage(nil, for: .normal)
        }
    }
    
//    private func updateRightView() {
//        self.rightButton.addTarget(self,
//                                   action: #selector(rightButtonPressed),
//                                   for: UIControl.Event.touchUpInside)
//        self.rightButton.isHidden = self.rightButtonBarMode == .no
//        if self.rightButtonBarMode == .back {
//            self.rightButton.setImage(UIImage.backArrow, for: .normal)
//        } else if self.rightButtonBarMode == .no {
//            self.rightButton.setImage(nil, for: .normal)
//        } else if self.rightButtonBarMode == .filter {
//            self.rightButton.setImage(UIImage.filterIcon, for: .normal)
//        } else if self.rightButtonBarMode == .leaveGroup {
//            self.rightButton.setImage(UIImage.leaveGroup, for: .normal)
//        }
////        else if self.rightButtonBarMode == .close {
////            self.rightButton.setImage(Asset.Icons.closeImage.image, for: .normal)
////        }
//    }


    // MARK: - IBActions
    
    @objc private func leftButtonPressed() {
        if let action = leftButtonAction {
            action()
        } else {
            self.delegate?.leftButtonPressed()
        }
    }
    
    @objc private func rightButtonPressed() {
        if let action = rightButtonAction {
            action()
        } else {
            self.delegate?.rightButtonPressed(mode: self.rightButtonBarMode)
        }
    }
    
}
