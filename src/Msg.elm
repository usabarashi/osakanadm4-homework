module Msg exposing (Msg(..))

import Domain.Photo as Photo exposing (Photo)
import Domain.PhotoMsg as PhotoMsg exposing (Msg)
import Query.PhotoQueryMsg as PhotoQueryMsg exposing (Msg)
import Reference exposing (Reference)
import Reference.List


type Msg
    = -- View
      MapToPhoto (Reference Photo (List Photo)) PhotoMsg.Msg
      -- Query
    | MapToPhotoQuery PhotoQueryMsg.Msg
