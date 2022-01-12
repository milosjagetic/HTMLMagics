/**
 * File: Link.swift
 * File Created: Wednesday, 12th January 2022 7:47:38 pm
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

 import Foundation

open class Link: HTMLElement, HTMLAttributeAccess
{
    public enum Rel: String
    {
        case alternate
        case author
        case dnsPrefetch = "dns-prefetch"
        case help
        case icon
        case license
        case next
        case pingback
        case preconnect
        case prefetch
        case preload
        case prerender
        case prev
        case search
        case stylesheet
    }

    public enum AttributeKey: String
    {
        case rel
        case href
    }
    
    public convenience init(id: String? = nil, 
                            attributes: HTMLAttributes? = nil, 
                            classProvider: CSSClassProvider? = nil,
                            rel: Rel,
                            href: URL?) 
    {
        self.init(htmlTag: .link, id: id, attributes: attributes, classProvider: classProvider)

        self[attribute: .rel] = rel.rawValue
        self[attribute: .href] = href?.absoluteString
    }
}