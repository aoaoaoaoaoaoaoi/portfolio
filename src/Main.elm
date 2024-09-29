module Main exposing (main)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Http
import Json.Decode as D exposing (Decoder)
import List exposing (..)
import Task exposing (..)


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = \_ -> Sub.none
        }



-- MODEL


type alias Model =
    { competitiveDataState : DataState
    , repositoryDataState : DataState
    , language : Language
    }


type Language
    = Japanese
    | English


type DataState
    = Init
    | Waiting
    | LoadedCompetitiveData CompetitiveUser
    | LoadedRepositoryData (List Repository)
    | Failed Http.Error


init : () -> ( Model, Cmd Msg )
init _ =
    ( Model Waiting Waiting Japanese
    , Cmd.batch [ getRepositoryData ]
    )



-- UPDATE


type Msg
    = Send
    | ReceiveCompetitiveData (Result Http.Error CompetitiveUser)
    | ReceiveRepositoryData (Result Http.Error (List Repository))
    | ChangeLanguage


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Send ->
            ( { model
                | competitiveDataState = Waiting
                , repositoryDataState = Waiting
              }
            , Cmd.batch [ getCompetitiveData, getRepositoryData ]
            )

        ReceiveCompetitiveData (Ok competitiveUser) ->
            ( { model | competitiveDataState = LoadedCompetitiveData competitiveUser }, Cmd.none )

        ReceiveCompetitiveData (Err e) ->
            ( { model | competitiveDataState = Failed e }, Cmd.none )

        ReceiveRepositoryData (Ok repository) ->
            ( { model | repositoryDataState = LoadedRepositoryData repository }, Cmd.none )

        ReceiveRepositoryData (Err e) ->
            ( { model | repositoryDataState = Failed e }, Cmd.none )

        ChangeLanguage ->
            ( { model
                | language =
                    if model.language == Japanese then
                        English

                    else
                        Japanese
              }
            , Cmd.none
            )


getCompetitiveData : Cmd Msg
getCompetitiveData =
    Task.attempt ReceiveCompetitiveData getCompetitiveDataTask


getCompetitiveDataTask : Task Http.Error CompetitiveUser
getCompetitiveDataTask =
    Http.task
        { method = "GET"
        , headers = []
        , url = "https://kyopro-ratings.jp1.su8.run/json?atcoder=aochan&codeforces=aochan&topcoder_algorithm=aochan&topcoder_marathon=aochan"
        , body = Http.emptyBody
        , resolver = jsonResolver competitiveUserDecoder
        , timeout = Nothing
        }


getRepositoryData : Cmd Msg
getRepositoryData =
    Task.attempt ReceiveRepositoryData getRepositoryDataTask


getRepositoryDataTask : Task Http.Error (List Repository)
getRepositoryDataTask =
    Http.task
        { method = "GET"
        , headers = []
        , url = "https://api.github.com/users/aoaoaoaoaoaoaoi/repos"
        , body = Http.emptyBody
        , resolver = jsonResolver repositoriesDecoder
        , timeout = Nothing
        }


jsonResolver : D.Decoder a -> Http.Resolver Http.Error a
jsonResolver decoder =
    Http.stringResolver <|
        \response ->
            case response of
                Http.BadUrl_ url ->
                    Err (Http.BadUrl url)

                Http.Timeout_ ->
                    Err Http.Timeout

                Http.NetworkError_ ->
                    Err Http.NetworkError

                Http.BadStatus_ metadata body ->
                    Err (Http.BadStatus metadata.statusCode)

                Http.GoodStatus_ metadata body ->
                    case D.decodeString decoder body of
                        Ok value ->
                            Ok value

                        Err err ->
                            Err (Http.BadBody (D.errorToString err))



--VIEW


