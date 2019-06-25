module Query.PhotoQuery exposing (getPhotos)

import Adapter.OsakanadmApi
import Domain.Photo as Photo exposing (Photo)
import Http
import Task


getPhotos : Task.Task Http.Error (List Photo)
getPhotos =
    Adapter.OsakanadmApi.get
