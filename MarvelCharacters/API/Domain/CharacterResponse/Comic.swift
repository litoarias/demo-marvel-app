import Foundation

struct Comic: Codable {
	let available: Int?
	let collectionURI: String?
	let items: [ComicItems]?
	let returned: Int?
}

struct ComicItems: Codable {
	let resourceURI: String?
	let name: String?
}
