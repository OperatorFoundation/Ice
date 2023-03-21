import XCTest
@testable import Ice

final class IceTests: XCTestCase
{
    func testEncodeNil() throws
    {
        let input: Bool? = nil
        let encoder = IceEncoder()
        let result = try encoder.encode(input)
        print(result)
    }

    func testEncodeBool() throws
    {
        let input: Bool = true
        let encoder = IceEncoder()
        let result = try encoder.encode(input)
        print(result)
    }

    func testEncodeString() throws
    {
        let input: String = "test"
        let encoder = IceEncoder()
        let result = try encoder.encode(input)
        print(result)
    }

    func testEncodeDouble() throws
    {
        let input: Double = 1.0
        let encoder = IceEncoder()
        let result = try encoder.encode(input)
        print(result)
    }

    func testEncodeFloat() throws
    {
        let input: Float = 1.0
        let encoder = IceEncoder()
        let result = try encoder.encode(input)
        print(result)
    }

    func testEncodeInt() throws
    {
        let input: Int = 1
        let encoder = IceEncoder()
        let result = try encoder.encode(input)
        print(result)
    }

    func testEncodeInt8() throws
    {
        let input: Int8 = 1
        let encoder = IceEncoder()
        let result = try encoder.encode(input)
        print(result)
    }

    func testEncodeInt16() throws
    {
        let input: Int16 = 1
        let encoder = IceEncoder()
        let result = try encoder.encode(input)
        print(result)
    }

    func testEncodeInt32() throws
    {
        let input: Int32 = 1
        let encoder = IceEncoder()
        let result = try encoder.encode(input)
        print(result)
    }

    func testEncodeInt64() throws
    {
        let input: Int64 = 1
        let encoder = IceEncoder()
        let result = try encoder.encode(input)
        print(result)
    }

    func testEncodeUInt() throws
    {
        let input: UInt = 1
        let encoder = IceEncoder()
        let result = try encoder.encode(input)
        print(result)
    }

    func testEncodeUInt8() throws
    {
        let input: UInt8 = 1
        let encoder = IceEncoder()
        let result = try encoder.encode(input)
        print(result)
    }

    func testEncodeUInt16() throws
    {
        let input: UInt16 = 1
        let encoder = IceEncoder()
        let result = try encoder.encode(input)
        print(result)
    }

    func testEncodeUInt32() throws
    {
        let input: UInt32 = 1
        let encoder = IceEncoder()
        let result = try encoder.encode(input)
        print(result)
    }

    func testEncodeUInt64() throws
    {
        let input: UInt64 = 1
        let encoder = IceEncoder()
        let result = try encoder.encode(input)
        print(result)
    }

    func testEncodeEncodableStructDataEmpty() throws
    {
        let input: Data = Data()
        let encoder = IceEncoder()
        let result = try encoder.encode(input)
        print(result)
    }

    func testEncodeEncodableArrayUInt8Empty() throws
    {
        let input: [UInt8] = []
        let encoder = IceEncoder()
        let result = try encoder.encode(input)
        print(result)
    }

    func testEncodeEncodableArrayUInt8One() throws
    {
        let input: [UInt8] = [1]
        let encoder = IceEncoder()
        let result = try encoder.encode(input)
        print(result)
    }
}
