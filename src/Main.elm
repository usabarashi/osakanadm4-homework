module Main exposing (main)

import Browser
import Domain.Photo as Photo exposing (Photo)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Page.Photo
import Query.PhotoQuery
import Types.Css



-- Main


main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


init : () -> ( Page, Cmd Msg )
init () =
    let
        ( initPageModel, initPageCmd ) =
            Page.Photo.init
    in
    ( PhotoPage initPageModel
    , Cmd.map PhotoPageMsg initPageCmd
    )



-- Update


type Page
    = PhotoPage Page.Photo.Model


type Msg
    = -- Page case
      PhotoPageMsg Page.Photo.Msg


update : Msg -> Page -> ( Page, Cmd Msg )
update msg page =
    case msg of
        -- Page case
        PhotoPageMsg pageMsg ->
            case page of
                PhotoPage pageModel ->
                    let
                        ( modifiedPageModel, pageCmd ) =
                            Page.Photo.update pageMsg pageModel
                    in
                    ( PhotoPage modifiedPageModel
                    , Cmd.map PhotoPageMsg pageCmd
                    )



-- Subscriptions


subscriptions : Page -> Sub Msg
subscriptions page =
    Sub.none



-- View


view : Page -> Html Msg
view page =
    div []
        [ header Types.Css.headerAttribute [ h1 Types.Css.titleAttribute [ text "Osakanagram" ] ]
        , case page of
            PhotoPage pageModel ->
                Html.map PhotoPageMsg <| Page.Photo.view pageModel
        ]
