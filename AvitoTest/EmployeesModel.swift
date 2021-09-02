//
//  EmployeesModel.swift
//  Avito
//
//  Created by Marcus on 01.09.2021.
//

import Foundation

struct Company: Decodable {
    var company: CompanyModel
}

struct CompanyModel: Decodable {
    var name: String
    var employees: [EmployeeModel]
}

struct EmployeeModel: Decodable {
    var name : String
    var phone_number: String
    var skills: [String]
}
