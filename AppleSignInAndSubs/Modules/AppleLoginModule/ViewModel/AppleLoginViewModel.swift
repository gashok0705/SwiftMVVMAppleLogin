//
//  AppleLoginViewModel.swift
//  AppleSignInAndSubs
//
//  Created by Rajagopal Ganesan on 01/09/22.
//

import Foundation

//MARK: - Protocol
protocol AppleLoginViewModel: AnyObject {
    
    var userModel: User { get }
    
}

class AppleLoginViewModelImpl : AppleLoginViewModel {
    
    //MARK: - Internal Variables
    private var _userModel = User()
    var userModel: User {
        return _userModel
    }
    
    //MARK: - init
    init(firstName: String, lastName: String, email: String) {
        self._userModel.firstName = firstName
        self._userModel.lastName = lastName
        self._userModel.email = email
    }
    
    
}
