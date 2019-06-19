module Query.PhotoQuery exposing (Msg(..), update)

import Adapter.OsakanadmApi
import Domain.Photo as Photo exposing (Photo)
import Http
import Task


type Msg
    = GetRequest
    | GetResponse (Result Http.Error (List Photo))


update : Msg -> ( List Photo, Cmd Msg )
update msg =
    case msg of
        GetRequest ->
            ( [], Task.attempt GetResponse <| Adapter.OsakanadmApi.get )

        GetResponse (Ok gotPhotos) ->
            ( gotPhotos, Cmd.none )

        GetResponse (Err _) ->
            -- Error握りつぶしたらあかんで
            ( [], Cmd.none )
