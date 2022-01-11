/**
 * File: HTMLContainerElement.swift
 * File Created: Tuesday, 11th January 2022 11:06:58 pm
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

open class HTMLContainerElement: HTMLContainerElementType
{
    public let htmlTag: HTMLTag
    public let attributes: HTMLAttributes?
    public let children: [HTMLBaseType]
    public let id: String?
    public let classProvider: CSSClassProvider?

    convenience init(_ htmlTag: HTMLTag, _ classProvider: CSSClassProvider?, _ children: [HTMLBaseType])
    {
        self.init(htmlTag: htmlTag, id: nil, classProvider: classProvider, attributes: nil, children: children)
    }

    convenience init(_ htmlTag: HTMLTag, 
                    _ attributes: HTMLAttributes?, 
                    _ id: String?,
                    _ classProvider: CSSClassProvider?,
                    @HTMLContainerElementBuilder _ childrenBuilder: () -> [HTMLBaseType] = { [] } )
    {
        self.init(htmlTag: htmlTag, 
                  id: id, 
                  classProvider: classProvider, 
                  attributes: attributes, 
                  children: childrenBuilder())
    }

    public init(htmlTag: HTMLTag,
                id: String? = nil,
                classProvider: CSSClassProvider? = nil,
                attributes: HTMLAttributes? = nil, 
                children: [HTMLBaseType] = [])
    {
        self.htmlTag = htmlTag
        self.attributes = attributes
        self.children = children
        self.id = id
        self.classProvider = classProvider
    }
}

