/**
 * File: Helpers.swift
 * File Created: Tuesday, 11th January 2022 11:07:34 pm
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

public typealias HTMLAttributes = [String : String]

extension Array 
where Element == (String, String?)
{
    public var asDictionary: [String : String]
    {
        compactMap({ $0.1 != nil ? $0 : nil })
        .reduce([:], { $0.setting([$1.0 : $1.1!]) })
    }
}

extension HTMLAttributes
{    
    public func setting(_ attributes: HTMLAttributes) -> HTMLAttributes
    {
        return merging(attributes, uniquingKeysWith: { _ = $0; return $1; })
    }

    public func setting(_ pairs: [(String, String?)]) -> HTMLAttributes
    {
        var new = self
        for i in pairs { new[i.0] = i.1 }

        return new
    }
}

@resultBuilder
public struct HTMLContainerElementBuilder: HTMLElementBuilderType
{
    public typealias Component = [HTMLBaseType]
    public typealias Expression = HTMLBaseType
}

public protocol HTMLElementBuilderType
{
    associatedtype Component
    associatedtype Expression
}

extension HTMLElementBuilderType
where Component == Array<Expression>
{
    public static func buildExpression(_ element: Expression) -> Component 
    {
        return [element]
    }

    public static func buildOptional(_ component: Component?) -> Component 
    {
        guard let component = component else { return [] }
        return component
    }

    public static func buildEither(first component: Component) -> Component 
    {
        return component
    }

    public static func buildEither(second component: Component) -> Component 
    {
        return component
    }

    public static func buildArray(_ components: [Component]) -> Component 
    {
        return Array(components.joined())
    }

    public static func buildBlock(_ components: Component...) -> Component 
    {
        return Array(components.joined())
    }
}
