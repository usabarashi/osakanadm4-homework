module Domain.Photo.PhotoUpdate exposing (update)

import Domain.Photo.Photo as Photo exposing (..)
import Domain.Photo.PhotoMsg as PhotoMsg exposing (..)


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
