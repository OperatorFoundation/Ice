//
//  BasicValue.swift
//  
//
//  Created by Dr. Brandon Wiley on 3/22/23.
//

import Foundation

import Datable
import PotentCodables

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
