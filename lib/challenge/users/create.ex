defmodule Challenge.Users.Create do
  alias Challenge.{Error, Repo, User}

  def call(params) do
    username = Map.get(params, "username")
    changeset = User.changeset(params)

    with {:ok, %User{}} <- User.build(changeset),
         {:ok, _repo_info} <- client().get_repo_info(username),
         {:ok, %User{}} = user <- Repo.insert(changeset) do
      user
    else
      {:error, %Error{}} = error -> error
      {:error, result} -> {:error, Error.build(:bad_request, result)}
    end
  end

  defp client do
    :challenge
    |> Application.fetch_env!(__MODULE__)
    |> Keyword.get(:github_client_adapter)
  end
end

# user_params = %{"cpf" => "29534291072" , "password" => "teste1234", "username" => "cccvcvcvcvcvcvcvcv"}
