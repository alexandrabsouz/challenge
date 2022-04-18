ExUnit.start()
Ecto.Adapters.SQL.Sandbox.mode(Challenge.Repo, :manual)

Mox.defmock(Challenge.GitHub.ClientMock, for: Challenge.Github.Behaviour)
