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
    { repositoryDataState : DataState
    }


type DataState
    = Init
    | Waiting
    | LoadedRepositoryData (List Repository)
    | Failed Http.Error


init : () -> ( Model, Cmd Msg )
init _ =
    ( Model Waiting
    , Http.get
        { url = "https://api.github.com/users/aoaoaoaoaoaoaoi/repos"
        , expect = Http.expectJson ReceiveRepositoryData repositoriesDecoder
        }
    )



-- UPDATE


type Msg
    = Send
    | ReceiveRepositoryData (Result Http.Error (List Repository))


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Send ->
            ( { model
                | repositoryDataState = Waiting
              }
            , Http.get
                { url = "https://api.github.com/users/aoaoaoaoaoaoaoi/repos"
                , expect = Http.expectJson ReceiveRepositoryData repositoriesDecoder
                }
            )

        ReceiveRepositoryData (Ok repository) ->
            ( { model | repositoryDataState = LoadedRepositoryData repository }, Cmd.none )

        ReceiveRepositoryData (Err e) ->
            ( { model | repositoryDataState = Failed e }, Cmd.none )



--VIEW


view : Model -> Html msg
view model =
    div []
        [ nav [ class "gnav" ]
            [ ul [ class "gnav-list" ]
                [ linkItem Profile
                , linkItem Career
                , linkItem Skill
                , linkItem Hobby
                , linkItem Contact
                ]
            ]
        , div [ class "content" ]
            [ section [ id (sectionId Profile) ]
                [ div [ class "inner" ]
                    [ sectionHeader Profile
                    , div [ class "two-column-wrapper section-content" ]
                        [ div [ class "two-column-left" ]
                            [ img [ class "profile-image", src "./image/profile.jpeg" ] []
                            ]
                        , div [ class "two-column-right" ]
                            [ text "テキスト" ]
                        ]
                    ]
                ]
            , section [ id (sectionId Career) ]
                [ div [ class "inner" ]
                    [ sectionHeader Career
                    , div [ class "section-content" ]
                        [ ul []
                            [ li [] [ text "2017- social game engineer (Unity, PHP)" ] ]
                        ]
                    ]
                ]
            , section [ id (sectionId Skill) ]
                [ div [ class "inner" ]
                    [ sectionHeader Skill
                    , div [ class "section-content" ]
                        [ ul []
                            [ li [] [ text "Unity" ]
                            , li [] [ text "C#" ]
                            , li [] [ text "PHP(Laravel)" ]
                            , li [] [ text "MySQL" ]
                            , li [] [ text "AWS(EC2, RDS, S3)" ]
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
                                [ h3 [] [ text "# Reading technical books" ]
                                ]
                            , div [ class "section-inner-content-content" ]
                                [ ul [] [ li [] [ text "anything" ] ]
                                ]
                            ]
                        , div [ class "section-inner-content" ]
                            [ div [ class "section-inner-content-heading" ]
                                [ h3 [] [ text "# Writing technical articles" ]
                                ]
                            , div [ class "section-inner-content-content" ]
                                [ ul []
                                    [ li [] [ a [ href "http://bit.ly/3lrL7Ey" ] [ text "Qiita" ] ]
                                    , div [] [ text "About technical matters" ]
                                    , li [] [ a [ href "http://bit.ly/2HXTRo9" ] [ text "Hatena Blog" ] ]
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
                                    , div [] [ text "" ]
                                    ]
                                ]
                            ]
                        , div [ class "section-inner-content" ]
                            [ div [ class "section-inner-content-heading" ]
                                [ h3 [] [ text "# Creating in free time" ]
                                ]
                            , div []
                                [ repositoryInfo model.repositoryDataState
                                ]
                            ]
                        , div [ class "section-inner-content" ]
                            [ div [ class "section-inner-content-heading" ]
                                [ h3 [] [ text "# Creating Games" ]
                                ]
                            ]
                        ]
                    ]
                ]
            ]
        ]


{-| repositoryInfo
-}
repositoryInfo : DataState -> Html msg
repositoryInfo state =
    case state of
        Init ->
            div [] [ text "" ]

        Waiting ->
            div [] [ text "Waiting..." ]

        LoadedRepositoryData repositories ->
            case head repositories of
                Just value ->
                    div [] [ text value.name ]

                Nothing ->
                    div [] [ text "" ]

        Failed error ->
            div [] [ text (Debug.toString error) ]


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


type alias Repository =
    { name : String
    , private : String
    , description : String
    , folk : String
    , url : String
    }



{-
   repositoriesDecoder : Decoder (List Repository)
   repositoriesDecoder =
       D.list repositoryDecoder
-}


repositoriesDecoder : Decoder (List Repository)
repositoriesDecoder =
    D.map5 Repository
        (D.field "name" D.string)
        (D.field "private" D.string)
        (D.field "description" D.string)
        (D.field "folk" D.string)
        (D.field "url" D.string)
        |> D.list
