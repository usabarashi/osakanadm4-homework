module Query.PhotoQueryUpdate exposing (update)

import Adapter.Infrastructure.OsakanadmApi.PhotoApi as PhotoApi exposing (..)
import Domain.Photo.Photo as Photo exposing (..)
import Query.PhotoQueryMsg as QueryMsg exposing (..)


update : Msg -> ( List Photo, Cmd QueryMsg.Msg )
update msg =
    case msg of
        GetRequest ->
            ( [], PhotoApi.get )

        GetResponse (Ok foundPhoto) ->
            ( foundPhoto, Cmd.none )

        GetResponse (Err _) ->
            -- Error握りつぶしたらあかんで
            ( [], Cmd.none )
