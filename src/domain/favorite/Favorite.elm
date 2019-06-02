module Domain.Favorite.Favorite exposing (Favorite, FavoriteColor, FavoriteCount, FavoriteIcon, countUp, create)


type alias Favorite =
    { count : FavoriteCount
    , icon : FavoriteIcon
    , color : FavoriteColor
    }


init : Favorite
init =
    { count = 0
    , icon = icon 0
    , color = color 0
    }


create : Favorite
create =
    init


countUp : Favorite -> Favorite
countUp favorite =
    let
        uppedCount =
            favorite.count + 1
    in
    { favorite
        | count = uppedCount
        , icon = icon uppedCount
        , color = color uppedCount
    }


icon : FavoriteCount -> FavoriteIcon
icon count =
    case count > 0 of
        False ->
            "☆"

        True ->
            "★"


color : FavoriteCount -> FavoriteColor
color count =
    case count > 0 of
        False ->
            "gray"

        True ->
            "PaleVioletRed"


type alias FavoriteCount =
    Int


type alias FavoriteIcon =
    String


type alias FavoriteColor =
    String
