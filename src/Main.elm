module Main exposing (main)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Http
import Json.Decode as D exposing (Decoder)
import List exposing (..)
import Task exposing (..)


payload =
    """
[
{
    "id": 324377469,
    "node_id": "MDEwOlJlcG9zaXRvcnkzMjQzNzc0Njk=",
    "name": "akeru",
    "full_name": "aoaoaoaoaoaoaoi/akeru",
    "private": false,
    "owner": {
    "login": "aoaoaoaoaoaoaoi",
    "id": 40077710,
    "node_id": "MDQ6VXNlcjQwMDc3NzEw",
    "avatar_url": "https://avatars.githubusercontent.com/u/40077710?v=4",
    "gravatar_id": "",
    "url": "https://api.github.com/users/aoaoaoaoaoaoaoi",
    "html_url": "https://github.com/aoaoaoaoaoaoaoi",
    "followers_url": "https://api.github.com/users/aoaoaoaoaoaoaoi/followers",
    "following_url": "https://api.github.com/users/aoaoaoaoaoaoaoi/following{/other_user}",
    "gists_url": "https://api.github.com/users/aoaoaoaoaoaoaoi/gists{/gist_id}",
    "starred_url": "https://api.github.com/users/aoaoaoaoaoaoaoi/starred{/owner}{/repo}",
    "subscriptions_url": "https://api.github.com/users/aoaoaoaoaoaoaoi/subscriptions",
    "organizations_url": "https://api.github.com/users/aoaoaoaoaoaoaoi/orgs",
    "repos_url": "https://api.github.com/users/aoaoaoaoaoaoaoi/repos",
    "events_url": "https://api.github.com/users/aoaoaoaoaoaoaoi/events{/privacy}",
    "received_events_url": "https://api.github.com/users/aoaoaoaoaoaoaoi/received_events",
    "type": "User",
    "site_admin": false
    },
    "html_url": "https://github.com/aoaoaoaoaoaoaoi/akeru",
    "description": null,
    "fork": false,
    "url": "https://api.github.com/repos/aoaoaoaoaoaoaoi/akeru",
    "forks_url": "https://api.github.com/repos/aoaoaoaoaoaoaoi/akeru/forks",
    "keys_url": "https://api.github.com/repos/aoaoaoaoaoaoaoi/akeru/keys{/key_id}",
    "collaborators_url": "https://api.github.com/repos/aoaoaoaoaoaoaoi/akeru/collaborators{/collaborator}",
    "teams_url": "https://api.github.com/repos/aoaoaoaoaoaoaoi/akeru/teams",
    "hooks_url": "https://api.github.com/repos/aoaoaoaoaoaoaoi/akeru/hooks",
    "issue_events_url": "https://api.github.com/repos/aoaoaoaoaoaoaoi/akeru/issues/events{/number}",
    "events_url": "https://api.github.com/repos/aoaoaoaoaoaoaoi/akeru/events",
    "assignees_url": "https://api.github.com/repos/aoaoaoaoaoaoaoi/akeru/assignees{/user}",
    "branches_url": "https://api.github.com/repos/aoaoaoaoaoaoaoi/akeru/branches{/branch}",
    "tags_url": "https://api.github.com/repos/aoaoaoaoaoaoaoi/akeru/tags",
    "blobs_url": "https://api.github.com/repos/aoaoaoaoaoaoaoi/akeru/git/blobs{/sha}",
    "git_tags_url": "https://api.github.com/repos/aoaoaoaoaoaoaoi/akeru/git/tags{/sha}",
    "git_refs_url": "https://api.github.com/repos/aoaoaoaoaoaoaoi/akeru/git/refs{/sha}",
    "trees_url": "https://api.github.com/repos/aoaoaoaoaoaoaoi/akeru/git/trees{/sha}",
    "statuses_url": "https://api.github.com/repos/aoaoaoaoaoaoaoi/akeru/statuses/{sha}",
    "languages_url": "https://api.github.com/repos/aoaoaoaoaoaoaoi/akeru/languages",
    "stargazers_url": "https://api.github.com/repos/aoaoaoaoaoaoaoi/akeru/stargazers",
    "contributors_url": "https://api.github.com/repos/aoaoaoaoaoaoaoi/akeru/contributors",
    "subscribers_url": "https://api.github.com/repos/aoaoaoaoaoaoaoi/akeru/subscribers",
    "subscription_url": "https://api.github.com/repos/aoaoaoaoaoaoaoi/akeru/subscription",
    "commits_url": "https://api.github.com/repos/aoaoaoaoaoaoaoi/akeru/commits{/sha}",
    "git_commits_url": "https://api.github.com/repos/aoaoaoaoaoaoaoi/akeru/git/commits{/sha}",
    "comments_url": "https://api.github.com/repos/aoaoaoaoaoaoaoi/akeru/comments{/number}",
    "issue_comment_url": "https://api.github.com/repos/aoaoaoaoaoaoaoi/akeru/issues/comments{/number}",
    "contents_url": "https://api.github.com/repos/aoaoaoaoaoaoaoi/akeru/contents/{+path}",
    "compare_url": "https://api.github.com/repos/aoaoaoaoaoaoaoi/akeru/compare/{base}...{head}",
    "merges_url": "https://api.github.com/repos/aoaoaoaoaoaoaoi/akeru/merges",
    "archive_url": "https://api.github.com/repos/aoaoaoaoaoaoaoi/akeru/{archive_format}{/ref}",
    "downloads_url": "https://api.github.com/repos/aoaoaoaoaoaoaoi/akeru/downloads",
    "issues_url": "https://api.github.com/repos/aoaoaoaoaoaoaoi/akeru/issues{/number}",
    "pulls_url": "https://api.github.com/repos/aoaoaoaoaoaoaoi/akeru/pulls{/number}",
    "milestones_url": "https://api.github.com/repos/aoaoaoaoaoaoaoi/akeru/milestones{/number}",
    "notifications_url": "https://api.github.com/repos/aoaoaoaoaoaoaoi/akeru/notifications{?since,all,participating}",
    "labels_url": "https://api.github.com/repos/aoaoaoaoaoaoaoi/akeru/labels{/name}",
    "releases_url": "https://api.github.com/repos/aoaoaoaoaoaoaoi/akeru/releases{/id}",
    "deployments_url": "https://api.github.com/repos/aoaoaoaoaoaoaoi/akeru/deployments",
    "created_at": "2020-12-25T14:28:59Z",
    "updated_at": "2020-12-31T06:54:56Z",
    "pushed_at": "2020-12-31T06:54:54Z",
    "git_url": "git://github.com/aoaoaoaoaoaoaoi/akeru.git",
    "ssh_url": "git@github.com:aoaoaoaoaoaoaoi/akeru.git",
    "clone_url": "https://github.com/aoaoaoaoaoaoaoi/akeru.git",
    "svn_url": "https://github.com/aoaoaoaoaoaoaoi/akeru",
    "homepage": null,
    "size": 48,
    "stargazers_count": 0,
    "watchers_count": 0,
    "language": "C#",
    "has_issues": true,
    "has_projects": true,
    "has_downloads": true,
    "has_wiki": true,
    "has_pages": false,
    "forks_count": 0,
    "mirror_url": null,
    "archived": false,
    "disabled": false,
    "open_issues_count": 0,
    "license": null,
    "forks": 0,
    "open_issues": 0,
    "watchers": 0,
    "default_branch": "main"
},
{
    "id": 315965689,
    "node_id": "MDEwOlJlcG9zaXRvcnkzMTU5NjU2ODk=",
    "name": "book_page",
    "full_name": "aoaoaoaoaoaoaoi/book_page",
    "private": false,
    "owner": {
    "login": "aoaoaoaoaoaoaoi",
    "id": 40077710,
    "node_id": "MDQ6VXNlcjQwMDc3NzEw",
    "avatar_url": "https://avatars.githubusercontent.com/u/40077710?v=4",
    "gravatar_id": "",
    "url": "https://api.github.com/users/aoaoaoaoaoaoaoi",
    "html_url": "https://github.com/aoaoaoaoaoaoaoi",
    "followers_url": "https://api.github.com/users/aoaoaoaoaoaoaoi/followers",
    "following_url": "https://api.github.com/users/aoaoaoaoaoaoaoi/following{/other_user}",
    "gists_url": "https://api.github.com/users/aoaoaoaoaoaoaoi/gists{/gist_id}",
    "starred_url": "https://api.github.com/users/aoaoaoaoaoaoaoi/starred{/owner}{/repo}",
    "subscriptions_url": "https://api.github.com/users/aoaoaoaoaoaoaoi/subscriptions",
    "organizations_url": "https://api.github.com/users/aoaoaoaoaoaoaoi/orgs",
    "repos_url": "https://api.github.com/users/aoaoaoaoaoaoaoi/repos",
    "events_url": "https://api.github.com/users/aoaoaoaoaoaoaoi/events{/privacy}",
    "received_events_url": "https://api.github.com/users/aoaoaoaoaoaoaoi/received_events",
    "type": "User",
    "site_admin": false
    },
    "html_url": "https://github.com/aoaoaoaoaoaoaoi/book_page",
    "description": null,
    "fork": false,
    "url": "https://api.github.com/repos/aoaoaoaoaoaoaoi/book_page",
    "forks_url": "https://api.github.com/repos/aoaoaoaoaoaoaoi/book_page/forks",
    "keys_url": "https://api.github.com/repos/aoaoaoaoaoaoaoi/book_page/keys{/key_id}",
    "collaborators_url": "https://api.github.com/repos/aoaoaoaoaoaoaoi/book_page/collaborators{/collaborator}",
    "teams_url": "https://api.github.com/repos/aoaoaoaoaoaoaoi/book_page/teams",
    "hooks_url": "https://api.github.com/repos/aoaoaoaoaoaoaoi/book_page/hooks",
    "issue_events_url": "https://api.github.com/repos/aoaoaoaoaoaoaoi/book_page/issues/events{/number}",
    "events_url": "https://api.github.com/repos/aoaoaoaoaoaoaoi/book_page/events",
    "assignees_url": "https://api.github.com/repos/aoaoaoaoaoaoaoi/book_page/assignees{/user}",
    "branches_url": "https://api.github.com/repos/aoaoaoaoaoaoaoi/book_page/branches{/branch}",
    "tags_url": "https://api.github.com/repos/aoaoaoaoaoaoaoi/book_page/tags",
    "blobs_url": "https://api.github.com/repos/aoaoaoaoaoaoaoi/book_page/git/blobs{/sha}",
    "git_tags_url": "https://api.github.com/repos/aoaoaoaoaoaoaoi/book_page/git/tags{/sha}",
    "git_refs_url": "https://api.github.com/repos/aoaoaoaoaoaoaoi/book_page/git/refs{/sha}",
    "trees_url": "https://api.github.com/repos/aoaoaoaoaoaoaoi/book_page/git/trees{/sha}",
    "statuses_url": "https://api.github.com/repos/aoaoaoaoaoaoaoi/book_page/statuses/{sha}",
    "languages_url": "https://api.github.com/repos/aoaoaoaoaoaoaoi/book_page/languages",
    "stargazers_url": "https://api.github.com/repos/aoaoaoaoaoaoaoi/book_page/stargazers",
    "contributors_url": "https://api.github.com/repos/aoaoaoaoaoaoaoi/book_page/contributors",
    "subscribers_url": "https://api.github.com/repos/aoaoaoaoaoaoaoi/book_page/subscribers",
    "subscription_url": "https://api.github.com/repos/aoaoaoaoaoaoaoi/book_page/subscription",
    "commits_url": "https://api.github.com/repos/aoaoaoaoaoaoaoi/book_page/commits{/sha}",
    "git_commits_url": "https://api.github.com/repos/aoaoaoaoaoaoaoi/book_page/git/commits{/sha}",
    "comments_url": "https://api.github.com/repos/aoaoaoaoaoaoaoi/book_page/comments{/number}",
    "issue_comment_url": "https://api.github.com/repos/aoaoaoaoaoaoaoi/book_page/issues/comments{/number}",
    "contents_url": "https://api.github.com/repos/aoaoaoaoaoaoaoi/book_page/contents/{+path}",
    "compare_url": "https://api.github.com/repos/aoaoaoaoaoaoaoi/book_page/compare/{base}...{head}",
    "merges_url": "https://api.github.com/repos/aoaoaoaoaoaoaoi/book_page/merges",
    "archive_url": "https://api.github.com/repos/aoaoaoaoaoaoaoi/book_page/{archive_format}{/ref}",
    "downloads_url": "https://api.github.com/repos/aoaoaoaoaoaoaoi/book_page/downloads",
    "issues_url": "https://api.github.com/repos/aoaoaoaoaoaoaoi/book_page/issues{/number}",
    "pulls_url": "https://api.github.com/repos/aoaoaoaoaoaoaoi/book_page/pulls{/number}",
    "milestones_url": "https://api.github.com/repos/aoaoaoaoaoaoaoi/book_page/milestones{/number}",
    "notifications_url": "https://api.github.com/repos/aoaoaoaoaoaoaoi/book_page/notifications{?since,all,participating}",
    "labels_url": "https://api.github.com/repos/aoaoaoaoaoaoaoi/book_page/labels{/name}",
    "releases_url": "https://api.github.com/repos/aoaoaoaoaoaoaoi/book_page/releases{/id}",
    "deployments_url": "https://api.github.com/repos/aoaoaoaoaoaoaoi/book_page/deployments",
    "created_at": "2020-11-25T14:36:06Z",
    "updated_at": "2021-01-05T16:31:22Z",
    "pushed_at": "2021-01-05T16:31:20Z",
    "git_url": "git://github.com/aoaoaoaoaoaoaoi/book_page.git",
    "ssh_url": "git@github.com:aoaoaoaoaoaoaoi/book_page.git",
    "clone_url": "https://github.com/aoaoaoaoaoaoaoi/book_page.git",
    "svn_url": "https://github.com/aoaoaoaoaoaoaoi/book_page",
    "homepage": null,
    "size": 105,
    "stargazers_count": 0,
    "watchers_count": 0,
    "language": "Haskell",
    "has_issues": true,
    "has_projects": true,
    "has_downloads": true,
    "has_wiki": true,
    "has_pages": false,
    "forks_count": 0,
    "mirror_url": null,
    "archived": false,
    "disabled": false,
    "open_issues_count": 0,
    "license": null,
    "forks": 0,
    "open_issues": 0,
    "watchers": 0,
    "default_branch": "main"
}
] """


type alias Repository =
    { name : String
    , private : Bool
    , description : Maybe String
    , fork : Bool
    , url : String
    }


main =
    D.decodeString repositoriesDecoder payload
        |> Debug.toString
        |> text



{-
   repositoriesDecoder : Decoder (List Repository)
   repositoriesDecoder =
       D.list repositoryDecoder
-}


repositoriesDecoder : Decoder (List Repository)
repositoriesDecoder =
    D.map5 Repository
        (D.field "name" D.string)
        (D.field "private" D.bool)
        (D.maybe (D.field "description" D.string))
        (D.field "fork" D.bool)
        (D.field "url" D.string)
        |> D.list



{-
   Reference : https://riptutorial.com/elm/example/22243/decoding-a-list-of-records
-}
