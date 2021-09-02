//
//  Interactor.swift
//  AvitoTest
//
//  Created by Marcus on 02.09.2021.
//

import Foundation
import UIKit

protocol EmployeesInteractorProtocol {
    func startLoadingData()
}

class EmployeesInteractor: EmployeesInteractorProtocol {
    var presenter: EmployeesPresenterProtocol?
    private var networkService = NetworkService()
    
    func startLoadingData() {
        needConnect()
        networkService.startEmployeesLoading {
            [weak self] employees in
            self?.presenter?.updateEmployeesData(company: employees)
        }
    }
    
    private func needConnect() {
        guard !NetworkService.isConnectedToNetwork() else {
            return
        }
        presenter?.unableConnectAlert()
    }
}
