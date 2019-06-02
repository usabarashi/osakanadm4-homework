module Adapter.Infrastructure.OsakanadmApi.PhotoApi exposing (get, url)

import Domain.Photo.Photo as Photo exposing (..)
import Http
import Json.Decode as Decode
import Query.PhotoQueryMsg as PhotoQueryMsg exposing (..)


url : String
url =
    "http://localhost:8080"


get : Cmd PhotoQueryMsg.Msg
get =
    let
        photosDecoder : Decode.Decoder (List Photo)
        photosDecoder =
            Decode.list photoDecoder

        photoDecoder : Decode.Decoder Photo
        photoDecoder =
            Decode.map2 Photo.create
                (Decode.field "title" Decode.string)
                (Decode.field "image" Decode.string)
    in
    Http.get
        { url = url ++ "/api/photos.json"
        , expect = Http.expectJson PhotoQueryMsg.GetResponse photosDecoder
        }
