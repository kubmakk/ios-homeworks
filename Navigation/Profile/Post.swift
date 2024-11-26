import Foundation

struct Post {
    let author: String
    let description: String
    let image: String
    let likes: Int
    let views: Int
}

extension Post {
    
    static func make() -> [Post] {
        [
            Post(author: "Дмитрий",
                 description: "Магазин работает с 09:00 до 21:00, я просто в шоке от такой новости",
                 image: "shop",
                 likes: 45,
                 views: 120
                ),
            Post(author: "Александр",
                 description: "Попил вкусный Бабл тиа в мое любимом ресторане!",
                 image: "bubble_tea",
                 likes: 78,
                 views: 200
                ),
            Post(author: "Степа",
                 description: "Xiaomi релизнули свою AI. Ни стыда, ни отличий от Apple Intelligence",
                 image: "appleNews",
                 likes: 65,
                 views: 150
                ),
            Post(author: "Саша",
                 description: "Кто поможет с домашкой? А то мало ли сделал ошибки тут( ",
                 image: "news",
                 likes: 89,
                 views: 230
                )
        ]
    }
}
