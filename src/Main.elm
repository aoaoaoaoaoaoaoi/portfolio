module Main exposing (main)

import Html exposing (Html, a, div, h1, header, i, li, nav, span, text, ul)
import Html.Attributes exposing (attribute, class, href, style)


main : Html msg
main =
    div []
        [ header []
            [ h1 [ class "title" ]
                [ text "ao's portfolio" ]
            ]
        , nav [ class "gnav" ]
            [ ul [ class "gnav-list" ]
                [ linkItem "#" "account" "profile"
                , linkItem "#" "lightbulb" "skill"
                , linkItem "#" "card" "career"
                , linkItem "#" "mail" "contact"
                ]
            ]
        ]


linkItem : String -> String -> String -> Html msg
linkItem url icon text_ =
    li [ class "gnav-item" ] [ span [ class icon ] [], a [ href "#" ] [ text text_ ] ]
