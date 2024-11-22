//
//  BaseVC.swift
//  FT
//
//  Created by Artak Gevorgyan on 07 Oct, 2023
//  Copyright © 2023 Artak Gevorgyan. All rights reserved.
//

import UIKit

/// Protocol to notify about BaseVC main events
@objc protocol BaseVCProtocol: AnyObject {
    func initUIElements()
}

@objc protocol LanguageChangeProtocol: AnyObject {
    func onLanguageChange()
}

enum ReloadState {
    case none
    case needsReload
}

class BaseTableViewCell: UITableViewCell {

    public override func awakeFromNib() {
        super.awakeFromNib()
        self.addLanguageChangeObserver()
    }

    private func addLanguageChangeObserver() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(changeLanguage),
                                               name: Notification.Name(rawValue: "changeLanguage"),
                                               object: nil)
    }
    @objc internal func changeLanguage() {
        if self.conforms(to: LanguageChangeProtocol.self) {
            if let strongSelf = self as? LanguageChangeProtocol {
                strongSelf.onLanguageChange()
            }
        }

    }

}

class BaseVC: UIViewController, VMToVCExchange, LXCoreNavigationBarDelegate, UIGestureRecognizerDelegate {

    // MARK: - IBOutlets

    @IBOutlet private weak var bottomViewBottomConstraint: NSLayoutConstraint?
    @IBOutlet private(set) weak var lxCoreNavigationBarView: LXCoreNavigationBar!


    // MARK: - Public properties
    
    var didBindViews = false
    var reloadState: ReloadState = .none

    // MARK: - Private properties
    
    private var keyboardIsOpen = false
    private var didAddObservers = false
    
    // MARK: - Lifecycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        let vm = self.getVM()
        vm?.baseDelegate = self
        self.addLanguageChangeObserver()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        navigationController?.interactivePopGestureRecognizer?.delegate = self
    }

    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if self.conforms(to: BaseVCProtocol.self) {
            if let selfAsBaseVCProtocol = self as? BaseVCProtocol {
                selfAsBaseVCProtocol.initUIElements()
            }
            self.commonInitUIElements()
        }
        addObservers()
        initStatusBar()
        if reloadState == .needsReload {
            if self.conforms(to: BaseVCProtocol.self) {
                if let strongSelf = self as? BaseVCProtocol {
                    strongSelf.initUIElements()
                }
            }
            performLanguageSensitiveRequests()
            reloadState = .none
        }

    }

    public override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        removeObservers()
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func initStatusBar() {
//        let isViewsWithLightStatusBar = self.isKind(of: AuthVC.self) ||
//                                        self.isKind(of: ContactVC.self) ||
//                                        self.isKind(of: MoreVC.self)
//        navigationController?.navigationBar.barStyle = isViewsWithLightStatusBar ? .default : .black
    }

    // MARK: - Public

    func showCombinedErrorFrom(collection: [String: String]) {
        let joined = collection.values.joined(separator: "\n")
//        let vc = YTPAlertViewController(message: joined,
//                                        messageViewType: .error, completion: nil)
//        self.present(vc, animated: true, completion: nil)

    }
    
//    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
//        return shouldBeAllowedBackSwipe()
//    }

//    private func shouldBeAllowedBackSwipe() -> Bool {
//        if let navigation = navigationController {
//            return navigation.viewControllers.count > 1 && !(navigation.topViewController is TabBarController)
//        } else {
//            if let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) {
//                if let topViewController = window.rootViewController?.topViewController(),
//                   let navigation = topViewController.navigationController {
//                    return navigation.viewControllers.count > 1 && !(topViewController is TabBarController)
//                }
//            }
//        }
//        return false
//    }
 
    // MARK: VMToVCExchange methods
    
    func performLanguageSensitiveRequests() {

    }

    func dataFetched<T>(type: T.Type, data: T?, observerName: String) {
        
    }
    
    func invalidDataErrorReceived<T>(fieldType: T.Type, data: [String: String]) {

    }
    
    func errorReceived(error: LXNetworkError) {
        let alertView = UIAlertController(title: "Error",
                                          message: error.message ?? "Unknown error",
                                          preferredStyle: UIAlertController.Style.alert)
        
        alertView.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
              print("Handle Ok logic here")
        }))


//        let vc = LXCoreAlertViewController(message: error.message ?? "",
//                                           messageViewType: .error,
//                                           completion: nil)
//        alertView.show(self, sender: nil)
        self.present(alertView, animated: true, completion: nil)
    }

    
    // MARK: - Private
    // MARK: Init UI elements
    
    private func commonInitUIElements() {

        
        self.navigationController?.navigationBar.isHidden = self is SplashVC ||
        self is RecipesVC
        

        if self.lxCoreNavigationBarView != nil {
            self.lxCoreNavigationBarView.delegate = self
        }
        
    }

    private func addLanguageChangeObserver() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(changeLanguage),
                                               name: Notification.Name(rawValue: "changeLanguage"),
                                               object: nil)
    }
    @objc internal func changeLanguage() {
        reloadState = .needsReload
    }

    private func addObservers() {
        guard !didAddObservers else { return }
        didAddObservers = true

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShowNote(_:)),
                                               name: UIApplication.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHildeNote(_:)),
                                               name: UIApplication.keyboardWillHideNotification,
                                               object: nil)

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillChangeFrameNote(_:)),
                                               name: UIApplication.keyboardWillChangeFrameNotification,
                                               object: nil)
    }
    
    private func removeObservers() {
        guard didAddObservers else { return }

        NotificationCenter.default.removeObserver(self, name: UIApplication.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIApplication.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIApplication.keyboardWillChangeFrameNotification, object: nil)
        didAddObservers = false
    }

    @objc func keyboardWillShowNote(_ note: Notification) {
        guard
            let value = note.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue,
            let duration = note.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber else { return }
        let frame = value.cgRectValue

        bottomViewBottomConstraint?.constant = frame.size.height
        UIView.animate(withDuration: duration.doubleValue,
                       delay: 0,
                       options: UIView.AnimationOptions.curveEaseOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
        keyboardIsOpen = true
    }

    @objc func keyboardWillHildeNote(_ note: Notification) {
        guard keyboardIsOpen else { return }
        guard let constraint = bottomViewBottomConstraint?.constant, constraint > 0 else { return }
        bottomViewBottomConstraint?.constant = 0

        UIView.animate(withDuration: 0.25, delay: 0, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
        keyboardIsOpen = false
    }

    @objc func keyboardWillChangeFrameNote(_ note: Notification) {
        guard keyboardIsOpen else { return }
        guard let constraint = bottomViewBottomConstraint?.constant, constraint > 0 else { return }

        if let nsvalue = note.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let rect = nsvalue.cgRectValue
            bottomViewBottomConstraint?.constant = UIScreen.main.bounds.height - rect.minY
            print(rect)
        }
    }

    @objc func ytPaymentsNavigationBarLeftButtonPressed(_ note: Notification) {
    }
    
    
    func endEditing(_ force: Bool) {
        view.endEditing(force)
    }
    
    private func getVM() -> BaseVM? {
        let mirror = Mirror(reflecting: self)
        return mirror.children.first(where: { $0.label == "vm" || $0.label == "viewModel" })?.value as? BaseVM
    }
    
    func leftButtonPressed() {
        self.navigationController?.popViewController(animated: true)
    }

    func rightButtonPressed(mode: LXCoreNavigationBarMode) {
        
    }
}

extension BaseVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
    }
}
