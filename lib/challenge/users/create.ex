defmodule Challenge.Users.Create do
  alias Challenge.{Error, Repo, User}
  alias Challenge.Github.Client

  def call(params) do
    username = Map.get(params, "username")
    changeset = User.changeset(params)

    with {:ok, %User{}} <- User.build(changeset),
         {:ok, _body} <- Client.get_repo_info(username),
         {:ok, %User{}} = user <- Repo.insert(changeset) do
      user
    else
      {:error, %Error{}} = error -> error
      {:error, result} -> {:error, Error.build(:bad_request, result)}
    end
  end
end

#user_params = %{"cpf" => "29534291072" , "password" => "teste1234", "username" => "alexandrabsouz"}
