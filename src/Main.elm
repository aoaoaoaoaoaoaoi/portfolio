module Main exposing (main)

import Html exposing (Html, a, div, h1, header, li, nav, text, ul)
import Html.Attributes exposing (attribute, href, style, class)


main : Html msg
main =
    div []
        [ header []
            [ h1 [ class "title"]
                [ text "ao's portfolio" ]
            ]
        , nav []
            [ ul []
                [ linkItem "#" "profile"
                , linkItem "#" "skill"
                , linkItem "#" "career"
                , linkItem "#" "contact"
                ]
            ]
        ]


linkItem : String -> String -> Html msg
linkItem url text_ =
    li [] [ a [ href "#" ] [ text text_ ] ]
