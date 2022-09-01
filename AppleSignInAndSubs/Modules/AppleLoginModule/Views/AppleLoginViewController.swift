//
//  AppleLoginViewController.swift
//  AppleSignInAndSubs
//
//  Created by Rajagopal Ganesan on 01/09/22.
//

import UIKit
import AuthenticationServices

class AppleLoginViewController: UIViewController {
    
    //MARK: - Variables
    private let signInButton = ASAuthorizationAppleIDButton()
    private var viewModel : AppleLoginViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addObserverAndSubview()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.setupAppleSignInButton()
        self.setUpNavigationBar()
    }
    
    //MARK: - Private Methods
    private func setUpNavigationBar() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.title = "Login"
    }
    
    private func addObserverAndSubview() {
        self.view.addSubview(self.signInButton)
        self.signInButton.addTarget(self, action: #selector(self.didTapSignInWithAppleButton), for: .touchUpInside)
    }
    
    private func setupAppleSignInButton() {
        self.signInButton.frame = CGRect(x: 0, y: 0, width: 250, height: 50)
        self.signInButton.center = self.view.center
    }
    
    //MARK: - Selector Method
    @objc func didTapSignInWithAppleButton() {
        let provider = ASAuthorizationAppleIDProvider()
        let request = provider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.presentationContextProvider = self
        controller.performRequests()
    }
    
}

extension AppleLoginViewController: ASAuthorizationControllerDelegate {
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        
        print("Failed to login with AppleID")
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        
        switch authorization.credential {
        case let credentials as ASAuthorizationAppleIDCredential:
            self.viewModel = AppleLoginViewModelImpl(firstName: credentials.fullName?.givenName ?? "", lastName: credentials.fullName?.familyName ?? "", email: credentials.email ?? "")
            break
        default:
            break
        }
    }
}

extension AppleLoginViewController: ASAuthorizationControllerPresentationContextProviding {
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        
        var _window = UIWindow()
        if let window = self.view.window {
            _window = window
        }
        return _window
    }
    
}
