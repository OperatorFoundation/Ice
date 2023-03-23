//
//  ContainerValue.swift
//  
//
//  Created by Dr. Brandon Wiley on 3/22/23.
//

import Foundation

import Datable
import PotentCodables

public enum ContainerValue: Codable
{
    case Array(ArrayValue)
    case Dictionary(DictionaryValue)
    case Struct(StructValue)
    case Class(ClassValue)
}

extension ContainerValue: Equatable
{
    public static func == (lhs: ContainerValue, rhs: ContainerValue) -> Bool
    {
        switch lhs
        {
            case .Array(let lvalue):
                switch rhs
                {
                    case .Array(let rvalue):
                        return lvalue == rvalue

                    default:
                        return false
                }

            case .Dictionary(let lvalue):
                switch rhs
                {
                    case .Dictionary(let rvalue):
                        return lvalue == rvalue

                    default:
                        return false
                }

            case .Class(let lvalue):
                switch rhs
                {
                    case .Class(let rvalue):
                        return lvalue == rvalue

                    default:
                        return false
                }

            case .Struct(let lvalue):
                switch rhs
                {
                    case .Struct(let rvalue):
                        return lvalue == rvalue

                    default:
                        return false
                }
        }
    }
}

extension ContainerValue: Hashable
{
    public func hash(into hasher: inout Hasher)
    {
        switch self
        {
            case .Array(let value):
                hasher.combine(value)

            case .Dictionary(let value):
                hasher.combine(value)

            case .Struct(let value):
                hasher.combine(value)

            case .Class(let value):
                hasher.combine(value)
        }
    }
}

extension ContainerValue: Value
{
    public var isNull: Bool
    {
        return false
    }

    public var unwrapped: Any?
    {
        switch self
        {
            case .Array(let value):
                return value

            case .Dictionary(let value):
                return value.dictionary

            case .Class(let value):
                return value

            case .Struct(let value):
                return value
        }
    }
}
