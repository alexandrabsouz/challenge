defmodule GithubChallenge.GitHub.ClientTest do
  use ExUnit.Case

  alias GithubChallenge.Github.Client
  alias Plug.Conn

  describe "get_repo_info/1" do
    setup do
      bypass = Bypass.open()
      {:ok, bypass: bypass}
    end

    test "when there is valid username, returns the repos info", %{bypass: bypass} do
      username = "JeanDiniz"

      url = endpoint_url(bypass.port)

      body = ~s({
            "id": 301515742,
            "name": "github-slideshow",
            "html_url": "https://github.com/JeanDiniz/github-slideshow",
            "description": "A robot powered training repository :robot:"
          })

      Bypass.expect(bypass, "GET", "#{username}/repos/", fn conn ->
        conn
        |> Conn.put_resp_header("content-type", "application/json")
        |> Conn.resp(200, body)
      end)

      response = Client.get_repo_info(url, username)

      expected_response =
        {:ok,
         %{
           "description" => "A robot powered training repository :robot:",
           "html_url" => "https://github.com/JeanDiniz/github-slideshow",
           "id" => 301_515_742,
           "name" => "github-slideshow"
         }}

      assert response == expected_response
    end

    test "when the username not found, returns an error", %{bypass: bypass} do
      username = "bananaanananana"

      url = endpoint_url(bypass.port)

      body = ~s({
          "message": "Not Found"
        })

      Bypass.expect(bypass, "GET", "#{username}/repos/", fn conn ->
        conn
        |> Conn.put_resp_header("content-type", "application/json")
        |> Conn.resp(404, body)
      end)

      response = Client.get_repo_info(url, username)

      expected_response =
        {:error, %GithubChallenge.Error{result: "user not found.", status: :not_found}}

      assert response == expected_response
    end

    defp endpoint_url(port), do: "http://localhost:#{port}/"
  end
end
