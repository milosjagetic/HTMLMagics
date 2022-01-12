/**
 * File: HTMLElement.swift
 * File Created: Wednesday, 12th January 2022 2:52:10 pm
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

open class HTMLElement<AttributeKey: RawRepresentable>: HTMLElementType
{
    public let htmlTag: HTMLTag
    public var attributes: HTMLAttributes? 
    public var classProvider: CSSClassProvider? 
    public var id: String? 

    public init(htmlTag: HTMLTag, 
                id: String? = nil, 
                attributes: HTMLAttributes? = nil, 
                classProvider: CSSClassProvider? = nil)
    {
        self.htmlTag = htmlTag
        self.id = id
        self.attributes = attributes
        self.classProvider = classProvider
    }

    public subscript(attribute key: AttributeKey) -> String?
    where AttributeKey.RawValue == String
    {
        get { getAttribute(key) }
        set { setAttribute(key, value: newValue) }
    }


    public func getAttribute(_ key: AttributeKey) -> String? 
    where AttributeKey.RawValue == String
    { 
        attributes?[key.rawValue] 
    }

    public func setAttribute(_ key: AttributeKey, value: String?)
    where AttributeKey.RawValue == String 
    { 
        attributes = (attributes ?? [:]).setting([(key.rawValue, value)]) 
    }
}