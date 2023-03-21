//
//  IcedValue.swift
//  
//
//  Created by Dr. Brandon Wiley on 3/13/23.
//

import Foundation

import PotentCodables

public enum IcedValue: Codable
{
    case Branch(ContainerValue)
    case Leaf(LeafValue)
}

//extension IcedValue: Value
//{
//    public var isNull: Bool
//    {
//        switch self
//        {
//            case .Branch(let branchValue):
//                return branchValue.isNull
//
//            case .Leaf(let leafValue):
//                switch leafValue
//                {
//                    case .Basic(let value):
//                        return value.isNull
//
//                    case .String(let value):
//                        return false
//                }
//        }
//    }
//
//    public var unwrapped: Any?
//    {
//        switch self
//        {
//            case .Branch(let containerValue):
//                switch containerValue
//                {
//                    case .ArrayValue(let value):
//                        return value
//
//                    case .Class(let value):
//                        return value
//
//                    case .Struct(let value):
//                        return value
//                }
//
//            case .Leaf(let leafValue):
//                switch leafValue
//                {
//                    case .Basic(let basicValue):
//                        switch basicValue
//                        {
//                            case .Nil:
//                                return nil
//
//                            case .Float(let value):
//                                return value
//
//                            case .Bool(let value):
//                                return value
//
//                            case .Double(let value):
//                                return value
//
//                            case.Int(let value):
//                                return value
//
//                            case.Int8(let value):
//                                return value
//
//                            case.Int16(let value):
//                                return value
//
//                            case.Int32(let value):
//                                return value
//
//                            case.Int64(let value):
//                                return value
//
//                            case.UInt(let value):
//                                return value
//
//                            case.UInt8(let value):
//                                return value
//
//                            case.UInt16(let value):
//                                return value
//
//                            case.UInt32(let value):
//                                return value
//
//                            case.UInt64(let value):
//                                return value
//                        }
//
//                    case .String(let value):
//                        return value
//                }
//        }
//    }
//}

public enum ContainerValue: Codable
{
    case ArrayValue(ArrayValue)
//    case DictionaryValue(Dictionary<Hashable, any Codable>) // FIXME - how?
    case Struct(StructValue)
    case Class(ClassValue)
}

//extension ContainerValue: Equatable
//{
//    public static func == (lhs: ContainerValue, rhs: ContainerValue) -> Bool
//    {
//        switch lhs
//        {
//            case .ArrayValue(let lvalue):
//                switch rhs
//                {
//                    case .ArrayValue(let rvalue):
//                        return lvalue == rvalue
//
//                    default:
//                        return false
//                }
//
//            case .Class(let lvalue):
//                switch rhs
//                {
//                    case .Class(let rvalue):
//                        return lvalue == rvalue
//
//                    default:
//                        return false
//                }
//
//            case .Struct(let lvalue):
//                switch rhs
//                {
//                    case .Struct(let rvalue):
//                        return lvalue == rvalue
//
//                    default:
//                        return false
//                }
//        }
//    }
//}
//
//extension ContainerValue: Value
//{
//    public var isNull: Bool
//    {
//        return false
//    }
//
//    public var unwrapped: Any?
//    {
//        switch self
//        {
//            case .ArrayValue(let value):
//                return value
//
//            case .Class(let value):
//                return value
//
//            case .Struct(let value):
//                return value
//        }
//    }
//}

public enum LeafValue: Codable
{
    case Basic(BasicValue)
    case String(String)
}

public class ArrayValue: Container
{
    public typealias Child = IcedValue
    public typealias Selector = any CodingKey

    let elements: [IcedValue]

    public init(elements: [IcedValue])
    {
        self.elements = elements
    }

    public var selectors: [Selector]
    {
        var results: [Selector] = []
        for index in 0..<self.elements.count
        {
            guard let key = ArrayCodingKey(intValue: index) else
            {
                continue
            }

            results.append(key)
        }

        return results
    }

    public func get(selector: Selector) throws -> Child
    {
        guard let index = selector.intValue else
        {
            throw IcedValueError.badSelector
        }

        guard index >= 0, index < self.elements.count else
        {
            throw IcedValueError.outOfBounds(index)
        }

        return self.elements[index]
    }

    public func put(selector: Selector, value newValue: Child) throws -> Self
    {
        guard let index = selector.intValue else
        {
            throw IcedValueError.badSelector
        }

        guard index >= 0, index < self.elements.count else
        {
            throw IcedValueError.outOfBounds(index)
        }

        var results: [IcedValue] = []
        for (index, element) in self.elements.enumerated()
        {
            guard let key = selector.intValue else
            {
                continue
            }

            if index == key
            {
                results.append(newValue)
            }
            else
            {
                results.append(element)
            }
        }

        return ArrayValue(elements: results) as! Self // FIXME - why?
    }
}

