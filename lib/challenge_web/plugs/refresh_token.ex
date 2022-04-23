defmodule ChallengeWeb.Plugs.RefreshToken do
    import Plug.Conn

  alias ChallengeWeb.Auth.Guardian

  def init(options), do: options

  def call(conn, _opts) do
    with ["Bearer " <> token] <- get_req_header(conn, "authorization"),
         {:ok, new_token} <- Guardian.refresh_token(%{"token" => token}) do
      put_private(conn, :refresh_token, new_token)
    else
      _ -> conn
    end
  end
end