module Main exposing (init, main, subscriptions, view)

import Adapter.View.Photo.PhotoView as PhotoView exposing (..)
import Browser
import Domain.Photo.Photo as Photo exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Model as MainModel exposing (Model, create)
import Msg as MainMsg exposing (..)
import Query.PhotoQueryMsg as PhotoQueryMsg exposing (..)
import Query.PhotoQueryUpdate as PhotoQueryUpdate exposing (update)
import Reference exposing (Reference)
import Reference.List
import Update as MainUpdate exposing (update)


main =
    Browser.element
        { init = init
        , view = view
        , update = MainUpdate.update
        , subscriptions = subscriptions
        }


init : () -> ( MainModel.Model, Cmd MainMsg.Msg )
init () =
    let
        msg =
            MainMsg.MapToPhotoQuery PhotoQueryMsg.GetRequest

        model =
            MainModel.create
    in
    MainUpdate.update msg model



-- SUBSCRIPTIONS


subscriptions : MainModel.Model -> Sub MainMsg.Msg
subscriptions model =
    Sub.none



-- VIEW


view : MainModel.Model -> Html MainMsg.Msg
view model =
    let
        headerAttribute =
            handler :: headerCss

        handler =
            onClick (MainMsg.MapToPhotoQuery PhotoQueryMsg.GetRequest)

        headerCss =
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

        photoAttribute : List (Attribute msg)
        photoAttribute =
            [ style "width" "500px"
            , style "margin" "65px auto"
            ]

        photoViews : List Photo -> Html MainMsg.Msg
        photoViews photos =
            let
                mappedPhotoViews : Html MainMsg.Msg
                mappedPhotoViews =
                    Reference.top photos
                        |> Reference.List.unwrap mappedPhotoView
                        |> div photoAttribute

                mappedPhotoView : Reference Photo (List Photo) -> Html MainMsg.Msg
                mappedPhotoView refPhoto =
                    Reference.this refPhoto
                        |> PhotoView.view
                        |> Html.map (MainMsg.MapToPhoto refPhoto)
            in
            mappedPhotoViews
    in
    div []
        [ header headerAttribute [ h1 titleAttribute [ text "Osakanagram" ] ]
        , photoViews model.photos
        ]
