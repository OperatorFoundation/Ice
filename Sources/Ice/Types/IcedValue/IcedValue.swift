//
//  IcedValue.swift
//  
//
//  Created by Dr. Brandon Wiley on 3/13/23.
//

import Foundation

import Datable
import PotentCodables

public enum IcedValue: Codable
{
    case Branch(ContainerValue)
    case Leaf(LeafValue)
}

extension IcedValue: Equatable
{
    public static func == (lhs: IcedValue, rhs: IcedValue) -> Bool
    {
        switch lhs
        {
            case .Branch(let lbranch):
                switch rhs
                {
                    case .Branch(let rbranch):
                        return lbranch == rbranch

                    default:
                        return false
                }

            case .Leaf(let lleaf):
                switch rhs
                {
                    case .Leaf(let rleaf):
                        return lleaf == rleaf

                    default:
                        return false
                }
        }
    }
}

extension IcedValue: Value
{
    public var isNull: Bool
    {
        switch self
        {
            case .Branch(let branchValue):
                return branchValue.isNull

            case .Leaf(let leafValue):
                switch leafValue
                {
                    case .Basic(let value):
                        return value.isNull

                    case .String(_):
                        return false
                }
        }
    }

    public var unwrapped: Any?
    {
        switch self
        {
            case .Branch(let containerValue):
                switch containerValue
                {
                    case .Array(let value):
                        return value

                    case .Dictionary(let value):
                        return value

                    case .Class(let value):
                        return value

                    case .Struct(let value):
                        return value
                }

            case .Leaf(let leafValue):
                switch leafValue
                {
                    case .Basic(let basicValue):
                        switch basicValue
                        {
                            case .Nil:
                                return nil

                            case .Float(let value):
                                return value

                            case .Bool(let value):
                                return value

                            case .Double(let value):
                                return value

                            case.Int(let value):
                                return value

                            case.Int8(let value):
                                return value

                            case.Int16(let value):
                                return value

                            case.Int32(let value):
                                return value

                            case.Int64(let value):
                                return value

                            case.UInt(let value):
                                return value

                            case.UInt8(let value):
                                return value

                            case.UInt16(let value):
                                return value

                            case.UInt32(let value):
                                return value

                            case.UInt64(let value):
                                return value
                        }

                    case .String(let value):
                        return value
                }
        }
    }
}

public enum IcedValueError: Error
{
    case outOfBounds(Int)
    case typeMismatch
    case badSelector
}
