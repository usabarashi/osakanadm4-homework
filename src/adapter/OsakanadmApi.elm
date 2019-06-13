module Adapter.OsakanadmApi exposing (get, url)

import Adapter.Helper
import Domain.Photo as Photo exposing (Photo)
import Http
import Json.Decode
import Task


url : String
url =
    "http://localhost:8080"


get : Task.Task Http.Error (List Photo)
get =
    let
        responseDecoder : Json.Decode.Decoder (List Photo)
        responseDecoder =
            Json.Decode.list <|
                Json.Decode.map2 Photo.create
                    (Json.Decode.field "title" Json.Decode.string)
                    (Json.Decode.field "image" Json.Decode.string)
    in
    Http.task
        { method = "GET"
        , headers = []
        , url = url ++ "/api/photos.json"
        , body = Http.emptyBody
        , resolver = Adapter.Helper.jsonResolver responseDecoder
        , timeout = Nothing
        }
