//
//  EmployeesAssembly.swift
//  AvitoTest
//
//  Created by Marcus on 02.09.2021.
//

import UIKit

final class EmployeesAssembly {
    static func assemblyEmployeesViewController() -> UITableViewController {
        let viewController = EmployeesTableViewController()
        let interactor = EmployeesInteractor()
        let presenter = EmployeesPresenter()
        
        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController
        
        return viewController
    }
}
