/**
 * File: Meta.swift
 * File Created: Sunday, 23rd January 2022 10:38:59 pm
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

open class Meta: HTMLElement, HTMLAttributeAccess
{
    public enum AttributeKey: String
    {
        case charset
        case name
        case content
        case httpEquiv = "http-equiv"
    }
    
    public enum Name: String
    {
        case applicationName = "application-name"
        case author
        case description
        case generator
        case keywords
        case viewport        
    }

    public enum HTTPHeader: String
    {
        case contentSecurityPolicy = "content-security-policy"
        case contentType = "content-type"
        case defaultStyle = "default-style"
        case refresh
        case cacheControl = "cache-control"
        case expires
        case pragma
    }

    public enum Charset: String
    {
        case iso_8859_1 = "ISO-8859-1"
        case utf8 = "UTF-8"
    }

    public required init(id: String? = nil,
                        charset: Charset)
    {
        super.init(htmlTag: .meta, id: id)

        self[attribute: .charset] = charset.rawValue
    }

    public required init(id: String? = nil,
                        name: Name,
                        content: String)
    {
        super.init(htmlTag: .meta, id: id)

        self[attribute: .name] = name.rawValue
        self[attribute: .content] = content
    }

    public required init(id: String? = nil,
                        httpHeader: HTTPHeader,
                        content: String)
    {
        super.init(htmlTag: .meta, id: id)

        self[attribute: .httpEquiv] = httpHeader.rawValue
        self[attribute: .content] = content
    }
}