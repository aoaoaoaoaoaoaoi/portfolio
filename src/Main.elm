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
                [ linkItem "#profile-section" "account" "about me"
                , linkItem "#" "card" "career"
                , linkItem "#" "lightbulb" "skill"
                , linkItem "#" "hart" "hobby"
                , linkItem "#" "mail" "contact"
                ]
            ]
        , div [ class "content" ]
            [ section [ id "profile-section" ]
                [ div [ class "inner" ]
                    [ div [ class "section-heading" ]
                        [ h2 [ class "heading-primary" ]
                            [ iconItem "account"
                            , text "about me"
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


iconItem icon =
    span [ class icon ] []
