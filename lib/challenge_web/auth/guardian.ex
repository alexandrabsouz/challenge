defmodule ChallengeWeb.Auth.Guardian do
  use Guardian, otp_app: :challenge

  alias Challenge.{Error, User}
  alias Challenge.Users.Get, as: UserGet

  @ttl_login {1, :minute}

  def subject_for_token(%User{id: id}, _claims), do: {:ok, id}

  def resource_from_claims(claims) do
    claims
    |> Map.get("sub")
    |> UserGet.by_id()
  end

  def authenticate(%{"id" => user_id, "password" => password}) do
    with {:ok, %User{password_hash: hash} = user} <- UserGet.by_id(user_id),
         true <- Pbkdf2.verify_pass(password, hash),
         {:ok, token, _claims} <- encode_and_sign(user, %{}, ttl: @ttl_login) do
      {:ok, token}
    else
      false -> {:error, Error.build(:unauthorized, "please verify your credentials")}
      error -> error
    end
  end

  def authenticate(_), do: {:error, Error.build(:bad_request, "invalid or missing params")}

  def refresh_token(%{"token" => token}) do
    case refresh(token, ttl: @ttl_login) do
      {:ok, _old_stuff, {new_token, _new_claims}} -> {:ok, new_token}
      {:error, reason} -> {:error, Error.build(:unauthorized, reason)}
    end
  end

  def refresh_token(_), do: {:error, Error.build(:bad_request, "invalid or missing params")}
end
