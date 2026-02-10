//
//  PasswordGen.swift
//  Navigation
//
//  Created by kubmakk on 14.07.2025.
//
import Foundation

extension String {
    var digits:      String { return "0123456789" }
    var lowercase:   String { return "abcdefghijklmnopqrstuvwxyz" }
    var uppercase:   String { return "ABCDEFGHIJKLMNOPQRSTUVWXYZ" }
    var punctuation: String { return "!\"#$%&'()*+,-./:;<=>?@[\\]^_`{|}~" }
    var letters:     String { return lowercase + uppercase }
    var printable:   String { return digits + letters }

    mutating func replace(at index: Int, with character: Character) {
        var stringArray = Array(self)
        stringArray[index] = character
        self = String(stringArray)
    }
}

class PasswordCracker {
    
    func bruteForce(passwordToUnlock: String, completion: @escaping (String) -> Void) {
        let allowedCharacters: [String] = String().printable.map { String($0) }
        var currentPassword = ""

        while currentPassword != passwordToUnlock {
            currentPassword = generateBruteForce(currentPassword, fromArray: allowedCharacters)
        }
        
        completion(currentPassword)
    }

    private func generateBruteForce(_ string: String, fromArray array: [String]) -> String {
        var str: String = string

        if str.count <= 0 {
            str.append(characterAt(index: 0, array))
        } else {
            str.replace(at: str.count - 1, with: characterAt(index: (indexOf(character: str.last!, array) + 1) % array.count, array))
            if indexOf(character: str.last!, array) == 0 {
                str = String(generateBruteForce(String(str.dropLast()), fromArray: array)) + String(str.last!)
            }
        }
        return str
    }

    private func indexOf(character: Character, _ array: [String]) -> Int {
        return array.firstIndex(of: String(character)) ?? 0
    }

    private func characterAt(index: Int, _ array: [String]) -> Character {
        return index < array.count ? Character(array[index]) : Character("")
    }
    
}
