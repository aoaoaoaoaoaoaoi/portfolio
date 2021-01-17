module Main exposing (main)

import Html exposing (Html, div, header, text)
import Html.Attributes exposing (attribute, style)


main : Html msg
main =
    header [ attribute "style" "height: 500px; background-size: auto 100%; background: url(./image/background.jpg) center center;" ] [ text "Hello!" ]