//extension ArrayValue: Equatable
//{
//    public static func == (lhs: ArrayValue, rhs: ArrayValue) -> Bool
//    {
//        return lhs.elements == rhs.elements
//    }
//}
//
//extension ArrayValue: Hashable
//{
//    public func hash(into hasher: inout Hasher)
//    {
//        hasher.combine(self.elements)
//    }
//}
//
//extension ArrayValue: Value
//{
//    public var isNull: Bool
//    {
//        return false
//    }
//
//    public var unwrapped: Any?
//    {
//        return self.elements
//    }
//}

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

extension Dictionary: Container where Key: Codable, Value: Codable
{
    public typealias Child = Value
    public typealias Selector = DictionaryCodingKey

    public var selectors: [Selector]
    {
        var results: [Selector] = []
        for key in self.keys
        {
            let codingKey = DictionaryCodingKey(key: key)
            results.append(codingKey)
        }

        return results
    }

    public func get(selector: Selector) throws -> Value
    {
        for key in self.keys
        {
            if key.hashValue == selector.intValue
            {
                guard let value = self[key] else
                {
                    throw IcedValueError.badSelector
                }

                return value
            }
        }

        throw IcedValueError.badSelector
    }

    public func put(selector: Selector, value newValue: Value) throws -> Self
    {
        var newDictionary = Dictionary<Key, Value>()
        for key in self.keys
        {
            if key.hashValue == selector.intValue
            {
                newDictionary[key] = newValue
            }
            else
            {
                let oldValue = self[key]
                newDictionary[key] = oldValue
            }
        }

        return newDictionary
    }
}

public struct DictionaryCodingKey: CodingKey
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

    public init(key: any Hashable)
    {
        self.index = key.hashValue
    }

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

public enum BasicValue: Codable
{
    case Nil
    case Bool(Bool)
    case Double(Double)
    case Float(Float)
    case Int(Int)
    case Int8(Int8)
    case Int16(Int16)
    case Int32(Int32)
    case Int64(Int64)
    case UInt(UInt)
    case UInt8(UInt8)
    case UInt16(UInt16)
    case UInt32(UInt32)
    case UInt64(UInt64)
}

extension BasicValue: Equatable
{
    public static func == (lhs: BasicValue, rhs: BasicValue) -> Bool
    {
        switch lhs
        {
            case .Nil:
                switch rhs
                {
                    case .Nil:
                        return true

                    default:
                        return false
                }

            case Bool(let lvalue):
                switch rhs
                {
                    case .Bool(let rvalue):
                        return lvalue == rvalue

                    default:
                        return false
                }

            case Double(let lvalue):
                switch rhs
                {
                    case .Double(let rvalue):
                        return lvalue == rvalue

                    default:
                        return false
                }

            case Float(let lvalue):
                switch rhs
                {
                    case .Float(let rvalue):
                        return lvalue == rvalue

                    default:
                        return false
                }

            case Int(let lvalue):
                switch rhs
                {
                    case .Int(let rvalue):
                        return lvalue == rvalue

                    default:
                        return false
                }

            case Int8(let lvalue):
                switch rhs
                {
                    case .Int8(let rvalue):
                        return lvalue == rvalue

                    default:
                        return false
                }

            case Int16(let lvalue):
                switch rhs
                {
                    case .Int16(let rvalue):
                        return lvalue == rvalue

                    default:
                        return false
                }

            case Int32(let lvalue):
                switch rhs
                {
                    case .Int32(let rvalue):
                        return lvalue == rvalue

                    default:
                        return false
                }

            case Int64(let lvalue):
                switch rhs
                {
                    case .Int64(let rvalue):
                        return lvalue == rvalue

                    default:
                        return false
                }

            case UInt(let lvalue):
                switch rhs
                {
                    case .UInt(let rvalue):
                        return lvalue == rvalue

                    default:
                        return false
                }

            case UInt8(let lvalue):
                switch rhs
                {
                    case .UInt8(let rvalue):
                        return lvalue == rvalue

                    default:
                        return false
                }

            case UInt16(let lvalue):
                switch rhs
                {
                    case .UInt16(let rvalue):
                        return lvalue == rvalue

                    default:
                        return false
                }

            case UInt32(let lvalue):
                switch rhs
                {
                    case .UInt32(let rvalue):
                        return lvalue == rvalue

                    default:
                        return false
                }

            case UInt64(let lvalue):
                switch rhs
                {
                    case .UInt64(let rvalue):
                        return lvalue == rvalue

                    default:
                        return false
                }
        }
    }
}

