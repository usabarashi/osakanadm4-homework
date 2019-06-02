module Update exposing (update)

import Domain.Photo.Photo as Photo exposing (..)
import Domain.Photo.PhotoUpdate as PhotoUpdate exposing (..)
import Model as MainModel exposing (Model)
import Msg as MainMsg exposing (..)
import Query.PhotoQueryUpdate as PhotoQueryUpdate exposing (..)
import Reference exposing (Reference)
import Reference.List


update : MainMsg.Msg -> MainModel.Model -> ( MainModel.Model, Cmd MainMsg.Msg )
update msg model =
    case msg of
        -- Domain
        MainMsg.MapToPhoto refPhoto photoMsg ->
            let
                ( resultPhoto, resultCmd ) =
                    PhotoUpdate.update photoMsg (Reference.this refPhoto)

                modifyPhotos : Photo -> Reference Photo (List Photo) -> List Photo
                modifyPhotos modifiedEntity refEntity =
                    Reference.root <| Reference.modify (\discard -> modifiedEntity) refEntity

                resultPhotos : List Photo
                resultPhotos =
                    modifyPhotos resultPhoto refPhoto
            in
            ( { model | photos = resultPhotos }, Cmd.map (MainMsg.MapToPhoto refPhoto) resultCmd )

        -- Query
        MainMsg.MapToPhotoQuery queryMsg ->
            let
                ( foundPhotos, resultCmd ) =
                    PhotoQueryUpdate.update queryMsg
            in
            ( { model | photos = foundPhotos }, Cmd.map MainMsg.MapToPhotoQuery resultCmd )
