module Query.PhotoQueryUpdate exposing (update)

import Adapter.OsakanadmApi
import Domain.Photo as Photo exposing (Photo)
import Query.PhotoQueryMsg
import Task


update : Query.PhotoQueryMsg.Msg -> ( List Photo, Cmd Query.PhotoQueryMsg.Msg )
update msg =
    case msg of
        Query.PhotoQueryMsg.GetRequest ->
            ( [], Task.attempt Query.PhotoQueryMsg.GetResponse <| Adapter.OsakanadmApi.get )

        Query.PhotoQueryMsg.GetResponse (Ok gotPhotos) ->
            ( gotPhotos, Cmd.none )

        Query.PhotoQueryMsg.GetResponse (Err _) ->
            -- Error握りつぶしたらあかんで
            ( [], Cmd.none )
