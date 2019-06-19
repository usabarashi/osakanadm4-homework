module Domain.Favorite exposing (Color, Count, Favorite, Icon, countUp, create)

-- Model


type alias Favorite =
    { count : Count
    , icon : Icon
    , color : Color
    }


init : Favorite
init =
    { count = 0
    , icon = icon 0
    , color = color 0
    }



-- Business logic


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


icon : Count -> Icon
icon count =
    case count > 0 of
        False ->
            "☆"

        True ->
            "★"


color : Count -> Color
color count =
    case count > 0 of
        False ->
            "gray"

        True ->
            "PaleVioletRed"


type alias Count =
    Int


type alias Icon =
    String


type alias Color =
    String
