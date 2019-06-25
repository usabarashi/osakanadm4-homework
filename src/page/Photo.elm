module Page.Photo exposing (Model, Msg(..), init, update, view)

import Adapter.OsakanadmApi
import Domain.Photo as Photo exposing (Photo)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Http
import Query.PhotoQuery
import Task



-- Model


type alias Model =
    { photos : List Photo }


init : ( Model, Cmd Msg )
init =
    ( { photos = [] }
    , Task.attempt GetPhotosResponse <| Query.PhotoQuery.getPhotos
    )



-- Update


type Msg
    = -- View case
      CountUpFavorite Photo
      -- Query case
    | GetPhotosRequest
    | GetPhotosResponse (Result Http.Error (List Photo))


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        -- View case
        CountUpFavorite modifyPhoto ->
            let
                modifiedPhotos : List Photo
                modifiedPhotos =
                    List.map
                        (\photo ->
                            case photo.image == modifyPhoto.image of
                                False ->
                                    photo

                                True ->
                                    Photo.countUpFavorite modifyPhoto
                        )
                        model.photos
            in
            ( { model | photos = modifiedPhotos }, Cmd.none )

        -- Query case
        GetPhotosRequest ->
            ( model, Task.attempt GetPhotosResponse Query.PhotoQuery.getPhotos )

        GetPhotosResponse (Ok photos) ->
            ( { model | photos = photos }, Cmd.none )

        GetPhotosResponse (Err _) ->
            ( model, Cmd.none )



-- View


view : Model -> Html Msg
view model =
    let
        photosAttribute : List (Attribute msg)
        photosAttribute =
            [ style "width" "500px"
            , style "margin" "65px auto"
            ]
    in
    div photosAttribute <| List.map (\photo -> photoView photo (CountUpFavorite photo)) model.photos


photoView : Photo -> msg -> Html msg
photoView photo msg =
    let
        favoriteImageSrc : Photo -> Attribute msg
        favoriteImageSrc photo_ =
            src <| Adapter.OsakanadmApi.url ++ photo_.image

        favoriteButton : Photo -> msg -> Html msg
        favoriteButton photo_ msg_ =
            button
                [ onClick msg_
                , style "cursor" "pointer"
                , style "border" "0"
                , style "fontSize" "large"
                , style "backgroundColor" "transparent"
                , style "color" photo_.favorite.color
                ]
                [ text photo_.favorite.icon ]

        favoriteCount : Photo -> Html msg
        favoriteCount photo_ =
            text <| String.fromInt photo_.favorite.count
    in
    div [ style "border" "1px solid silver", style "margin" "25px 0" ]
        [ div [] [ img [ style "width" "100%", favoriteImageSrc photo ] [] ]
        , div [ style "padding" "0 5px" ] [ text photo.title ]
        , div [ style "padding" "0 5px" ]
            [ favoriteButton photo msg
            , span [] [ text "いいね！", favoriteCount photo, text "件" ]
            ]
        ]
