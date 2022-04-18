defmodule Challenge.Github.Client do
  use Tesla

  alias Challenge.Error
  alias Challenge.Github.Behaviour
  alias Tesla.Env

  @behaviour Behaviour
  @base_url "https://api.github.com/users/"

  plug Tesla.Middleware.JSON

  def get_repo_info(url \\ @base_url, username) do
    "#{url}#{username}/repos"
    |> get()
    |> handle_get()
  end

  defp handle_get({:ok, %Env{status: 200, body: body}}) do
    {:ok, body}
  end

  defp handle_get({:ok, %Env{status: 404, body: %{"message" => "Not Found"}}}) do
    {:error, Error.build(:bad_request, "username not found")}
  end

  defp handle_get({:error, reason}) do
    {:error, Error.build(:bad_request, reason)}
  end
end
