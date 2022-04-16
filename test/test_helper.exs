ExUnit.start()
Ecto.Adapters.SQL.Sandbox.mode(GithubChallenge.Repo, :manual)

Mox.defmock(GithubChallenge.GitHub.ClientMock, for: GithubChallenge.Github.Behaviour)
