module Adapter.View.Photo.PhotoView exposing (view)

import Adapter.Infrastructure.OsakanadmApi.PhotoApi as PhotoApi exposing (url)
import Domain.Favorite.Favorite as Favorite exposing (..)
import Domain.Photo.Photo as Photo exposing (..)
import Domain.Photo.PhotoMsg as PhotoMsg exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


view : Photo -> Html PhotoMsg.Msg
view photo =
    div [ style "border" "1px solid silver", style "margin" "25px 0" ]
        [ div [] [ img [ style "width" "100%", src <| PhotoApi.url ++ photo.image ] [] ]
        , div [ style "padding" "0 5px" ] [ text photo.title ]
        , div [ style "padding" "0 5px" ]
            [ button
                [ onClick PhotoMsg.CountUpFavorite
                , style "cursor" "pointer"
                , style "border" "0"
                , style "fontSize" "large"
                , style "backgroundColor" "transparent"
                , style "color" photo.favorite.color
                ]
                [ text photo.favorite.icon ]
            , span [] [ text "いいね！", text <| String.fromInt photo.favorite.count, text "件" ]
            ]
        ]
