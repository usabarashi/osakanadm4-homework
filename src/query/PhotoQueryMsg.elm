module Query.PhotoQueryMsg exposing (Msg(..))

import Domain.Photo as Photo exposing (Photo)
import Http


type Msg
    = GetRequest
    | GetResponse (Result Http.Error (List Photo))
