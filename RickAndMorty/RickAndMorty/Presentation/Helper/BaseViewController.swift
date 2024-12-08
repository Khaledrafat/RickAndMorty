//
//  BaseViewController.swift
//  RickAndMorty
//
//  Created by Khaled on 05/12/2024.
//

import UIKit
import SwiftUI

protocol BaseViewAction {
    func showLoader(on parent: UIViewController)
    func hideLoader()
    func showAlert(
        on parent: UIViewController,
        title: String,
        message: String,
        action: (() -> Void)?
    )
    func dismissAlert()
}

//MARK: - DefaultBaseViewAction
class DefaultBaseViewAction: BaseViewAction {
    
    private var hostingController: UIHostingController<Loader>?
    private var alertHostingController: UIHostingController<AlertView>?
    
    //MARK: - Show Loader
    func showLoader(on parent: UIViewController) {
        let loader = Loader()
        let hostingController = UIHostingController(rootView: loader)
        hostingController.view.backgroundColor = .clear
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        
        parent.addChild(hostingController)
        parent.view.addSubview(hostingController.view)
        
        NSLayoutConstraint.activate([
            hostingController.view.centerXAnchor.constraint(equalTo: parent.view.centerXAnchor),
            hostingController.view.centerYAnchor.constraint(equalTo: parent.view.centerYAnchor),
            hostingController.view.widthAnchor.constraint(equalToConstant: 150),
            hostingController.view.heightAnchor.constraint(equalToConstant: 150)
        ])
        
        hostingController.didMove(toParent: parent)
        self.hostingController = hostingController
    }
    
    //MARK: - Hide Loader
    func hideLoader() {
        hostingController?.willMove(toParent: nil)
        hostingController?.view.removeFromSuperview()
        hostingController?.removeFromParent()
        hostingController = nil
    }
    
    //MARK: - Show Alert
    func showAlert(
            on parent: UIViewController,
            title: String,
            message: String,
            action: (() -> Void)? = nil
        ) {
            let isPresented = true

            let alertView = AlertView(
                isPresented: .constant(isPresented),
                title: title,
                message: message,
                action: action
            )

            let hostingController = UIHostingController(rootView: alertView)
            hostingController.view.backgroundColor = .clear

            parent.addChild(hostingController)
            parent.view.addSubview(hostingController.view)

            hostingController.view.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                hostingController.view.topAnchor.constraint(equalTo: parent.view.topAnchor),
                hostingController.view.leadingAnchor.constraint(equalTo: parent.view.leadingAnchor),
                hostingController.view.trailingAnchor.constraint(equalTo: parent.view.trailingAnchor),
                hostingController.view.bottomAnchor.constraint(equalTo: parent.view.bottomAnchor)
            ])

            hostingController.didMove(toParent: parent)
            self.alertHostingController = hostingController
        }
    
    //MARK: - Dismiss Alert
    func dismissAlert() {
        alertHostingController?.willMove(toParent: nil)
        alertHostingController?.view.removeFromSuperview()
        alertHostingController?.removeFromParent()
        alertHostingController = nil
    }
}
