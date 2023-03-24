//
//  File.swift
//  
//
//  Created by Dr. Brandon Wiley on 3/21/23.
//

import Foundation

import Datable
import SwiftHexTools

extension IcedValue: MaybeDatable
{
    public init?(data: Data)
    {
        guard data.count > 0 else
        {
            return nil
        }

        let typeData = Data(data[0..<1])
        let type = IcedType(data: typeData)
        switch type
        {
            case .Leaf:
                guard data.count > 1 else
                {
                    return nil
                }

                let rest = Data(data[1...])
                guard let value = LeafValue(data: rest) else
                {
                    return nil
                }

                self = .Leaf(value)
                return

            case .Branch:
                guard data.count > 1 else
                {
                    return nil
                }

                guard let value = ContainerValue(data: Data(data[1...])) else
                {
                    return nil
                }

                self = .Branch(value)
                return

            default:
                return nil
        }
    }

    public var data: Data
    {
        switch self
        {
            case .Branch(let value):
                let typeData = IcedType.Branch.data
                return typeData + value.data

            case .Leaf(let value):
                let typeData = IcedType.Leaf.data
                return typeData + value.data
        }
    }
}

extension ArrayValue: MaybeDatable
{
    public init?(data: Data)
    {
        var results: [IcedValue] = []

        guard data.count >= 8 else
        {
            return nil
        }

        // Read the first part of the header, which has the count of items
        let numItemsData = Data(data[0..<8])
        var rest = Data(data[8...])
        let uint64 = UInt64(data: numItemsData)
        let numItems = Int(uint64)

        let headerSize = numItems * 8
        guard rest.count >= headerSize else // Check if there is room for the element size header
        {
            return nil
        }

        var header = Data(rest[..<headerSize])
        rest = Data(rest[headerSize...])

        while rest.count > 0
        {
            let nextLengthData = Data(header[0..<8])
            header = Data(header[8...])
            let nextLength64 = UInt64(data: nextLengthData)
            let nextLength = Int(nextLength64)

            guard rest.count >= nextLength else
            {
                return nil
            }

            let nextEntryData = Data(rest[..<nextLength])
            rest = Data(rest[nextLength...])

            guard let entry = IcedValue(data: nextEntryData) else
            {
                return nil
            }
            results.append(entry)
        }

        self.init(elements: results)
    }

    public var data: Data
    {
        let datas = self.elements.map { $0.data }
        let dataBlock = datas.reduce(Data(), (+))
        let lengths = datas.map { $0.count }
        let lengthDatas = lengths.map { $0.data }.reduce(Data(), (+))
        let numItems = lengths.count
        let numItemsData = numItems.data

        return numItemsData + lengthDatas + dataBlock
    }
}

extension ContainerValue: MaybeDatable
{
    public var data: Data
    {
        switch self
        {
            case .Array(let value):
                let typeData = ContainerType.Array.data
                return typeData + value.data

            case .Dictionary(let value):
                let typeData = ContainerType.Dictionary.data
                return typeData + value.data

            case .Struct(let value):
                let typeData = ContainerType.Struct.data
                return typeData + value.data

            case .Class(let value):
                let typeData = ContainerType.Class.data
                return typeData + value.data
        }
    }

    public init?(data: Data)
    {
        guard data.count > 0 else
        {
            return nil
        }

        let typeData = Data(data[0..<1])
        let type = ContainerType(data: typeData)
        switch type
        {
            case .Array:
                guard data.count > 1 else
                {
                    return nil
                }

                guard let value = array(data: Data(data[1...])) else
                {
                    return nil
                }

                self = .Array(value)
                return

            case .Dictionary:
                guard data.count > 1 else
                {
                    return nil
                }

                guard let value = dictionary(data: Data(data[1...])) else
                {
                    return nil
                }

                self = .Dictionary(value)
                return

            case .Struct:
                guard data.count > 1 else
                {
                    return nil
                }

                guard let value = structValue(data: Data(data[1...])) else
                {
                    return nil
                }

                self = .Struct(value)
                return

            case .Class:
                guard data.count > 1 else
                {
                    return nil
                }

                guard let value = classValue(data: Data(data[1...])) else
                {
                    return nil
                }

                self = .Class(value)
                return

            default:
                return nil
        }
    }
}

