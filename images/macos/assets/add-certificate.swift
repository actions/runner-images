import Foundation
import Security

let certInfo: CFDictionary

enum SecurityError: Error {
    case generalError
}

func deleteCertificateFromKeyChain(_ certificateLabel: String) -> Bool {
    let delQuery: [NSString: Any] = [
        kSecClass: kSecClassCertificate,
        kSecAttrLabel: certificateLabel,
    ]
    let delStatus: OSStatus = SecItemDelete(delQuery as CFDictionary)

    return delStatus == errSecSuccess
}

func saveCertificateToKeyChain(_ certificate: SecCertificate, certificateLabel: String) throws {
    SecKeychainSetPreferenceDomain(SecPreferencesDomain.system)
    deleteCertificateFromKeyChain(certificateLabel)

    let setQuery: [NSString: AnyObject] = [
        kSecClass: kSecClassCertificate,
        kSecValueRef: certificate,
        kSecAttrLabel: certificateLabel as AnyObject,
        kSecAttrAccessible: kSecAttrAccessibleWhenUnlocked,
    ]
    let addStatus: OSStatus = SecItemAdd(setQuery as CFDictionary, nil)

    guard addStatus == errSecSuccess else {
        throw SecurityError.generalError
    }

    var status = SecTrustSettingsSetTrustSettings(certificate, SecTrustSettingsDomain.admin, nil)
}

func getCertificateFromString(stringData: String) throws -> SecCertificate {
    if let data = NSData(base64Encoded: stringData, options: NSData.Base64DecodingOptions.ignoreUnknownCharacters) {
        if let certificate = SecCertificateCreateWithData(kCFAllocatorDefault, data) {
            return certificate
        }
    }
    throw SecurityError.generalError
}

if CommandLine.arguments.count > 1 {
    let fileURL = URL(fileURLWithPath: CommandLine.arguments[1])
    do {
        let certData = try Data(contentsOf: fileURL)
        let certificate = SecCertificateCreateWithData(nil, certData as CFData)
        if certificate != nil {
            print("Saving certificate")
            try? saveCertificateToKeyChain(certificate!, certificateLabel: "Test")
        } else {
            print("Certificate can't be read")
        }
    } catch {
        print("Unable to read the file \(CommandLine.arguments[1])")
    }
} else {
    print("Usage: \(CommandLine.arguments[0]) [cert.file]")
}
