import XCTest
@testable import Ice

import SwiftHexTools

struct TestStruct: Codable, Equatable
{
    static func == (lhs: TestStruct, rhs: TestStruct) -> Bool
    {
        return lhs.count == rhs.count
    }

    public let count: Int
    public let nested: InnerStruct

    public init(count: Int, nested: InnerStruct)
    {
        self.count = count
        self.nested = nested
    }
}

struct InnerStruct: Codable, Equatable
{
    static func == (lhs: InnerStruct, rhs: InnerStruct) -> Bool
    {
        return lhs.name == rhs.name
    }

    public let name: String

    public init(name: String)
    {
        self.name = name
    }
}

class TestClass: Codable, Equatable
{
    static func == (lhs: TestClass, rhs: TestClass) -> Bool
    {
        return lhs.count == rhs.count
    }

    public let count: Int
    public let nested: InnerClass

    public init(count: Int, nested: InnerClass)
    {
        self.count = count
        self.nested = nested
    }
}

class InnerClass: Codable, Equatable
{
    static func == (lhs: InnerClass, rhs: InnerClass) -> Bool
    {
        return lhs.name == rhs.name
    }

    public let name: String

    public init(name: String)
    {
        self.name = name
    }
}

struct SimpleStruct: Codable, Equatable
{
    static func == (lhs: SimpleStruct, rhs: SimpleStruct) -> Bool
    {
        return lhs.name == rhs.name
    }

    public let name: String

    public init(name: String)
    {
        self.name = name
    }
}

class SimpleClass: Codable, Equatable
{
    static func == (lhs: SimpleClass, rhs: SimpleClass) -> Bool
    {
        return lhs.name == rhs.name
    }

    public let name: String

    public init(name: String)
    {
        self.name = name
    }
}

final class IceTests: XCTestCase
{
    func testEncodeNil() throws
    {
        let input: Bool? = nil
        let encoder = IceEncoder()
        let result = try encoder.encode(input)
        print(result)
    }

    func testEncodeDecodeBool() throws
    {
        let input: Bool = true
        let encoder = IceEncoder()
        let result = try encoder.encode(input)
        print(result)

        let decoder = IceDecoder()
        let output = try decoder.decode(Bool.self, from: result)
        print(output)
        XCTAssertEqual(input, output)
    }

    func testEncodeDecodeString() throws
    {
        let input: String = "test"
        let encoder = IceEncoder()
        let result = try encoder.encode(input)
        print(result)

        let decoder = IceDecoder()
        let output = try decoder.decode(String.self, from: result)
        print(output)
        XCTAssertEqual(input, output)
    }

    func testEncodeDouble() throws
    {
        let input: Double = 1.0
        let encoder = IceEncoder()
        let result = try encoder.encode(input)
        print(result)

        let decoder = IceDecoder()
        let output = try decoder.decode(Double.self, from: result)
        print(output)
        XCTAssertEqual(input, output)
    }

    func testEncodeFloat() throws
    {
        let input: Float = 1.0
        let encoder = IceEncoder()
        let result = try encoder.encode(input)
        print(result)


        let decoder = IceDecoder()
        let output = try decoder.decode(Float.self, from: result)
        print(output)
        XCTAssertEqual(input, output)
    }

    func testEncodeInt() throws
    {
        let input: Int = 1
        let encoder = IceEncoder()
        let result = try encoder.encode(input)
        print(result)


        let decoder = IceDecoder()
        let output = try decoder.decode(Int.self, from: result)
        print(output)
        XCTAssertEqual(input, output)
    }

    func testEncodeInt8() throws
    {
        let input: Int8 = 1
        let encoder = IceEncoder()
        let result = try encoder.encode(input)
        print(result)


        let decoder = IceDecoder()
        let output = try decoder.decode(Int8.self, from: result)
        print(output)
        XCTAssertEqual(input, output)
    }

    func testEncodeInt16() throws
    {
        let input: Int16 = 1
        let encoder = IceEncoder()
        let result = try encoder.encode(input)
        print(result)


        let decoder = IceDecoder()
        let output = try decoder.decode(Int16.self, from: result)
        print(output)
        XCTAssertEqual(input, output)
    }

