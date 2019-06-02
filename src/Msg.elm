module Msg exposing (Msg(..))

import Domain.Photo.Photo as Photo exposing (..)
import Domain.Photo.PhotoMsg as PhotoMsg exposing (Msg)
import Query.PhotoQueryMsg as PhotoQueryMsg exposing (Msg)
import Reference exposing (Reference)
import Reference.List


type Msg
    = -- Domain
      MapToPhoto (Reference Photo (List Photo)) PhotoMsg.Msg
      -- Query
    | MapToPhotoQuery PhotoQueryMsg.Msg
