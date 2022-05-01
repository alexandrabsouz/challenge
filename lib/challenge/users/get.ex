defmodule Challenge.Users.Get do
  alias Challenge.{Error, Repo, User}

  def by_id(uuid) do
    case Repo.get(User, uuid) do
      nil -> {:error, Error.build_user_not_found_error()}
      user -> {:ok, user}
    end
  end

  # defp get_repo_github(user) do
  #     username = Map.get(user, :username)
  #     with {:ok, repos} = Client.get_repo_info(username) do
  #         {:ok, repos, user} 
  #     end
  # end
end
