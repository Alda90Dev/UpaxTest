//
//  UpaxTestTests.swift
//  UpaxTestTests
//
//  Created by Aldair Carrillo on 09/01/23.
//

import XCTest
@testable import UpaxTest
@testable import FirebaseAuth

final class UpaxTestTests: XCTestCase {

    func testLogin() {
        let expectation = self.expectation(description: "login")
        var user: User?
        let email = "aldadev@gmail.com"
        let password = "aldadev"
        
        let firebase = FirebaseManager.shared
        
        firebase.signIn(email: email, password: password) { (result: NetworkResult<User>) in
            switch result {
            case .success(let data):
                user = data
                break
            default:
                break
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10, handler: nil)
        XCTAssertNotNil(user)
        
    }
    
    func testRegister() {
        let expectation = self.expectation(description: "register")
        var user: User?
        let email = "nuevouser@gmail.com"
        let password = "123456"
        
        let firebase = FirebaseManager.shared
        
        firebase.createUser(email: email, password: password) { (result: NetworkResult<User>) in
            switch result {
            case .success(let data):
                user = data
                break
            default:
                break
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10, handler: nil)
        XCTAssertNotNil(user)
        
    }
    
    func testGetImageURL() {
        let expectation = self.expectation(description: "url")
        var urlString: String?
        let name: String = "aldair"
        
        let firebase = FirebaseManager.shared
        firebase.getImage(name: name) { (result: NetworkResult<String>) in
            switch result {
            case .success(let url):
                urlString = url
            default:
                break
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10, handler: nil)
        XCTAssertNotNil(urlString)
    }

    func getProducts() {
        let expectation = self.expectation(description: "products")
        var productResponse: ProductResponse?
        
        NetworkManager.shared.request(networkRouter: NetworkRouter.getProducts) { (result: NetworkResult<ProductResponse>) in
            switch result {
            case .success(let prodResp):
                productResponse = prodResp
            default:
                break
            }
            
            expectation.fulfill()
        }

        
        waitForExpectations(timeout: 10, handler: nil)
        XCTAssertNotNil(productResponse)
    }
}
