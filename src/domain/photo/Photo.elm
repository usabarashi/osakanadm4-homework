module Domain.Photo.Photo exposing (Photo, PhotoImage, PhotoTitle, countUpFavorite, create)

import Domain.Favorite.Favorite as Favorite exposing (Favorite, countUp, create)


type alias Photo =
    { title : PhotoTitle
    , image : PhotoImage
    , favorite : Favorite
    }


init : Photo
init =
    { title = ""
    , image = ""
    , favorite = Favorite.create
    }


create : PhotoTitle -> PhotoImage -> Photo
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


type alias PhotoTitle =
    String


type alias PhotoImage =
    String
