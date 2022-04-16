defmodule GithubChallenge.Github.Client do
    use Tesla

    alias GithubChallenge.{Error, GithubMap}
    alias Tesla.Env

    plug Tesla.Middleware.BaseUrl, "https://api.github.com/users/"
    plug Tesla.Middleware.JSON

    def get_repo_info(user_name) do
        "#{user_name}/repos"
        |> get()
        |> handle_get()
    end

    defp handle_get({:ok, %Env{status: 200, body: body}}) do
        {:ok, body}
    end
    
    defp handle_get({:ok, %Env{status: 404, body: %{"message" => "Not Found"}}}) do
        {:error, Error.build_user_not_found_error()}
    end
    
    defp handle_get({:error, reason}) do
        {:error, Error.build(:bad_request, reason)}
    end
end