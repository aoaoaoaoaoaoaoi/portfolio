module Main exposing (main)

import Html exposing (Html, a, div, h1, header, li, nav, text, ul)
import Html.Attributes exposing (attribute, href, style)


main : Html msg
main =
    div []
        [ header [ attribute "style" "height: 500px; background-size: auto 100%; background: url(./image/background.jpg) center center;" ]
            [ h1 [ attribute "style" "position: absolute; margin: auto; top: 0; bottom: 0; left: 0; right: 0; height: 3.2rem; text-align: center" ]
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
