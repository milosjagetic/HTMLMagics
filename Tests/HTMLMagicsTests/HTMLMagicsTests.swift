/**
 * File: HTMLMagicsTests.swift
 * File Created: Tuesday, 11th January 2022 10:24:39 pm
 * Author: Miloš Jagetić (milos.jagetic@gmail.com)
 * -----
 * Begin license text.
 * 
 * Copyright 2022 Miloš Jagetić
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 * End license text.
 */

import XCTest
@testable import HTMLMagics

final class HTMLMagicsTests: XCTestCase 
{
    func testBasics() throws
    {
        let container = HTMLContainerElement(.div, "some-id", nil, ["some-attribute" : "some-value"]) { "basic child" }
        MyAssert(container.html, "<div some-attribute=\"some-value\" id=\"some-id\">basic child</div>", "Failed basic container element test")
    }
}

private func MyAssert<T: Equatable>(_ specimen: T,_ target: T, _ message: String)
{
    XCTAssert(specimen == target, "🛑" + message + "Expected \(target), got \(specimen)!")
}
