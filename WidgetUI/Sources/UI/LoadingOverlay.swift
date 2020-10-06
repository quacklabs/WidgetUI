//
//  LoadingOverlay.swift
//  Olango
//
//  Created by Mark Boleigha on 31/07/2020.
//  Copyright © 2020 Sprinthub. MIT License
//

import UIKit

open class LoadingOverlay {

    var overlayView : UIView!
    var activityIndicator : UIActivityIndicatorView
    lazy var title: Label! = {
        let title = Label()
        title.content = "Please wait..."
        title.textColor = UIColor.black
        title.willSetContraints()
        title.sizeToFit()
        return title
    }()
    
    lazy var titleView: UIView = {
        let titleView = UIView(frame: .zero)
        titleView.layer.backgroundColor = UIColor.white.cgColor
        titleView.layer.cornerRadius = 10
        titleView.willSetContraints()
        return titleView
    }()
    
    var message: String? {
        didSet {
            self.title.text = message
        }
    }
    
    class var instance: LoadingOverlay {
        struct Static {
            static let instance: LoadingOverlay = LoadingOverlay()
        }
        return Static.instance
    }

    init(){
        self.overlayView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        overlayView.backgroundColor = UIColor.black.withAlphaComponent(0.65)
        
        self.activityIndicator = UIActivityIndicatorView(frame: .zero)
        self.activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        self.activityIndicator.clipsToBounds = true
        self.activityIndicator.color = .gray
        
        titleView.addSubviews([activityIndicator, title!])
        
        overlayView.addSubview(titleView)
        NSLayoutConstraint.activate([
            titleView.centerYAnchor.constraint(equalTo: overlayView.centerYAnchor),
            titleView.centerXAnchor.constraint(equalTo: overlayView.centerXAnchor),
            titleView.widthAnchor.constraint(equalToConstant: 300),
            titleView.heightAnchor.constraint(equalToConstant: 80),
            self.activityIndicator.centerYAnchor.constraint(equalTo: titleView.centerYAnchor),
            self.activityIndicator.leadingAnchor.constraint(equalTo: titleView.leadingAnchor, constant: 10),
            self.activityIndicator.heightAnchor.constraint(equalToConstant: 45),
            self.activityIndicator.widthAnchor.constraint(equalToConstant: 45),
            title.centerYAnchor.constraint(equalTo: titleView.centerYAnchor),
            title.centerXAnchor.constraint(equalTo: titleView.centerXAnchor),
        ])
    }

    public func showOverlay(view: UIView, title: String? = nil) {
        (title != nil) ? self.title.text = title : ()
        overlayView.center = view.center
        
        view.addSubview(overlayView)
        activityIndicator.startAnimating()
    }

    public func hideOverlayView() {
        activityIndicator.stopAnimating()
        overlayView.removeFromSuperview()
    }
}

