//
//  Post.swift
//  Netology_IB_Instruments
//
//  Created by ALEKSANDR POZDNIKIN on 30.03.2022.
//

import UIKit

public struct Post: Equatable {
    public let author: String
    public let descript: String
    public let image: String
    public let likes: Int64
    public let views: Int64
    
    var keyedValues: [String: Any] {
        return [
            "author": self.author,
            "descript": self.descript,
            "image": self.image,
            "likes": self.likes,
            "views": self.views
            //"isFavorite": self.isFavorite
        ]
    }
    init(author: String, descript: String, image: String, likes: Int64, views: Int64) {
        self.author = author
        self.descript = descript
        self.image = image
        self.likes = likes
        self.views = views
    }
    init(postCoreDataModel: PostCoreDataModel) {
        self.author = postCoreDataModel.author ?? ""
        self.descript = postCoreDataModel.descript ?? ""
        self.image = postCoreDataModel.image ?? ""
        self.likes = postCoreDataModel.likes
        self.views = postCoreDataModel.views
        //self.isFavorite = postCoreDataModel.isFavorite
    }
}
let postFirst = Post(author: NSLocalizedString("Zoo", comment: "Post Author"), descript: NSLocalizedString("The rules of life for a big panda are: if you want to sleep, sleep, if you want to eat, eat, and if there is a tire hanging in the enclosure, then it must be torn off,” says the zoo employee. And Ruyi always follows these three rules.", comment: "Post Description"), image: "panda", likes: 50, views: 100)
let postSecond = Post(author: NSLocalizedString("Hi-News", comment: "Post Author"), descript: NSLocalizedString("After the advent of Elon Musk's SpaceX, space has become more and more interesting for mankind. All these plans for interplanetary expeditions, the colonization of the red planet are miracles, and nothing more. Let's assume that the future has come, and fantastic stories have become a reality. You left the house and decided to fly for the period of quarantine to Mars. Open the navigator and plot a route to Mars to the colony of Elon Musk. How much do you think you have to fly to get there? Let's figure it out.", comment: "Post Description"), image: "redPlanet", likes: 10, views: 200)
let postThird = Post(author: NSLocalizedString("Kinopoisk", comment: "Post Author"), descript: NSLocalizedString("In one tram depot there lived two trams - a mother and a son. From early morning until late at night they traveled around the city, filling it with joyful chimes and vigorous clatter of wheels, and were happy. But nothing in life lasts forever.", comment: "Post Description"), image: "twoTrains", likes: 1000, views: 20000)
let postFourth = Post(author: NSLocalizedString("Radio Jazz", comment: "Post Author"), descript: NSLocalizedString("Jazz, as is commonly believed, is intellectual music. Not accessible to everyone. With a high entrance threshold. A well-known contradiction: in order to listen to jazz, you need to understand it, but in order to make it out, you need to know what exactly to listen to! There are jazz tracks that catch , captivate and do not let go. We have chosen the seven most contagious. Take 5, Song for My Father, My Favorite Things, Girl from Ipanema, Waltz for Debby, Autumn Leaves, So What.", comment: "Post Description"), image: "jazz", likes: 20, views: 50)

/*
 "Правила жизни большой панды: если хочется спать — спи, если хочется есть — ешь, а если в вольере висит шина, то ее надо обязательно оторвать, — говорит сотрудник зоопарка. — И Жуи всегда следует этим трем правилам."
 "После появления SpaceX Илона Маска космос стал всё больше интересовать человечество. Все эти планы по межпланетным экспедициям, колонизация красной планеты — чудеса, да и только. Давайте предположим, что будущее наступило, а фантастические рассказы стали реальностью. Вы вышли из дома и решили полететь на время карантина на Марс. Открываете навигатор и прокладываете маршрут до Марса в колонию Илона Маска. Как вам кажется, сколько придется лететь, чтобы туда добраться? Давайте разберёмся."
 "В одном трамвайном депо жили два трамвая - мать и сын. С раннего утра до позднего вечера они колесили по городу, наполняя его радостным перезвоном и бодрым стуком колес, и были счастливы. Но ничто в жизни не вечно."
 "Джаз, как принято считать — «интеллектуальная» музыка. Не всем доступная. С высоким входным порогом. Известное противоречие: чтобы слушать джаз, нужно в нем разбираться, но чтобы разобрать — нужно знать, что именно слушать! Есть джазовые треки, которые цепляют, пленяют и не отпускают.Мы выбрали семь самых «заразных». Take 5, Song for My Father, My Favorite Things, Girl from Ipanema, Waltz for Debby, Autumn Leaves, So What."
 */
