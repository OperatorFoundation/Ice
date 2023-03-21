//
//  File.swift
//  
//
//  Created by Dr. Brandon Wiley on 3/21/23.
//

import Foundation

import Datable

public func data(basic: BasicValue) -> Data
{
    return basic.data
}

public func basic(data: Data) -> BasicValue?
{
    return BasicValue(data: data)
}

func dataToUInt8(_ data: Data) -> UInt8?
{
    guard data.count == 1 else
    {
        return nil
    }

    return UInt8(data: data)
}

func dataToUInt16(_ data: Data) -> UInt16?
{
    guard data.count == 2 else
    {
        return nil
    }

    return UInt16(data: data)
}

func dataToUInt32(_ data: Data) -> UInt32?
{
    guard data.count == 4 else
    {
        return nil
    }

    return UInt32(data: data)
}

func dataToUInt64(_ data: Data) -> UInt64?
{
    guard data.count == 8 else
    {
        return nil
    }

    return UInt64(data: data)
}

extension BasicValue: MaybeDatable
{
    public init?(data: Data)
    {
        guard data.count > 0 else
        {
            return nil
        }

        let typeData = data[0..<1]
        let type = BasicType(data: typeData)
        switch type
        {
            case .Nil:
                guard data.count == 1 else
                {
                    return nil
                }

                self = .Nil
                return

            case .Bool:
                guard data.count == 2 else
                {
                    return nil
                }

                switch data[1]
                {
                    case 1:
                        self = .Bool(true)
                        return

                    case 0:
                        self = .Bool(false)
                        return

                    default:
                        return nil
                }

            case .Float: // FIXME
//                guard data.count == 32 else
//                {
//                    return nil
//                }
//
//                let value = Float(data: data[1...])
//                self = .Float(value)
//                return
                return nil

            case .Double: // FIXME
                return nil

            case .Int: // FIXME
                return nil

            case .Int8: // FIXME
                return nil

            case .Int16: // FIXME
                return nil

            case .Int32: // FIXME
                return nil

            case .Int64: // FIXME
                return nil

            case .UInt: // FIXME
                return nil

            case .UInt8:
                guard let value = dataToUInt8(data[1...]) else
                {
                    return nil
                }
                self = .UInt8(value)
                return

            case .UInt16:
                guard let value = dataToUInt16(data[1...]) else
                {
                    return nil
                }
                self = .UInt16(value)
                return

            case .UInt32:
                guard let value = dataToUInt32(data[1...]) else
                {
                    return nil
                }
                self = .UInt32(value)
                return

            case .UInt64: // FIXME
                guard let value = dataToUInt64(data[1...]) else
                {
                    return nil
                }
                self = .UInt64(value)
                return

            default:
                return nil
        }
    }

    public var data: Data
    {
        switch self
        {
            case .Nil:
                let typeData = BasicType.Nil.data
                return typeData

            case .Bool(let value):
                let typeData = BasicType.Bool.data
                if value
                {
                    return typeData + Data(repeating: 1, count: 1)
                }
                else
                {
                    return typeData + Data(repeating: 1, count: 0)
                }

            case .Float(let value):
                let typeData = BasicType.Float.data
                return typeData + value.data

            case .Double(let value):
                let typeData = BasicType.Double.data
                return typeData + value.data

            case .Int(let value):
                let typeData = BasicType.Int.data
                return typeData + value.data

            case .Int8(let value):
                let typeData = BasicType.Int8.data
                return typeData + value.data

            case .Int16(let value):
                let typeData = BasicType.Int16.data
                return typeData + value.data

            case .Int32(let value):
                let typeData = BasicType.Int32.data
                return typeData + value.data

            case .Int64(let value):
                let typeData = BasicType.Int64.data
                return typeData + value.data

            case .UInt(let value):
                let typeData = BasicType.UInt.data
                return typeData + value.data

            case .UInt8(let value):
                let typeData = BasicType.UInt8.data
                return typeData + value.data

            case .UInt16(let value):
                let typeData = BasicType.UInt16.data
                return typeData + value.data

            case .UInt32(let value):
                let typeData = BasicType.UInt32.data
                return typeData + value.data

            case .UInt64(let value):
                let typeData = BasicType.UInt64.data
                return typeData + value.data
        }
    }
}
