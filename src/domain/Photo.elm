module Domain.Photo exposing (Image, Msg(..), Photo, Title, create, update)

import Domain.Favorite as Favorite exposing (Favorite)



-- Model


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



-- Update


type Msg
    = -- Infrastructure case
      -- View case
      CountUpFavorite


update : Msg -> Photo -> ( Photo, Cmd Msg )
update msg entity =
    case msg of
        -- Infrastructure case
        -- View case
        CountUpFavorite ->
            let
                fovoriteCountUppedEntity =
                    countUpFavorite entity
            in
            ( fovoriteCountUppedEntity, Cmd.none )



-- Business logic


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