    func testEncodeInt32() throws
    {
        let input: Int32 = 1
        let encoder = IceEncoder()
        let result = try encoder.encode(input)
        print(result)


        let decoder = IceDecoder()
        let output = try decoder.decode(Int32.self, from: result)
        print(output)
        XCTAssertEqual(input, output)
    }

    func testEncodeInt64() throws
    {
        let input: Int64 = 1
        let encoder = IceEncoder()
        let result = try encoder.encode(input)
        print(result)


        let decoder = IceDecoder()
        let output = try decoder.decode(Int64.self, from: result)
        print(output)
        XCTAssertEqual(input, output)
    }

    func testEncodeUInt() throws
    {
        let input: UInt = 1
        let encoder = IceEncoder()
        let result = try encoder.encode(input)
        print(result)


        let decoder = IceDecoder()
        let output = try decoder.decode(UInt.self, from: result)
        print(output)
        XCTAssertEqual(input, output)
    }

    func testEncodeUInt8() throws
    {
        let input: UInt8 = 1
        let encoder = IceEncoder()
        let result = try encoder.encode(input)
        print(result)


        let decoder = IceDecoder()
        let output = try decoder.decode(UInt8.self, from: result)
        print(output)
        XCTAssertEqual(input, output)
    }

    func testEncodeUInt16() throws
    {
        let input: UInt16 = 1
        let encoder = IceEncoder()
        let result = try encoder.encode(input)
        print(result)


        let decoder = IceDecoder()
        let output = try decoder.decode(UInt16.self, from: result)
        print(output)
        XCTAssertEqual(input, output)
    }

    func testEncodeUInt32() throws
    {
        let input: UInt32 = 1
        let encoder = IceEncoder()
        let result = try encoder.encode(input)
        print(result)


        let decoder = IceDecoder()
        let output = try decoder.decode(UInt32.self, from: result)
        print(output)
        XCTAssertEqual(input, output)
    }

    func testEncodeUInt64() throws
    {
        let input: UInt64 = 1
        let encoder = IceEncoder()
        let result = try encoder.encode(input)
        print(result)


        let decoder = IceDecoder()
        let output = try decoder.decode(UInt64.self, from: result)
        print(output)
        XCTAssertEqual(input, output)
    }

    func testEncodeArrayUInt64Empty() throws
    {
        let input: [UInt64] = []
        let encoder = IceEncoder()
        let result = try encoder.encode(input)
        print(result)

        let decoder = IceDecoder()
        let output = try decoder.decode([UInt64].self, from: result)
        print(output)
        XCTAssertEqual(input, output)
    }

    func testEncodeArrayUInt64One() throws
    {
        let input: [UInt64] = [1]
        let encoder = IceEncoder()
        let result = try encoder.encode(input)
        print(result.hex)

        let decoder = IceDecoder()
        let output = try decoder.decode([UInt64].self, from: result)
        print(output)
        XCTAssertEqual(input, output)
    }

    func testEncodeArrayUInt64Two() throws
    {
        let input: [UInt64] = [1, 2]
        let encoder = IceEncoder()
        let result = try encoder.encode(input)
        print(result)

        let decoder = IceDecoder()
        let output = try decoder.decode([UInt64].self, from: result)
        print(output)
        XCTAssertEqual(input, output)
    }

    func testEncodeDictionaryUInt64UInt64Empty() throws
    {
        let input: [UInt64: UInt64] = [:]
        let encoder = IceEncoder()
        let result = try encoder.encode(input)
        print(result)

        let decoder = IceDecoder()
        let output = try decoder.decode([UInt64: UInt64].self, from: result)
        print(output)
        XCTAssertEqual(input, output)
    }

    func testEncodeDictionaryUInt64UInt64One() throws
    {
        let input: [UInt64: UInt64] = [1: 2]
        let encoder = IceEncoder()
        let result = try encoder.encode(input)
        print(result)

        let decoder = IceDecoder()
        let output = try decoder.decode([UInt64: UInt64].self, from: result)
        print(output)
        XCTAssertEqual(input, output)
    }

    func testEncodeDictionaryUInt64UInt64Two() throws
    {
        let input: [UInt64: UInt64] = [1: 2, 3: 4]
        let encoder = IceEncoder()
        let result = try encoder.encode(input)
        print(result)

        let decoder = IceDecoder()
        let output = try decoder.decode([UInt64: UInt64].self, from: result)
        print(output)
        XCTAssertEqual(input, output)
    }

