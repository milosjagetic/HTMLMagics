/**
 * File: HTMLBaseType.swift
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


//  //= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =\\
//  HTMLBaseType -
//  \\= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =//
public protocol HTMLBaseType
{
    var html: String { get }
}

extension String: HTMLBaseType
{
    public var html: String { self }
}


public struct HTMLBaseTypeArray: HTMLBaseType, ExpressibleByArrayLiteral
{
    public init(arrayLiteral elements: HTMLBaseType...) 
    {
        self.items = elements
    }

    public init(@HTMLContainerElementBuilder builder: () -> [HTMLBaseType] = { [] })
    {
        self.items = builder()
    }

    public let items: [HTMLBaseType]

    public var html: String { items.map({ $0.html }).joined() }
}


//  //= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =\\
//  CSSClassProvider -
//  \\= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =//
public protocol CSSClassProvider
{
    var cssClass: String { get }
}

extension Array: CSSClassProvider
where Element: CSSClassProvider
{
    public var cssClass: String { map { $0.cssClass }.joined(separator: " ") }
}


public enum Rel: String
{
    case alternate
    case author
    case bookmark
    case external
    case dnsPrefetch = "dns-prefetch"
    case help
    case icon
    case license
    case next
    case manifest
    case noFollow = "nofollow"
    case noOpener = "noopener"
    case noReferrer = "noReferrer"
    case pingback
    case preconnect
    case prefetch
    case preload
    case prerender
    case prev
    case search
    case stylesheet
    case tag
}

public enum Target: String
{
    case blank
    case `self`
    case parent
    case top
}