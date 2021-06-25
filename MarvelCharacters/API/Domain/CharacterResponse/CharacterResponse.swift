import Foundation

struct CharacterResponse: Codable {
	let attributionHTML: String?
	let attributionText: String?
	let code: Int?
	let copyright: String?
	let data: CharacterData?
	let etag: String?
	let status: String?
}
