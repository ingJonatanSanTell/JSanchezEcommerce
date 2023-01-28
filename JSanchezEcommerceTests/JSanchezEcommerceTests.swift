//
//  JSanchezEcommerceTests.swift
//  JSanchezEcommerceTests
//
//  Created by MacBookMBA4 on 17/01/23.
//

import XCTest
@testable import JSanchezEcommerce

final class JSanchezEcommerceTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testDepartamentoAdd() throws {
        let departamentoViewModel = DepartamentoViewModel()
        let result = departamentoViewModel.Add(departamento: Departamento(IdDepartamento: 0, Nombre: "test", Area: Area(IdArea: 0, Nombre: "")))
        XCTAssertTrue(result.Correct, result.ErrorMessage)
    }
    
    func testDepartamentoDelete() throws {
        let departamentoViewModel = DepartamentoViewModel()
        let result = departamentoViewModel.Delete(idDepartamento: 1)
        XCTAssertTrue(result.Correct, result.ErrorMessage)
    }
    
    func testDepartamentoUpdate() throws {
        let departamentoViewModel = DepartamentoViewModel()
        let result = departamentoViewModel.Update(departamento: Departamento(IdDepartamento: 1, Nombre: "test", Area: Area(IdArea: 1, Nombre: "")))
        XCTAssertTrue(result.Correct, result.ErrorMessage)
    }
    
    func testDepartamentoGetAll() throws {
        let departamentoViewModel = DepartamentoViewModel()
        let result = departamentoViewModel.GetAll()
        XCTAssertTrue(result.Correct, result.ErrorMessage)
    }
    
    func testDepartamentoGetById() throws {
        let departamentoViewModel = DepartamentoViewModel()
        let result = departamentoViewModel.GetById(idDepartamento: 1)
        XCTAssertTrue(result.Correct, result.ErrorMessage)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
