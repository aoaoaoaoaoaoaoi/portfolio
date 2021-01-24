module Main exposing (main)

import Html exposing (..)
import Html.Attributes exposing (..)


main : Html msg
main =
    div []
        [ header []
            [ h1 [ class "title" ]
                [ text "ao's portfolio" ]
            ]
        , nav [ class "gnav" ]
            [ ul [ class "gnav-list" ]
                [ linkItem "#profile-section" (displayIcon Profile) (displayName Profile)
                , linkItem "#" (displayIcon Career) (displayName Career)
                , linkItem "#" (displayIcon Skill) (displayName Skill)
                , linkItem "#" (displayIcon Hobby) (displayName Hobby)
                , linkItem "#" (displayIcon Contact) (displayName Contact)
                ]
            ]
        , div [ class "content" ]
            [ section [ id "profile-section" ]
                [ div [ class "inner" ]
                    [ div [ class "section-heading" ]
                        [ h2 [ class "heading-primary" ]
                            [ iconItem (displayIcon Profile)
                            , text (displayName Profile)
                            ]
                        ]
                    , div [ class "two-column-wrapper" ]
                        [ div [ class "two-column-left" ]
                            [ img [ class "profile-image", src "./image/profile.jpeg" ] []
                            ]
                        , div [ class "two-column-right" ]
                            [ text "テキスト" ]
                        ]
                    ]
                ]
            ]
        ]


linkItem : String -> String -> String -> Html msg
linkItem url icon text_ =
    li [ class "gnav-item" ] [ iconItem icon, a [ href "#" ] [ text text_ ] ]


iconItem : String -> Html msg
iconItem icon =
    span [ class icon ] []


type SectionType
    = Profile
    | Career
    | Skill
    | Hobby
    | Contact


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
