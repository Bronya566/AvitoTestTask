//
//  EmployeesTableViewController.swift
//  AvitoTest
//
//  Created by Marcus on 02.09.2021.
//

import Foundation
import UIKit

protocol EmployeesTableViewControllerProtocol: AnyObject {
    func updateEmployeesData(company: Company?)
    func unableConnect()
}

class EmployeesTableViewController: UITableViewController,  EmployeesTableViewControllerProtocol {
    var interactor: EmployeesInteractorProtocol?
    private var company: Company?
    
    override func viewDidLoad() {
        title = "Unknown"
        interactor?.startLoadingData()
        super.viewDidLoad()
    }
    
    func updateEmployeesData(company: Company?) {
        self.company = company
        DispatchQueue.main.async { [weak self] in
            self?.title = company?.company.name
            self?.tableView.reloadData()
        }
    }
    
    func unableConnect() {
        DispatchQueue.main.async { [weak self] in
            let alert = UIAlertController(title: "",
                                          message: "Извините, нет подключения к интернету",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Закрыть", style: .default, handler: nil))
            self?.present(alert, animated: true, completion: nil)
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return company?.company.employees.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        Constants.cellHeight
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = EmployeesCustomTableViewCell(style: .default, reuseIdentifier: "")
        cell.setupLabel(name: company?.company.employees[indexPath.row].name,
                        phoneNumber: company?.company.employees[indexPath.row].phone_number,
                        skills: company?.company.employees[indexPath.row].skills)
        return cell
    }
}

extension EmployeesTableViewController {
    enum Constants {
        static let cellHeight: CGFloat = 150
        static let employeesCellLabelHeight: CGFloat = 50
    }
}