extension DictionaryValue: MaybeDatable
{
    public init?(data: Data)
    {
        var results: [DictionaryEntryValue] = []

        guard data.count >= 8 else
        {
            return nil
        }

        // Read the first part of the header, which has the count of items
        let numEntriesData = Data(data[0..<8])
        var rest = Data(data[8...])
        let uint64 = UInt64(data: numEntriesData)
        let numEntries = Int(uint64)

        let headerSize = numEntries * 8 * 2
        guard rest.count >= headerSize else // Check if there is room for the element size header
        {
            return nil
        }

        var header = Data(rest[..<headerSize])
        rest = Data(rest[headerSize...])

        while header.count > 0
        {
            var nextLengthData = Data(header[0..<8])
            header = Data(header[8...])
            var nextLength64 = UInt64(data: nextLengthData)
            var nextLength = Int(nextLength64)

            guard rest.count >= nextLength else
            {
                return nil
            }

            let nextKeyData = Data(rest[..<nextLength])
            rest = Data(rest[nextLength...])

            nextLengthData = Data(header[0..<8])
            header = Data(header[8...])
            nextLength64 = UInt64(data: nextLengthData)
            nextLength = Int(nextLength64)

            guard rest.count >= nextLength else
            {
                return nil
            }

            let nextValueData = Data(rest[..<nextLength])
            rest = Data(rest[nextLength...])

            guard let key = IcedValue(data: nextKeyData) else
            {
                return nil
            }

            guard let value = IcedValue(data: nextValueData) else
            {
                return nil
            }

            let entry = DictionaryEntryValue(key: key, value: value)
            results.append(entry)
        }

        self.entries = results
    }

    public var data: Data
    {
        let datas = self.entries.flatMap { return [$0.key.data, $0.value.data] }
        let dataBlock = datas.reduce(Data(), (+))
        let lengths = datas.map { UInt64($0.count) }
        let lengthDatas = lengths.map { $0.data }
        let lengthBlock = lengthDatas.reduce(Data(), (+))
        let numEntries = UInt64(self.entries.count)
        let numEntriesData = numEntries.data

        return numEntriesData + lengthBlock + dataBlock
    }
}

extension StructValue: MaybeDatable
{
    public init?(data: Data)
    {
        var results: [FieldValue] = []

        guard data.count >= 8 else
        {
            return nil
        }

        // Read the first part of the header, which has the count of items
        let lengthData = Data(data[0..<8])
        var rest = Data(data[8...])
        let uint64 = UInt64(data: lengthData)
        let length = Int(uint64)

        let headerSize = length * 8 * 2
        guard rest.count >= headerSize else // Check if there is room for the element size header
        {
            return nil
        }

        var header = Data(rest[..<headerSize])
        rest = Data(rest[headerSize...])

        while rest.count > 0
        {
            var nextLengthData = Data(header[0..<8])
            header = Data(header[8...])
            var nextLength64 = UInt64(data: nextLengthData)
            var nextLength = Int(nextLength64)

            guard rest.count >= nextLength else
            {
                return nil
            }

            let nextKeyData = Data(rest[..<nextLength])
            rest = Data(rest[nextLength...])

            nextLengthData = Data(header[0..<8])
            header = Data(header[8...])
            nextLength64 = UInt64(data: nextLengthData)
            nextLength = Int(nextLength64)

            guard rest.count >= nextLength else
            {
                return nil
            }

            let nextValueData = Data(rest[..<nextLength])
            rest = Data(rest[nextLength...])

            let name = nextKeyData.string

            guard let value = IcedValue(data: nextValueData) else
            {
                return nil
            }

            let entry = FieldValue(name: name, value: value)
            results.append(entry)
        }

        self.fields = results
    }

    public var data: Data
    {
        let datas = self.fields.flatMap { return [$0.name.data, $0.value.data] }
        let dataBlock = datas.reduce(Data(), (+))
        let lengths = datas.map { $0.count }
        let lengthDatas = lengths.map { $0.data }.reduce(Data(), (+))
        let totalLength = lengths.reduce(0, (+))
        let totalLengthData = totalLength.data

        return totalLengthData + lengthDatas + dataBlock
    }
}

