/**
 * File: HTMLElementType.swift
 * File Created: Tuesday, 11th January 2022 10:55:33 pm
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


//  //= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =\\
//  HTMLElementType -
//  \\= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =//
public protocol HTMLElementType: HTMLBaseType
{
    var htmlTag: HTMLTag { get }
    var attributes: HTMLAttributes? { get }
    var classProvider: CSSClassProvider? { get }
    var id: String? { get }
}

public extension HTMLElementType
{
    var html: String 
    { 
        return startOfHTML
    }

    var attributes: HTMLAttributes? { nil }
    var classProvider: CSSClassProvider? { nil }
    var id: String? { nil }

    internal var startOfHTML: String
    {
        let attrsWithClass = (attributes ?? [:]).merging([("class", classProvider?.cssClass),
                                                          ("id", id)].asDictionary, 
                                                         uniquingKeysWith: { _ = $0; return $1; })

        let attrString = attrsWithClass.reduce([], { $0 + [$1] })
                            .map({ "\($0)=\"\($1)\""})
                            .joined(separator: " ")
                            
        let startInner = [htmlTag.rawValue, attrString.isEmpty ? nil : attrString]
                            .compactMap { $0 }
                            .joined(separator: " ")
        return "<\(startInner)>"
    }
}


//  //= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =\\
//  HTMLContainerElementType -
//  \\= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =//
public protocol HTMLContainerElementType: HTMLElementType
{
    var children: [HTMLBaseType] { get }
}

public extension HTMLContainerElementType
{
    var html: String
    {
        containerHTML
    }

    private var containerHTML: String
    {
        let start = startOfHTML
        guard let innerHTML = innerHTML else { return start }
        return start + "\(innerHTML)</\(htmlTag.rawValue)>" 
    }
    
    var innerHTML: String? 
    {
        return children.map({ ($0 as? HTMLContainerElementType)?.containerHTML ?? $0.html }).joined() 
    }
}


//  //= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =\\
//  HTMLTag -
//  \\= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =//
public enum HTMLTag: String
{
    case html

    case body
    case head

    case link
    case meta
    case title

    case div
    case input
    case label
    case button
    case section
    case progress
    case aside
    case p
    case ul
    case li
    case a
    case nav
    case hr
    case span
    case form
    case i

    case table
    case thead
    case tbody
    case tfood
    case th
    case td
    case tr
}
