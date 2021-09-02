//
//  EmployeesPresenter.swift
//  AvitoTest
//
//  Created by Marcus on 02.09.2021.
//

protocol EmployeesPresenterProtocol {
    func updateEmployeesData(company: Company?)
    func unableConnectAlert()
}

class EmployeesPresenter: EmployeesPresenterProtocol {
    weak var viewController: EmployeesTableViewControllerProtocol?
    
    func updateEmployeesData(company: Company?) {
        viewController?.updateEmployeesData(company: company)
    }
    
    func unableConnectAlert() {
        viewController?.unableConnect()
    }
}
