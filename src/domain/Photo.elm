module Domain.Photo exposing (Image, Photo, Title, countUpFavorite, create)

import Domain.Favorite as Favorite exposing (Favorite)


type alias Photo =
    { title : Title
    , image : Image
    , favorite : Favorite
    }


init : Photo
init =
    { title = ""
    , image = ""
    , favorite = Favorite.create
    }


create : Title -> Image -> Photo
create title image =
    { init
        | title = title
        , image = image
    }


countUpFavorite : Photo -> Photo
countUpFavorite photo =
    let
        countUppedFavorite : Favorite
        countUppedFavorite =
            Favorite.countUp photo.favorite
    in
    { photo
        | favorite = countUppedFavorite
    }


type alias Title =
    String


type alias Image =
    String
