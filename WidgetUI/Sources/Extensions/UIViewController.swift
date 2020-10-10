
//  UIViewController.swift
//  PartyWise
//
//  Created by Mark Boleigha on 31/07/2020.
//  Copyright © 2020 Sprinthub. MIT License
//

import UIKit

public extension UIViewController {
    
    enum AlertType: String, CaseIterable {
        case success = "Success"
        case error = "Error"
        case ok = "Ok"
        
        var style: UIAlertAction.Style {
            switch self {
            case .success:
                return .default
            case .error:
                return .cancel
            case .ok:
                return .default
            }
        }
    }
    
    var loading: LoadingOverlay {
        get {
            return LoadingOverlay.instance
        }
    }
    
    var isModal: Bool {
        if let index = navigationController?.viewControllers.firstIndex(of: self), index > 0 {
            return false
        } else if presentingViewController != nil {
            return true
        } else if navigationController?.presentingViewController?.presentedViewController == navigationController {
            return true
        } else if tabBarController?.presentingViewController is UITabBarController {
            return true
        } else {
            return false
        }
    }
    
    func hideKeyboardOnTapAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.hideKeyboard))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
    }
    
    @objc func hideKeyboard() {
        self.view.endEditing(true)
    }
    
    func customBackButton(title: String?, tintColor: UIColor? = nil, in view: UIView) {
        self.navigationController?.navigationBar.isHidden = true
        let backView = UIView(frame: .zero)
        backView.willSetConstraints()
        let backButton = UIImageView(image: UIImage(named: "ic_back")?.withRenderingMode(tintColor != nil ? .alwaysTemplate : .automatic))
        backButton.contentMode = .scaleAspectFit
        backButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        backButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        backButton.isUserInteractionEnabled = true
        (tintColor != nil) ? backButton.tintColor = tintColor! : ()
        backButton.willSetConstraints()
        let title = Label(font: Font.heading.make(withSize: 18), content: title?.attributed ?? "".attributed, color: .black)
        title.sizeToFit()
        backView.addSubviews([backButton, title])
        view.addSubview(backView)
        NSLayoutConstraint.activate([
            backView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 23),
            backView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            backView.heightAnchor.constraint(equalToConstant: 30),
            backView.widthAnchor.constraint(greaterThanOrEqualToConstant: 30),
            backButton.leadingAnchor.constraint(equalTo: backView.leadingAnchor),
            backButton.topAnchor.constraint(equalTo: backView.topAnchor, constant: 1.5),
            title.centerYAnchor.constraint(equalTo: backButton.centerYAnchor),
            title.leadingAnchor.constraint(equalTo: backButton.trailingAnchor, constant: 9.5),
        ])
        backButton.sizeToFit()
        
        backView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.back)))
    }
    
    func addBackButton(icon: UIImage? = nil) {
        let backButton = UIButton(type: .custom)
        backButton.setImage(icon ?? UIImage(named: "ic_back"), for: .normal)
        backButton.imageView?.contentMode = .scaleAspectFit
        backButton.contentVerticalAlignment = .fill
        backButton.contentHorizontalAlignment = .fill
        backButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        backButton.widthAnchor.constraint(equalToConstant: 20).isActive = true
        backButton.addTarget(self, action: #selector(self.back), for: .touchUpInside)
        backButton.willSetConstraints()
        
        if self.isModal {
            if self.navigationController?.navigationBar != nil {
                let buttonItem = UIBarButtonItem(customView: backButton)
                self.navigationItem.leftBarButtonItem = buttonItem
//                self.navigationController?.navigationBar.barTintColor = .white
                self.navigationController?.navigationBar.isHidden = false
                self.navigationController?.navigationBar.addShadow(color: UIColor.black.withAlphaComponent(0.65), withOffset: CGSize(width: 0, height: -3))
            } else {
                self.view.addSubview(backButton)
                NSLayoutConstraint.activate([
                    backButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 22),
                    backButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 13),
                ])
            }
            
        } else {
            let buttonItem = UIBarButtonItem(customView: backButton)
            self.navigationItem.leftBarButtonItem = buttonItem
            self.navigationController?.navigationBar.barTintColor = .white
            self.navigationController?.navigationBar.isHidden = false
            self.navigationController?.navigationBar.addShadow(color: UIColor.black.withAlphaComponent(0.65), withOffset: CGSize(width: 0, height: -3))
        }
        
        
    }
    
    @objc func back(_ sender: UIGestureRecognizer? = nil) {
        if self.isModal {
            dismiss(animated: true, completion: nil)
        } else {
            self.navigationController?.popViewController(animated: true)
        }
    }
//
//    @objc func backToHome() {
//        Navigation.setUpAsRootViewController()
//    }
    
//    func backToView<T: UIViewController>(navigateTo: T) {
//        
//        if let navigation = AppDelegate.shared.window!.rootViewController as? Navigation {
//            
//            navigation.viewControllers!.enumerated().forEach({
//                if ($0.element.children.first as? T) != nil {
//                    navigation.navigateToTab(tab: $0.offset) // Tab index found, navigate to it
//                    return
//                }
//            })
//        } else {
//            Navigation.setUpAsRootViewController() {
//                let navigation = AppDelegate.shared.window!.rootViewController as! Navigation
//                // Now we find our transactions controller index on the tab menu
//                navigation.viewControllers!.enumerated().forEach({
//                    if ($0.element.children.first as? T) != nil {
//                        navigation.navigateToTab(tab: $0.offset) // Tab index found, navigate to it
//                        return
//                    }
//                })
//                
//            }
//        }
//        
//        
//    }
    
    func wrapInNavigation() -> UINavigationController {
//        self.navigationController?.navigationBar.isHidden = true
        return UINavigationController(rootViewController: self)
    }
    
    func showAlert(type: AlertType, title: String? = nil, message: String, completion: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: title ?? type.rawValue, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: AlertType.ok.rawValue, style: type.style, handler: completion)
        
        alert.addAction(action)
        DispatchQueue.main.async {
            self.present(alert, animated: true)
        }
    }
    
    func setTitle(title: String) {
        if self.isModal {
            if self.navigationController?.navigationBar != nil {
                navigationItem.title = title
            } else {
                let viewTitle = Label(font: Font.heading.make(withSize: 20).semibold, content: NSMutableAttributedString(string: title), color: .black)
                self.view.addSubview(viewTitle)
                NSLayoutConstraint.activate([
                    viewTitle.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                    viewTitle.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 13),
                ])
            }
            
        } else {
            navigationItem.title = title
        }
    }
    
//    static func loadFromNib(name: String) -> UIView {
//        let bundle = Bundle.main
//        let nib = UINib(nibName: name, bundle: bundle)
//        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
//        return view
//    }
//
    
}