view : Model -> Html msg
view model =
    div []
        [ nav [ class "gnav" ]
            [ ul [ class "gnav-list" ]
                [ linkItem Career
                , linkItem Skill
                , linkItem Hobby
                , linkItem Contact
                ]
            ]
        , div [ class "content" ]
            [ section [ id (sectionId Career) ]
                [ div [ class "inner" ]
                    [ sectionHeader Career
                    , div [ class "section-content" ]
                        [ ul []
                            [ li [] [ text "2017- social game engineer (Unity, PHP)" ]
                            , li [] [ text "2021- social game server engineer (Python)" ]
                            ]
                        ]
                    ]
                ]
            , section [ id (sectionId Skill) ]
                [ div [ class "inner" ]
                    [ sectionHeader Skill
                    , div [ class "section-content" ]
                        [ div [ class "section-inner-content" ]
                            [ div [ class "section-inner-content-heading" ]
                                [ h3 [] [ text "# Technic" ]
                                ]
                            , div []
                                [ ul []
                                    [ li [] [ text "Python(Django)" ]
                                    , li [] [ text "C#" ]
                                    , li [] [ text "PHP(Laravel)" ]
                                    , li [] [ text "Unity"]
                                    ]
                                ]
                            ]
                        , div [ class "section-inner-content" ]
                            [ div [ class "section-inner-content-heading" ]
                                [ h3 [] [ text "# Certification" ]
                                ]
                            , div []
                                [ ul []
                                    [ li [] [ text "ネットワークスペシャリスト" ]
                                    , li [] [ text "データベーススペシャリスト" ]
                                    , li [] [ text "情報処理安全確保支援士試験合格（情報処理安全確保支援士は未登録）" ]
                                    , li [] [ text "AWS Certified Solutions Architect - Associate" ]
                                    , li [] [ text "応用情報技術者" ]
                                    , li [] [ text "TOEIC:635(L:350 R:285) 2021年7月" ]
                                    ]
                                ]
                            ]
                        ]
                    ]
                ]
            , section [ id (sectionId Hobby) ]
                [ div [ class "inner" ]
                    [ sectionHeader Hobby
                    , div [ class "section-content" ]
                        [ div [ class "section-inner-content" ]
                            [ div [ class "section-inner-content-heading" ]
                                [ h3 [] [ text "# Development" ]
                                ]
                            , div []
                                [ -- repositoryInfo model.repositoryDataState
                                  ul []
                                    [ li []
                                        [ a [ href "https://github.com/aoaoaoaoaoaoaoi" ] [ text "GitHub" ]
                                        ]
                                    , li []
                                        [ a [ href "https://unityroom.com/users/1y49ivzokmwar7n2xe3u" ] [ text "unityroom" ]
                                        ]
                                    , div [] [ text "Game Development (old)" ]
                                    ]
                                ]
                            ]
                        , div [ class "section-inner-content" ]
                            [ div [ class "section-inner-content-heading" ]
                                [ h3 [] [ text "# Writing technical articles" ]
                                ]
                            , div [ class "section-inner-content-content" ]
                                [ ul []
                                    [ li [] [ a [ href "https://gist.github.com/aoaoaoaoaoaoaoi" ] [ text "GitHub Gist" ], span [] [ text " (4.2022 -)" ] ]
                                    , div [] [ text "About technical matters and non-technical skills" ]
                                    , li [] [ a [ href "https://zenn.dev/aoaoaoaoaoaoaoi" ] [ text "Zenn" ], span [] [ text " (5.2021 -)" ] ]
                                    , div [] [ text "About technical matters and non-technical skills" ]
                                    , li [] [ a [ href "http://bit.ly/3lrL7Ey" ] [ text "Qiita" ], span [] [ text " (- 4.2021)" ] ]
                                    , div [] [ text "About technical matters" ]
                                    , li [] [ a [ href "http://bit.ly/2HXTRo9" ] [ text "Hatena Blog" ], span [] [ text " (- 4.2021)" ] ]
                                    , div [] [ text "About non-technical skills and competition programming related" ]
                                    ]
                                ]
                            ]
                        , div [ class "section-inner-content" ]
                            [ div [ class "section-inner-content-heading" ]
                                [ h3 [] [ text "# Participation in competitive programming" ]
                                ]
                            , div [ class "section-inner-content-content" ]
                                [ ul []
                                    [ li [] [ a [ href "https://atcoder.jp/" ] [ text "AtCoder" ] ]
                                    , div [] [ span [] [ text "Name : " ], a [ href "https://atcoder.jp/users/aochan" ] [ text "aochan" ] ]
                                    -- , competitiveInfo model.competitiveDataState
                                    ]
                                ]
                            ]
                        ]
                    ]
                ]
            , section [ id (sectionId Contact) ]
                [ div [ class "inner" ]
                    [ sectionHeader Contact
                    , div [ class "section-content" ]
                        [ ul []
                            [ li [] [ a [ href "https://twitter.com/pirorirori_n712" ] [ text "Twitter" ] ]
                            ]
                        ]
                    ]
                ]
            ]
        ]


