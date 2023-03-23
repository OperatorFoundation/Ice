//
//  ArrayValue.swift
//  
//
//  Created by Dr. Brandon Wiley on 3/22/23.
//

import Foundation

import Datable
import PotentCodables

public struct ArrayValue: Codable
{
//    public typealias Child = IcedValue
//    public typealias Selector = any CodingKey

    let elements: [IcedValue]

    public init(elements: [IcedValue])
    {
        self.elements = elements
    }

//    public var selectors: [Selector]
//    {
//        var results: [Selector] = []
//        for index in 0..<self.elements.count
//        {
//            guard let key = ArrayCodingKey(intValue: index) else
//            {
//                continue
//            }
//
//            results.append(key)
//        }
//
//        return results
//    }
//
//    public func get(selector: Selector) throws -> Child
//    {
//        guard let index = selector.intValue else
//        {
//            throw IcedValueError.badSelector
//        }
//
//        guard index >= 0, index < self.elements.count else
//        {
//            throw IcedValueError.outOfBounds(index)
//        }
//
//        return self.elements[index]
//    }
//
//    public func put(selector: Selector, value newValue: Child) throws -> Self
//    {
//        guard let index = selector.intValue else
//        {
//            throw IcedValueError.badSelector
//        }
//
//        guard index >= 0, index < self.elements.count else
//        {
//            throw IcedValueError.outOfBounds(index)
//        }
//
//        var results: [IcedValue] = []
//        for (index, element) in self.elements.enumerated()
//        {
//            guard let key = selector.intValue else
//            {
//                continue
//            }
//
//            if index == key
//            {
//                results.append(newValue)
//            }
//            else
//            {
//                results.append(element)
//            }
//        }
//
//        return ArrayValue(elements: results) as! Self // FIXME - why?
//    }
}

extension ArrayValue: Equatable
{
    public static func == (lhs: ArrayValue, rhs: ArrayValue) -> Bool
    {
        return lhs.elements == rhs.elements
    }
}

extension ArrayValue: Hashable
{
    public func hash(into hasher: inout Hasher)
    {
        hasher.combine(self.elements)
    }
}

extension ArrayValue: Value
{
    public var isNull: Bool
    {
        return false
    }

    public var unwrapped: Any?
    {
        return self.elements
    }
}

public struct ArrayCodingKey: CodingKey
{
    public var intValue: Int?
    {
        return self.index
    }

    public var stringValue: String
    {
        return String(self.index)
    }

    let index: Int

    public init?(intValue: Int)
    {
        self.index = intValue
    }

    public init?(stringValue: String)
    {
        guard let index = Int(stringValue) else
        {
            return nil
        }

        self.index = index
    }
}
