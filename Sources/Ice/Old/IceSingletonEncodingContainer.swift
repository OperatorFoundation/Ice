////
////  IceSingletonEncodingContainer.swift
////  
////
////  Created by Dr. Brandon Wiley on 3/12/23.
////
//
//import Foundation
//
//public class IceSingletonEncodingContainer: SingleValueEncodingContainer
//{
//    public var codingPath: [CodingKey]
//
//    let encoder: IceEncoder
//
//    public init(encoder: IceEncoder, codingPath: [CodingKey])
//    {
//        self.encoder = encoder
//        self.codingPath = codingPath
//    }
//
//    public func encodeNil() throws
//    {
//        try self.set(.Leaf(.Basic(.Nil)))
//    }
//
//    public func encode(_ value: Bool) throws
//    {
//        try self.set(.Leaf(.Basic(.Bool(value))))
//    }
//
//    public func encode(_ value: String) throws
//    {
//        try self.set(.Leaf(.String(value)))
//    }
//
//    public func encode(_ value: Double) throws
//    {
//        try self.set(.Leaf(.Basic(.Double(value))))
//    }
//
//    public func encode(_ value: Float) throws
//    {
//        try self.set(.Leaf(.Basic(.Float(value))))
//    }
//
//    public func encode(_ value: Int) throws
//    {
//        try self.set(.Leaf(.Basic(.Int(value))))
//    }
//
//    public func encode(_ value: Int8) throws
//    {
//        try self.set(.Leaf(.Basic(.Int8(value))))
//    }
//
//    public func encode(_ value: Int16) throws
//    {
//        try self.set(.Leaf(.Basic(.Int16(value))))
//    }
//
//    public func encode(_ value: Int32) throws
//    {
//        try self.set(.Leaf(.Basic(.Int32(value))))
//    }
//
//    public func encode(_ value: Int64) throws
//    {
//        try self.set(.Leaf(.Basic(.Int64(value))))
//    }
//
//    public func encode(_ value: UInt) throws
//    {
//        try self.set(.Leaf(.Basic(.UInt(value))))
//    }
//
//    public func encode(_ value: UInt8) throws
//    {
//        try self.set(.Leaf(.Basic(.UInt8(value))))
//    }
//
//    public func encode(_ value: UInt16) throws
//    {
//        try self.set(.Leaf(.Basic(.UInt16(value))))
//    }
//
//    public func encode(_ value: UInt32) throws
//    {
//        try self.set(.Leaf(.Basic(.UInt32(value))))
//    }
//
//    public func encode(_ value: UInt64) throws
//    {
//        try self.set(.Leaf(.Basic(.UInt64(value))))
//    }
//
//    public func encode<T>(_ value: T) throws where T: Encodable
//    {
//        // FIXME - how?
//    }
//
//    func set(_ value: IcedValue) throws
//    {
//        if let container = self.encoder.value
//        {
//            switch container
//            {
//                case .Leaf(_):
//                    throw IceSingletonEncodingContainerError.incompatibleEncoderValue(container)
//
//                case .Branch(_):
//                    self.encoder.value = try put(container: container, path: self.codingPath, value: value)
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
//public enum IceSingletonEncodingContainerError: Error
//{
//    case badCodingPath([CodingKey])
//    case incompatibleEncoderValue(IcedValue)
//}