    func testEncodeStructEmpty() throws
    {
        let input: SimpleStruct = SimpleStruct(name: "test")
        let encoder = IceEncoder()
        let result = try encoder.encode(input)
        print(result.hex)

        let decoder = IceDecoder()
        let output = try decoder.decode(SimpleStruct.self, from: result)
        print(output)
        XCTAssertEqual(input, output)
    }

    func testEncodeStructOne() throws
    {
        let input: TestStruct = TestStruct(count: 1, nested: InnerStruct(name: "test"))
        let encoder = IceEncoder()
        let result = try encoder.encode(input)
        print(result)

        let decoder = IceDecoder()
        let output = try decoder.decode(TestStruct.self, from: result)
        print(output)
        XCTAssertEqual(input, output)
    }

    func testEncodeStructTwo() throws
    {
        let input: TestStruct = TestStruct(count: 1, nested: InnerStruct(name: "test"))
        let encoder = IceEncoder()
        let result = try encoder.encode(input)
        print(result)

        let decoder = IceDecoder()
        let output = try decoder.decode(TestStruct.self, from: result)
        print(output)
        XCTAssertEqual(input, output)
    }

    func testEncodeStructNested() throws
    {
        let input: TestStruct = TestStruct(count: 1, nested: InnerStruct(name: "test"))
        let encoder = IceEncoder()
        let result = try encoder.encode(input)
        print(result)

        let decoder = IceDecoder()
        let output = try decoder.decode(TestStruct.self, from: result)
        print(output)
        XCTAssertEqual(input, output)
    }

    func testEncodeClassEmpty() throws
    {
        let input: TestStruct = TestStruct(count: 0, nested: InnerStruct(name: "test"))
        let encoder = IceEncoder()
        let result = try encoder.encode(input)
        print(result)

        let decoder = IceDecoder()
        let output = try decoder.decode(TestStruct.self, from: result)
        print(output)
        XCTAssertEqual(input, output)
    }

    func testClassStructOne() throws
    {
        let input: TestStruct = TestStruct(count: 0, nested: InnerStruct(name: "test"))
        let encoder = IceEncoder()
        let result = try encoder.encode(input)
        print(result)

        let decoder = IceDecoder()
        let output = try decoder.decode(TestStruct.self, from: result)
        print(output)
        XCTAssertEqual(input, output)
    }

    func testEncodeClassTwo() throws
    {
        let input: TestStruct = TestStruct(count: 0, nested: InnerStruct(name: "test"))
        let encoder = IceEncoder()
        let result = try encoder.encode(input)
        print(result)

        let decoder = IceDecoder()
        let output = try decoder.decode(TestStruct.self, from: result)
        print(output)
        XCTAssertEqual(input, output)
    }

    func testEncodeClassNested() throws
    {
        let input: TestStruct = TestStruct(count: 1, nested: InnerStruct(name: "test"))
        let encoder = IceEncoder()
        let result = try encoder.encode(input)
        print(result)

        let decoder = IceDecoder()
        let output = try decoder.decode(TestStruct.self, from: result)
        print(output)
        XCTAssertEqual(input, output)
    }

    func testEncodeEncodableStructDataEmpty() throws
    {
        let input: TestStruct = TestStruct(count: 0, nested: InnerStruct(name: "test"))
        let encoder = IceEncoder()
        let result = try encoder.encode(input)
        print(result)

        let decoder = IceDecoder()
        let output = try decoder.decode(TestStruct.self, from: result)
        print(output)
        XCTAssertEqual(input, output)
    }

    func testEncodeEncodableArrayUInt8Empty() throws
    {
        let input: [UInt8] = []
        let encoder = IceEncoder()
        let result = try encoder.encode(input)
        print(result)

        let decoder = IceDecoder()
        let output = try decoder.decode([UInt8].self, from: result)
        print(output)
        XCTAssertEqual(input, output)
    }

    func testEncodeEncodableArrayUInt8One() throws
    {
        let input: [UInt8] = [1]
        let encoder = IceEncoder()
        let result = try encoder.encode(input)
        print(result)

        let decoder = IceDecoder()
        let output = try decoder.decode([UInt8].self, from: result)
        print(output)
        XCTAssertEqual(input, output)
    }
}
