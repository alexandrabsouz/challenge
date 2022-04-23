defmodule ChallengeWeb.Router do
  use ChallengeWeb, :router

  alias ChallengeWeb.Plugs.RefreshToken

  pipeline :api do
    plug :accepts, ["json"]
    plug RefreshToken
  end

  pipeline :auth do
    plug ChallengeWeb.Auth.Pipeline
  end

  scope "/api", ChallengeWeb do
    pipe_through [:api, :auth]

    get "/:username/repos", ReposController, :show
    resources "/users", UsersController, except: [:new, :edit, :create]
  end

  scope "/api", ChallengeWeb do
    pipe_through :api
    
    post "/users", UsersController, :create
  end

  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through [:fetch_session, :protect_from_forgery]
      live_dashboard "/dashboard", metrics: ChallengeWeb.Telemetry
    end
  end
end
