module Types.Css exposing (headerAttribute, titleAttribute)

import Html exposing (..)
import Html.Attributes exposing (..)


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
