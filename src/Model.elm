module Model exposing (Model, create)

import Domain.Photo.Photo exposing (..)


type alias Model =
    { photos : List Photo }


init : Model
init =
    { photos = [] }


create : Model
create =
    init