{-| competitionInfo
-}
competitiveInfo : DataState -> Html msg
competitiveInfo state =
    case state of
        Init ->
            div [] [ text "" ]

        Waiting ->
            div [] [ text "Waiting..." ]

        LoadedCompetitiveData competitiveUser ->
            div []
                [ div [] [ span [] [ text "Color : " ], span [ style "color" competitiveUser.color ] [ text (ratingColor competitiveUser.rating) ] ]
                , div [] [ span [] [ text "Rating : " ], span [ style "color" competitiveUser.color ] [ text (String.fromInt competitiveUser.rating) ] ]
                ]

        LoadedRepositoryData repository ->
            div [] [ text "" ]

        Failed error ->
            div [] [ text (Debug.toString error) ]


{-| repositoryInfo
-}
repositoryInfo : DataState -> Html msg
repositoryInfo state =
    case state of
        Init ->
            div [] [ text "" ]

        Waiting ->
            div [] [ text "Waiting..." ]

        LoadedCompetitiveData competitiveUser ->
            div [] [ text "" ]

        LoadedRepositoryData repositories ->
            repositoriesInfoPart repositories

        Failed error ->
            div [] [ text (Debug.toString error) ]


repositoriesInfoPart : List Repository -> Html msg
repositoriesInfoPart repositories =
    div [] (List.map (\acc -> repositoryInfoPart acc) repositories)


repositoryInfoPart : Repository -> Html msg
repositoryInfoPart repository =
    div []
        [ a [ href repository.url ]
            [ text repository.name ]
        , div
            []
            [ text (maybeStringToString repository.description) ]
        ]


maybeStringToString : Maybe String -> String
maybeStringToString str =
    case str of
        Just value ->
            value

        Nothing ->
            ""


{-| competitionInfo
-}
ratingColor : Int -> String
ratingColor rate =
    if rate < 400 then
        "Gray"

    else if rate < 800 then
        "Brown"

    else if rate < 1200 then
        "Green"

    else if rate < 1600 then
        "Light Blue"

    else
        "None"


{-| navigation
-}
linkItem : SectionType -> Html msg
linkItem sectionType =
    li [ class "gnav-item" ] [ iconItem (displayIcon sectionType), a [ href ("#" ++ sectionId sectionType) ] [ text (displayName sectionType) ] ]


{-| icon
-}
iconItem : String -> Html msg
iconItem icon =
    span [ class icon ] []


{-| section header
-}
sectionHeader : SectionType -> Html msg
sectionHeader sectionType =
    div [ class "section-heading" ]
        [ h2 [ class "heading-primary" ]
            [ iconItem (displayIcon sectionType)
            , span [ class "section-heading-text" ] [ text (displayName sectionType) ]
            ]
        ]


{-| section type(enum)
-}
type SectionType
    = Profile
    | Career
    | Skill
    | Hobby
    | Contact


{-| iconName
-}
displayIcon : SectionType -> String
displayIcon sectionType =
    case sectionType of
        Profile ->
            "account"

        Career ->
            "card"

        Skill ->
            "lightbulb"

        Hobby ->
            "hart"

        Contact ->
            "mail"


{-| display name of section type
-}
displayName : SectionType -> String
displayName sectionType =
    case sectionType of
        Profile ->
            "PROFILE"

        Career ->
            "CAREER"

        Skill ->
            "SKILL"

        Hobby ->
            "HOBBY"

        Contact ->
            "CONTACT"


{-| display name of section type
-}
sectionId : SectionType -> String
sectionId sectionType =
    case sectionType of
        Profile ->
            "profile-section"

        Career ->
            "career-section"

        Skill ->
            "skill-section"

        Hobby ->
            "hobby-section"

        Contact ->
            "contact-section"



--DATA


type alias CompetitiveUser =
    { color : String
    , rating : Int
    , status : String
    }


competitiveUserDecoder : Decoder CompetitiveUser
competitiveUserDecoder =
    D.map3 CompetitiveUser
        (D.at [ "atcoder", "color" ] D.string)
        (D.at [ "atcoder", "rating" ] D.int)
        (D.at [ "atcoder", "status" ] D.string)


type alias Repository =
    { name : String
    , private : Bool
    , description : Maybe String
    , fork : Bool
    , url : String
    }


repositoriesDecoder : Decoder (List Repository)
repositoriesDecoder =
    D.list repositoryDecoder


repositoryDecoder : Decoder Repository
repositoryDecoder =
    D.map5 Repository
        (D.field "name" D.string)
        (D.field "private" D.bool)
        (D.maybe (D.field "description" D.string))
        (D.field "fork" D.bool)
        (D.field "url" D.string)
