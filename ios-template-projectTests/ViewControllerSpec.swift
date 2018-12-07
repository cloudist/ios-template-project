//
//  ViewControllerSpec.swift
//  ios-template-projectTests
//
//  Created by 刘波 on 2018/12/7.
//  Copyright © 2018 cloudist. All rights reserved.
//

import Foundation
import Quick
import Nimble
@testable import ios_template_project

class ViewControllerSpec: QuickSpec {
    override func spec() {
        var viewController: ViewController!
        beforeEach {
            viewController = ViewController()
        }
        
        describe(".viewDidLoad") {
            beforeEach {
                _ = viewController.view
            }
            
            it("set background color to red") {
                viewController.view.backgroundColor = .red
                expect(viewController.view.backgroundColor).to(equal(.red))
            }
            
            it("set title to 'srv7'") {
                viewController.title = "srv7"
                expect(viewController.title).to(equal("srv7"))
            }
        }
    }
}
