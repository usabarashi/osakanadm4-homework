module Model exposing (Model, create)

import Domain.Photo as Phohto exposing (Photo)


type alias Model =
    { photos : List Photo }


init : Model
init =
    { photos = [] }


create : Model
create =
    init
