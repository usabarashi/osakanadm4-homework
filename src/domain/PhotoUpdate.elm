module Domain.PhotoUpdate exposing (update)

import Domain.Photo as Photo exposing (Photo)
import Domain.PhotoMsg as PhotoMsg exposing (..)


update : Msg -> Photo -> ( Photo, Cmd PhotoMsg.Msg )
update msg entity =
    case msg of
        -- Infrastructure case
        -- View case
        CountUpFavorite ->
            let
                fovoriteCountUppedEntity =
                    Photo.countUpFavorite entity
            in
            ( fovoriteCountUppedEntity, Cmd.none )
