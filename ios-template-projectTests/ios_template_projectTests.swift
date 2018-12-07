//
//  ios_template_projectTests.swift
//  ios-template-projectTests
//
//  Created by 刘波 on 2018/12/6.
//  Copyright © 2018 cloudist. All rights reserved.
//

import XCTest
import Quick
import Nimble
@testable import ios_template_project

class ios_template_projectTests: QuickSpec {

    override func spec() {
        describe("these will fail") {
            
            it("can do maths") {
                expect(1) == 2
            }
            
            it("can read") {
                expect("number") == "string"
            }
            
            it("will eventually fail") {
                expect("time").toEventually( equal("done") )
            }
        }
        context("these will pass") {
            
            it("can do maths") {
                expect(23) == 23
            }
            
            it("can read") {
                expect("🐮") == "🐮"
            }
            
            it("will eventually pass") {
                var time = "passing"
                
                DispatchQueue.main.async {
                    time = "done"
                }
                
                waitUntil { done in
                    Thread.sleep(forTimeInterval: 0.5)
                    expect(time) == "done"
                    
                    done()
                }
            }
        }
    }
}
