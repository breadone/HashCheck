import Foundation
import CommonCrypto
import ArgumentParser

@main
struct hashcheck: ParsableCommand {
    @Argument var file: String
    @Argument var hash: String
    
    @Option(name: [.long, .customLong("alg")], help: "If you only want to compare a specific type of hash: md5, sha256")
    var algorithm: Algorithm
    
    func run() throws {
        let fileData = try Data(contentsOf: URL(string: "file://\(file)")!)  // read file into data

        sha256(fileData: fileData) // try sha256
    }

    func sha256(fileData data: Data) {
        let digest = UnsafeMutablePointer<UInt8>.allocate(capacity: algorithm.digestLength)  // preallocate result data pointer
        defer { digest.deallocate() }  // dealloc pointer once finished
        
        withUnsafeBytes(of: data) { (buffer) -> Void in
            CC_SHA256(buffer.baseAddress!, CC_LONG(buffer.count), digest)
        }
        
        print("HASH: ", String(data: Data(bytes: digest, count: algorithm.digestLength), encoding: .utf8) ?? "nop")
    }
    
}

public enum Algorithm: ExpressibleByArgument {
    public init?(argument: String) {
        switch argument {
        case "md5":
            self = .md5
            
        case "sha256":
            self = .sha256
            
        default:  // break
            self = .unknown
        }
    }
    
    case md5, sha256
    case unknown

    var digestLength: Int {
        switch self {
        case .md5:
            return Int(CC_MD5_DIGEST_LENGTH)
        case .sha256:
            return Int(CC_SHA256_DIGEST_LENGTH)

        case .unknown:
            return 0
        }
    }
}