extension ClassValue: MaybeDatable
{
    public init?(data: Data)
    {
        var results: [FieldValue] = []

        guard data.count >= 8 else
        {
            return nil
        }

        // Read the first part of the header, which has the count of items
        let lengthData = Data(data[0..<8])
        var rest = Data(data[8...])
        let uint64 = UInt64(data: lengthData)
        let length = Int(uint64)

        let headerSize = length * 8 * 2
        guard rest.count >= headerSize else // Check if there is room for the element size header
        {
            return nil
        }

        var header = Data(rest[..<headerSize])
        rest = Data(rest[headerSize...])

        while rest.count > 0
        {
            var nextLengthData = Data(header[0..<8])
            header = Data(header[8...])
            var nextLength64 = UInt64(data: nextLengthData)
            var nextLength = Int(nextLength64)

            guard rest.count >= nextLength else
            {
                return nil
            }

            let nextKeyData = Data(rest[..<nextLength])
            rest = Data(rest[nextLength...])

            nextLengthData = Data(header[0..<8])
            header = Data(header[8...])
            nextLength64 = UInt64(data: nextLengthData)
            nextLength = Int(nextLength64)

            guard rest.count >= nextLength else
            {
                return nil
            }

            let nextValueData = Data(rest[..<nextLength])
            rest = Data(rest[nextLength...])

            let name = nextKeyData.string

            guard let value = IcedValue(data: nextValueData) else
            {
                return nil
            }

            let entry = FieldValue(name: name, value: value)
            results.append(entry)
        }

        self.fields = results
    }

    public var data: Data
    {
        let datas = self.fields.flatMap { return [$0.name.data, $0.value.data] }
        let dataBlock = datas.reduce(Data(), (+))
        let lengths = datas.map { $0.count }
        let lengthDatas = lengths.map { $0.data }.reduce(Data(), (+))
        let totalLength = lengths.reduce(0, (+))
        let totalLengthData = totalLength.data

        return totalLengthData + lengthDatas + dataBlock
    }
}

extension BasicValue: MaybeDatable
{
    public init?(data: Data)
    {
        guard data.count > 0 else
        {
            return nil
        }

        let typeData = Data(data[0..<1])
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

            case .Float:
                guard let value = dataToFloat(Data(data[1...])) else
                {
                    return nil
                }

                self = .Float(value)
                return

            case .Double: // FIXME
                guard let value = dataToDouble(Data(data[1...])) else
                {
                    return nil
                }

                self = .Double(value)
                return

            case .Int: // FIXME // Ints with a platform-specific bitwidth are serialized as 64 bits
                guard let value = dataToInt64(Data(data[1...])) else
                {
                    return nil
                }
                self = .Int(int64ToInt(value))
                return

            case .Int8:
                guard let value = dataToInt8(Data(data[1...])) else
                {
                    return nil
                }
                self = .Int8(value)
                return

            case .Int16:
                guard let value = dataToInt16(Data(data[1...])) else
                {
                    return nil
                }
                self = .Int16(value)
                return

            case .Int32:
                guard let value = dataToInt32(Data(data[1...])) else
                {
                    return nil
                }
                self = .Int32(value)
                return

            case .Int64: // FIXME
                guard let value = dataToInt64(Data(data[1...])) else
                {
                    return nil
                }
                self = .Int64(value)
                return

            case .UInt:
                guard let value = dataToUInt64(Data(data[1...])) else
                {
                    return nil
                }
                self = .UInt(uint64ToUInt(value))
                return

            case .UInt8:
                guard let value = dataToUInt8(Data(data[1...])) else
                {
                    return nil
                }
                self = .UInt8(value)
                return

            case .UInt16:
                guard let value = dataToUInt16(Data(data[1...])) else
                {
                    return nil
                }
                self = .UInt16(value)
                return

            case .UInt32:
                guard let value = dataToUInt32(Data(data[1...])) else
                {
                    return nil
                }
                self = .UInt32(value)
                return

            case .UInt64: // FIXME
                guard let value = dataToUInt64(Data(data[1...])) else
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
                return typeData + intToInt64(value).data // Ints with a platform-specific bitwidth are serialized as 64 bits

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
                let typeData = BasicType.UInt.data // UInts with a platform-specific bitwidth are serialized as 64 bits
                return typeData + uintToUInt64(value).data

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

extension LeafValue: MaybeDatable
{
    public init?(data: Data)
    {
        guard data.count > 0 else
        {
            return nil
        }

        print(data.hex)

        let typeData = Data(data[0..<1])
        let type = LeafType(data: typeData)
        switch type
        {
            case .Basic:
                guard let value = BasicValue(data: Data(data[1...])) else
                {
                    return nil
                }

                self = .Basic(value)
                return

            case .String:
                let value = Data(data[1...]).string
                self = .String(value)
                return

            default:
                return nil
        }
    }

    public var data: Data
    {
        switch self
        {
            case .Basic(let value):
                let typedData = LeafType.Basic.data
                return typedData + value.data

            case .String(let value):
                let typedData = LeafType.String.data
                return typedData + value.data
        }
    }
}

