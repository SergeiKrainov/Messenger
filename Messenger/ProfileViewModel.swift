//
//  ProfileViewModel.swift
//  Messenger
//
//  Created by Sergey on 21.07.2022.
//

import Foundation


enum ProfileViewModelType {
    case info, logout
}

struct ProfileViewModel {
    let viewModelType: ProfileViewModelType
    let title: String
    let handler: (() -> Void)?
}