extension BasicValue: Hashable
{
    public func hash(into hasher: inout Hasher)
    {
        switch self
        {
            case .Nil:
                hasher.combine("nil") // FIXME - What is better?

            case .Bool(let value):
                hasher.combine(value)

            case .Double(let value):
                hasher.combine(value)

            case .Float(let value):
                hasher.combine(value)

            case .Int(let value):
                hasher.combine(value)

            case .Int8(let value):
                hasher.combine(value)

            case .Int16(let value):
                hasher.combine(value)

            case .Int32(let value):
                hasher.combine(value)

            case .Int64(let value):
                hasher.combine(value)

            case .UInt(let value):
                hasher.combine(value)

            case .UInt8(let value):
                hasher.combine(value)

            case .UInt16(let value):
                hasher.combine(value)

            case .UInt32(let value):
                hasher.combine(value)

            case .UInt64(let value):
                hasher.combine(value)
        }
    }
}

extension BasicValue: Value
{
    public var isNull: Bool
    {
        switch self
        {
            case .Nil:
                return true

            default:
                return false
        }
    }

    public var unwrapped: Any?
    {
        switch self
        {
            case .Nil:
                return nil

            case .Bool(let value):
                return value

            case .Double(let value):
                return value

            case .Float(let value):
                return value

            case .Int(let value):
                return value

            case .Int8(let value):
                return value

            case .Int16(let value):
                return value

            case .Int32(let value):
                return value

            case .Int64(let value):
                return value

            case .UInt(let value):
                return value

            case .UInt8(let value):
                return value

            case .UInt16(let value):
                return value

            case .UInt32(let value):
                return value

            case .UInt64(let value):
                return value
        }
    }
}

public class StructValue: Codable, Container
{
    public typealias Child = IcedValue
    public typealias Selector = FieldCodingKey

    public var fields: [FieldValue]

    public var selectors: [Selector]
    {
        var results: [Selector] = []
        for field in self.fields
        {
            results.append(FieldCodingKey(field: field))
        }

        return results
    }

    public init(fields: [FieldValue])
    {
        self.fields = fields
    }

    public func get(selector: Selector) throws -> Child
    {
        for field in fields
        {
            if field.name.hashValue == selector.intValue
            {
                return field.value
            }
        }

        throw IcedValueError.badSelector
    }

    public func put(selector: Selector, value newValue: Child) throws -> Self
    {
        var results: [FieldValue] = []
        for field in self.fields
        {
            if field.name.hashValue == selector.intValue
            {
                let newField = FieldValue(name: field.name, value: newValue)
                results.append(newField)
            }
            else
            {
                results.append(field)
            }
        }

        return StructValue(fields: results) as! Self // FIXME - why?
    }
}

//extension StructValue: Equatable
//{
//    public static func == (lhs: StructValue, rhs: StructValue) -> Bool
//    {
//        return lhs.fields == rhs.fields
//    }
//}
//
//extension StructValue: Hashable
//{
//    public func hash(into hasher: inout Hasher)
//    {
//        hasher.combine((self.fields))
//    }
//}
//
//extension StructValue: Value
//{
//    public var isNull: Bool = false
//
//    public var unwrapped: Any?
//    {
//
//    }
//}

public struct FieldCodingKey: CodingKey
{
    public var intValue: Int?
    {
        return hash
    }

    public var stringValue: String
    {
        return String(self.hash)
    }

    let hash: Int

    public init(field: FieldValue)
    {
        self.hash = field.name.hashValue
    }

    public init?(intValue: Int)
    {
        self.hash = intValue
    }

    public init?(stringValue: String)
    {
        self.hash = stringValue.hashValue
    }
}

public struct ClassValue: Codable, Container
{
    public typealias Child = IcedValue
    public typealias Selector = FieldCodingKey

    public let fields: [FieldValue]

    public var selectors: [Selector]
    {
        var results: [Selector] = []
        for field in self.fields
        {
            results.append(FieldCodingKey(field: field))
        }

        return results
    }

    public init(fields: [FieldValue])
    {
        self.fields = fields
    }

    public func get(selector: Selector) throws -> Child
    {
        for field in fields
        {
            if field.name.hashValue == selector.intValue
            {
                return field.value
            }
        }

        throw IcedValueError.badSelector
    }

    public func put(selector: Selector, value newValue: Child) throws -> Self
    {
        var results: [FieldValue] = []
        for field in self.fields
        {
            if field.name.hashValue == selector.intValue
            {
                let newField = FieldValue(name: field.name, value: newValue)
                results.append(newField)
            }
            else
            {
                results.append(field)
            }
        }

        return ClassValue(fields: results)
    }
}

public struct FieldValue: Codable
{
    public let name: String
    public let value: IcedValue

    public enum CodingKeys: Int, CodingKey
    {
        case name
        case value
    }

    public init(name: String, value: IcedValue)
    {
        self.name = name
        self.value = value
    }

    public init(from decoder: Decoder) throws
    {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let name = try container.decode(String.self, forKey: .name)
        let value = try container.decode(IcedValue.self, forKey: .value)

        self.name = name
        self.value = value
    }
}

public enum IcedValueError: Error
{
    case outOfBounds(Int)
    case typeMismatch
    case badSelector
}
