//
//  Container.swift
//  Tonepoem
//
//  Created by Dr. Brandon Wiley on 3/2/23.
//

import Foundation

public protocol Container: Codable
{
    associatedtype Child
    associatedtype Selector

    var selectors: [Selector] { get }

    func get(selector: Selector) throws -> Child
    func put(selector: Selector, value: Child) throws -> Self
}

public func get(value: IcedValue, path: [Any]) throws -> IcedValue
{
    switch value
    {
        case .Leaf(_):
            guard path.isEmpty else
            {
                throw ContainerError.badSelector
            }

            return value

        case .Branch(let branch):
            if path.isEmpty
            {
                return value
            }
            else
            {
                let (head, rest) = try pop(path)

                switch branch
                {
                    case .ArrayValue(let container):
                        guard let selector = head as? ArrayValue.Selector else
                        {
                            throw ContainerError.badSelector
                        }

                        let next = try container.get(selector: selector)
                        return try get(value: next, path: rest)

                    case .Struct(let container):
                        guard let selector = head as? StructValue.Selector else
                        {
                            throw ContainerError.badSelector
                        }

                        let next = try container.get(selector: selector)
                        return try get(value: next, path: rest)

                    case .Class(let container):
                        guard let selector = head as? ClassValue.Selector else
                        {
                            throw ContainerError.badSelector
                        }

                        let next = try container.get(selector: selector)
                        return try get(value: next, path: rest)
                }
            }
    }
}

public func put(container: IcedValue, path: [Any], value: IcedValue) throws -> IcedValue
{
    switch container
    {
        case .Leaf(_):
            guard path.isEmpty else
            {
                throw ContainerError.badSelector
            }

            return value

        case .Branch(let branch):
            if path.isEmpty
            {
                return value
            }
            else
            {
                let (head, rest) = try pop(path)

                switch branch
                {
                    case .ArrayValue(let container):
                        guard let selector = head as? ArrayValue.Selector else
                        {
                            throw ContainerError.badSelector
                        }

                        let next = try container.get(selector: selector)
                        return try put(container: next, path: rest, value: value)

                    case .Struct(let container):
                        guard let selector = head as? StructValue.Selector else
                        {
                            throw ContainerError.badSelector
                        }

                        let next = try container.get(selector: selector)
                        return try put(container: next, path: rest, value: value)

                    case .Class(let container):
                        guard let selector = head as? ClassValue.Selector else
                        {
                            throw ContainerError.badSelector
                        }

                        let next = try container.get(selector: selector)
                        return try put(container: next, path: rest, value: value)
                }
            }
    }
}

public func pop(_ path: [Any]) throws -> (Any, [Any])
{
    guard path.count > 0 else
    {
        throw ContainerError.empty
    }

    let head = path[0]
    let rest = [Any](path.dropFirst(1))

    return (head, rest)
}

public enum ContainerError: Error
{
    case empty
    case badSelector
}
