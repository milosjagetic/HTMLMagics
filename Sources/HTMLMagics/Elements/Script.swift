/**
 * File: Script.swift
 * File Created: Saturday, 27th August 2022 12:11:34 pm
 * Author: Miloš Jagetić (milos.jagetic@nth.ch)
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

open class Script: HTMLContainerElement, HTMLAttributeAccess
{
    public enum AttributeKey: String
    {
        case async
        case crossOrigin = "crossorigin"
        case `defer`
        case integrity
        case nonmodule
        case referrerPolicy = "referrerpolicy"
        case src
        case scriptType = "scripttype"
    }

    public init(id: String? = nil,
                src: String)
    {
        super.init(htmlTag: .script, id: id, children: [src])
    }
}