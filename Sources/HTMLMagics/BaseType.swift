/**
 * File: BaseType.swift
 * File Created: Tuesday, 11th January 2022 10:24:39 pm
 * Author: Miloš Jagetić (milos.jagetic@gmail.com)
 * -----
 * Copyright 2021 - 2022 REGALE DIGITA
 */

public protocol BaseType
{
    var html: String { get}
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


//  //= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =\\
//  HTMLElementType -
//  \\= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =//
public protocol HTMLElementType: HTMLBaseType
{
    var htmlTag: HTMLTag { get }
    var attributes: HTMLAttributes? { get }
    var innerHTML: String? { get }
    var classProvider: CSSClassProvider? { get }
    var id: String? { get }
}

public extension HTMLElementType
{
    var html: String 
    { 
        let attrsWithClass = (attributes ?? [:]).merging([("class", classProvider?.cssClass),
                                                          ("id", id)].asDictionary, 
                                                         uniquingKeysWith: { _ = $0; return $1; })

        let attrString = attrsWithClass.reduce([], { $0 + [$1] })
                            .map({ "\($0)=\"\($1)\""})
                            .joined(separator: " ")

        let start = "<\(htmlTag.rawValue) \(attrString)>"
        guard let innerHTML = innerHTML else { return start }
        return start + "\(innerHTML)</\(htmlTag.rawValue)>" 
    }

    var innerHTML: String? { nil }
    var attributes: HTMLAttributes? { nil }
    var classProvider: CSSClassProvider? { nil }
    var id: String? { nil }
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
    var innerHTML: String? { children.map({ $0.html }).joined() }
}


//  //= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =\\
//  HTMLContainerElement -
//  \\= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =//
public struct HTMLContainerElement: HTMLContainerElementType, ResponseEncodable
{
    public func encodeResponse(for request: Request) -> EventLoopFuture<Response> 
    {
       request.eventLoop.makeCompletedFuture(.success(Response(status: .ok, 
                                                                version: .http1_1, 
                                                                headers: [:], 
                                                                body: .init(string: html))))
    }

    public let htmlTag: HTMLTag
    public let attributes: HTMLAttributes?
    public let children: [HTMLBaseType]
    public let id: String?
    public let classProvider: CSSClassProvider?

    public init(_ htmlTag: HTMLTag, _ classProvider: CSSClassProvider?, _ children: [HTMLBaseType])
    {
        self.init(htmlTag: htmlTag, id: nil, classProvider: classProvider, attributes: nil, children: children)
    }

    public init(_ htmlTag: HTMLTag, 
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


//  //= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =\\
//  Helpers -
//  \\= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =//
public typealias HTMLAttributes = [String : String]

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
    static func buildExpression(_ element: Expression) -> Component 
    {
        return [element]
    }

    static func buildOptional(_ component: Component?) -> Component 
    {
        guard let component = component else { return [] }
        return component
    }

    static func buildEither(first component: Component) -> Component 
    {
        return component
    }

    static func buildEither(second component: Component) -> Component 
    {
        return component
    }

    static func buildArray(_ components: [Component]) -> Component 
    {
        return Array(components.joined())
    }

    static func buildBlock(_ components: Component...) -> Component 
    {
        return Array(components.joined())
    }
}

public enum HTMLTag: String
{
    case div
    case link
    case html
    case body
    case head
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
}

extension Array 
where Element == (String, String?)
{
    var asDictionary: [String : String]
    {
        compactMap({ $0.1 != nil ? $0 : nil })
        .reduce([:], 
            {  
                $0.merging([$1.0 : $1.1!], uniquingKeysWith: { _ = $1; return $0; })
            })
    }
}