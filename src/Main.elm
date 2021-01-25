module Main exposing (main)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Http
import Json.Decode as D exposing (Decoder)


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
    { userState : UserState
    }


type UserState
    = Init
    | Waiting
    | Loaded User
    | Failed Http.Error


init : () -> ( Model, Cmd Msg )
init _ =
    ( Model Waiting
    , send
    )



-- UPDATE


type Msg
    = Send
    | Receive (Result Http.Error User)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Send ->
            ( { model
                | userState = Waiting
              }
            , send
            )

        Receive (Ok user) ->
            ( { model | userState = Loaded user }, Cmd.none )

        Receive (Err e) ->
            ( { model | userState = Failed e }, Cmd.none )


send : Cmd Msg
send =
    Http.get
        { url = "https://kyopro-ratings.herokuapp.com/json?atcoder=aochan&codeforces=aochan&topcoder_algorithm=aochan&topcoder_marathon=aochan"
        , expect = Http.expectJson Receive userDecoder
        }



--VIEW


view : Model -> Html msg
view model =
    div []
        [ header []
            [ h1 [ class "title" ]
                [ text "ao's portfolio" ]
            ]
        , nav [ class "gnav" ]
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
                                [ h3 [] [ text "Reading technical books" ]
                                ]
                            , div [ class "section-inner-content-content" ]
                                [ ul [] [ li [] [ text "anything" ] ]
                                ]
                            ]
                        , div [ class "section-inner-content" ]
                            [ div [ class "section-inner-content-heading" ]
                                [ h3 [] [ text "Writing technical articles" ]
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
                                [ h3 [] [ text "Participation in competitive programming" ]
                                ]
                            , div [ class "section-inner-content-content" ]
                                [ ul []
                                    [ li [] [ a [ href "https://atcoder.jp/" ] [ text "AtCoder" ] ]
                                    , div [] [ span [] [ text "Name : " ], a [ href "https://atcoder.jp/users/aochan" ] [ text "aochan" ] ]
                                    , competitiveInfo model.userState
                                    ]
                                ]
                            ]
                        , div [ class "section-inner-content" ]
                            [ div [ class "section-inner-content-heading" ]
                                [ h3 [] [ text "Creating in free time" ]
                                ]
                            ]
                        , div [ class "section-inner-content" ]
                            [ div [ class "section-inner-content-heading" ]
                                [ h3 [] [ text "Creating Games" ]
                                ]
                            ]
                        ]
                    ]
                ]
            ]
        ]


{-| competitionInfo
-}
competitiveInfo : UserState -> Html msg
competitiveInfo state =
    case state of
        Init ->
            div [] [ text "" ]

        Waiting ->
            div [] [ text "Waiting..." ]

        Loaded user ->
            div []
                [ div [] [ span [] [ text "Color : " ], span [ style "color" user.color ] [ text (ratingColor user.rating) ] ]
                , div [] [ span [] [ text "Rating : " ], span [ style "color" user.color ] [ text (String.fromInt user.rating) ] ]
                ]

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
            , text (displayName sectionType)
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


type alias User =
    { color : String
    , rating : Int
    , status : String
    }


userDecoder : Decoder User
userDecoder =
    D.map3 User
        (D.at [ "atcoder", "color" ] D.string)
        (D.at [ "atcoder", "rating" ] D.int)
        (D.at [ "atcoder", "status" ] D.string)
