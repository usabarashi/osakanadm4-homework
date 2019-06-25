OsakaNa DM 4 Homework
=====================

[OsakaNa DM 4 - Elmを教えてもらう](https://osakanadm.connpass.com/event/128028/)の宿題をやりました.

Elm版Osakanagramを動かしてみる
===========================

repositoryをcloneする.  
※ gitがインストールされている前提

```sh
git clone https://github.com/usabarashi/osakanadm4-homework.git
cd osakanadm4-homework
```

osakanadm-apiを起動する.  
※ dockerとdocker-composeがインストールされている前提

```sh
docker-compose up -d
docker-compose ps
```

ブラウザで http://localhost:8080/api/photos.json にアクセスする.

osakanagramを起動する.  
※ elmがインストールされている前提 

```sh
elm reactor --port 3000
```
ブラウザで http://localhost:3000/src/Main.elm にアクセスする.

ちゃんちゃん.

References
==========

- [OsakaNa DM 4 - Elmを教えてもらう](https://osakanadm.connpass.com/event/128028/)
- [backpaper0/osakanadm4](https://github.com/backpaper0/osakanadm4)
- [backpaper0/osakanadm-api](https://hub.docker.com/r/backpaper0/osakanadm-api)
- [公式ドキュメント翻訳プロジェクト](https://guide.elm-lang.jp/)
- [elm](https://elm-lang.org/)
