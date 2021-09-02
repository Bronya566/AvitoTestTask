//
//  CustomTableView.swift
//  Avito
//
//  Created by Marcus on 01.09.2021.
//

import Foundation
import UIKit

class EmployeesCustomTableViewCell:  UITableViewCell {
    private let nameLabel = UILabel()
    private let phoneNumberLabel = UILabel()
    private let skillsLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(nameLabel)
        addSubview(phoneNumberLabel)
        addSubview(skillsLabel)
        nameLabel.frame = CGRect(x: 0, y: 0, width: frame.width, height: EmployeesTableViewController.Constants.employeesCellLabelHeight)
        phoneNumberLabel.frame = CGRect(x: 0, y: EmployeesTableViewController.Constants.employeesCellLabelHeight, width: frame.width, height: EmployeesTableViewController.Constants.employeesCellLabelHeight)
        skillsLabel.frame = CGRect(x: 0, y: EmployeesTableViewController.Constants.employeesCellLabelHeight * 2, width: frame.width, height: EmployeesTableViewController.Constants.employeesCellLabelHeight)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLabel(name: String?, phoneNumber: String?, skills: [String]?) {
        let count = skills?.count ?? 0
        if let name = name {
            nameLabel.text = "Name: \(name)"
        }
        if let phoneNumber = phoneNumber {
            phoneNumberLabel.text = "Phone: \(phoneNumber)"
        }
        if let skills = skills {
            var skillsString = ""
            for (index, skill) in skills.enumerated() {
                skillsString.append(" \(skill)")
                if !(index == (count - 1)) {
                    skillsString.append(",")
                }
            }
            skillsLabel.text = "Skills:\(skillsString)"
        }
    }
}
