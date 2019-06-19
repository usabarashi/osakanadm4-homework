module Main exposing (main)

import Browser
import Domain.Photo as Photo exposing (Photo)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Page.Photo
import Query.PhotoQuery as PhotoQuery
import Reference exposing (Reference)
import Reference.List


main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


init : () -> ( Model, Cmd Msg )
init () =
    update (MapToPhotoQuery PhotoQuery.GetRequest) create



-- Model


type alias Model =
    { photos : List Photo }


initModel : Model
initModel =
    { photos = [] }


create : Model
create =
    initModel



-- Update


type Msg
    = -- View
      MapToPhotoPage (Reference Photo (List Photo)) Photo.Msg
      -- Query
    | MapToPhotoQuery PhotoQuery.Msg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        -- View
        MapToPhotoPage refPhoto photoMsg ->
            let
                ( resultPhoto, resultCmd ) =
                    Photo.update photoMsg (Reference.this refPhoto)

                modifyPhotos : Photo -> Reference Photo (List Photo) -> List Photo
                modifyPhotos modifiedEntity refEntity =
                    Reference.root <| Reference.modify (\discard -> modifiedEntity) refEntity

                resultPhotos : List Photo
                resultPhotos =
                    modifyPhotos resultPhoto refPhoto
            in
            ( { model | photos = resultPhotos }, Cmd.map (MapToPhotoPage refPhoto) resultCmd )

        -- Query
        MapToPhotoQuery queryMsg ->
            let
                ( gotPhotos, resultCmd ) =
                    PhotoQuery.update queryMsg
            in
            ( { model | photos = gotPhotos }, Cmd.map MapToPhotoQuery resultCmd )



-- Subscriptions


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- View


view : Model -> Html Msg
view model =
    let
        headerAttribute : List (Attribute msg)
        headerAttribute =
            [ style "position" "fixed"
            , style "top" "0"
            , style "left" "0"
            , style "width" "100%"
            , style "height" "40px"
            , style "borderBottom" "1px solid silver"
            , style "boxSizing" "border-box"
            , style "display" "flex"
            , style "alignItems" "center"
            , style "backgroundColor" "white"
            ]

        titleAttribute : List (Attribute msg)
        titleAttribute =
            [ style "fontSize" "large"
            , style "fontStyle" "italic"
            , style "margin" "0"
            ]

        photoViews : List Photo -> Html Msg
        photoViews photos =
            let
                mappedPhotoViews : Html Msg
                mappedPhotoViews =
                    Reference.top photos
                        |> Reference.List.unwrap mappedPhotoView
                        |> div photosAttribute

                photosAttribute : List (Attribute msg)
                photosAttribute =
                    [ style "width" "500px"
                    , style "margin" "65px auto"
                    ]

                mappedPhotoView : Reference Photo (List Photo) -> Html Msg
                mappedPhotoView refPhoto =
                    Page.Photo.view (Reference.this refPhoto) Photo.CountUpFavorite
                        |> Html.map (MapToPhotoPage refPhoto)
            in
            mappedPhotoViews
    in
    div []
        [ header headerAttribute [ h1 titleAttribute [ text "Osakanagram" ] ]
        , photoViews model.photos
        ]
