////
////  IceKeyedEncodingContainer.swift
////  Ice
////
////  Created by Dr. Brandon Wiley on 3/12/23.
////
//
//import Foundation
//
//public class IceKeyedEncodingContainer<K>: KeyedEncodingContainerProtocol where K: CodingKey
//{
//    public typealias Key = K
//
//    public var codingPath: [CodingKey]
//
//    let encoder: IceEncoder
//    let keyedBy: Key.Type
//
//    public init(encoder: IceEncoder, codingPath: [CodingKey], keyedBy: Key.Type)
//    {
//        self.encoder = encoder
//        self.codingPath = codingPath
//        self.keyedBy = keyedBy
//    }
//
//    public func superEncoder() -> Encoder
//    {
//        return self.encoder
//    }
//
//    public func encodeNil(forKey key: K) throws
//    {
//        try self.set(.Leaf(.Basic(.Nil)), forKey: key)
//    }
//
//    public func encode(_ value: Bool, forKey key: K) throws
//    {
//        try self.set(.Leaf(.Basic(.Bool(value))), forKey: key)
//    }
//
//    public func encode(_ value: String, forKey key: K) throws
//    {
//        try self.set(.Leaf(.String(value)), forKey: key)
//    }
//
//    public func encode(_ value: Double, forKey key: K) throws
//    {
//        try self.set(.Leaf(.Basic(.Double(value))), forKey: key)
//    }
//
//    public func encode(_ value: Float, forKey key: K) throws
//    {
//        try self.set(.Leaf(.Basic(.Float(value))), forKey: key)
//    }
//
//    public func encode(_ value: Int, forKey key: K) throws
//    {
//        try self.set(.Leaf(.Basic(.Int(value))), forKey: key)
//    }
//
//    public func encode(_ value: Int8, forKey key: K) throws
//    {
//        try self.set(.Leaf(.Basic(.Int8(value))), forKey: key)
//    }
//
//    public func encode(_ value: Int16, forKey key: K) throws
//    {
//        try self.set(.Leaf(.Basic(.Int16(value))), forKey: key)
//    }
//
//    public func encode(_ value: Int32, forKey key: K) throws
//    {
//        try self.set(.Leaf(.Basic(.Int32(value))), forKey: key)
//    }
//
//    public func encode(_ value: Int64, forKey key: K) throws
//    {
//        try self.set(.Leaf(.Basic(.Int64(value))), forKey: key)
//    }
//
//    public func encode(_ value: UInt, forKey key: K) throws
//    {
//        try self.set(.Leaf(.Basic(.UInt(value))), forKey: key)
//    }
//
//    public func encode(_ value: UInt8, forKey key: K) throws
//    {
//        try self.set(.Leaf(.Basic(.UInt8(value))), forKey: key)
//    }
//
//    public func encode(_ value: UInt16, forKey key: K) throws
//    {
//        try self.set(.Leaf(.Basic(.UInt16(value))), forKey: key)
//    }
//
//    public func encode(_ value: UInt32, forKey key: K) throws
//    {
//        try self.set(.Leaf(.Basic(.UInt32(value))), forKey: key)
//    }
//
//    public func encode(_ value: UInt64, forKey key: K) throws
//    {
//        try self.set(.Leaf(.Basic(.UInt64(value))), forKey: key)
//    }
//
//    public func encode<T>(_ value: T, forKey key: K) throws where T : Encodable
//    {
//        throw IceKeyedEncodingContainerError.unimplemented // FIXME
//    }
//
//    public func nestedContainer<NestedKey>(keyedBy keyType: NestedKey.Type, forKey key: K) -> KeyedEncodingContainer<NestedKey> where NestedKey: CodingKey
//    {
//        let container = IceKeyedEncodingContainer<NestedKey>(encoder: self.encoder, codingPath: self.codingPath + [key], keyedBy: keyType)
//        return KeyedEncodingContainer<NestedKey>(container)
//    }
//
//    public func nestedUnkeyedContainer(forKey key: K) -> UnkeyedEncodingContainer
//    {
//        return IceUnkeyedEncodingContainer(encoder: self.encoder, codingPath: self.codingPath + [key])
//    }
//
//    public func superEncoder(forKey key: K) -> Encoder
//    {
//        return self.encoder // FIXME
//    }
//
//    func set(_ value: IcedValue, forKey key: K) throws
//    {
//        if let container = self.encoder.value
//        {
//            switch container
//            {
//                case .Leaf(_):
//                    throw IceSingletonEncodingContainerError.incompatibleEncoderValue(container)
//
//                case .Branch(_):
//                    self.encoder.value = try put(container: container, path: self.codingPath + [key], value: value)
//            }
//        }
//        else
//        {
//            if self.codingPath.isEmpty
//            {
//                self.encoder.value = value
//            }
//            else
//            {
//                throw IceSingletonEncodingContainerError.badCodingPath(self.codingPath)
//            }
//        }
//    }
//}
//
//public enum IceKeyedEncodingContainerError: Error
//{
//    case unimplemented
//}
