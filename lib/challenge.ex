defmodule Challenge do
  alias Challenge.Users.Create, as: UserCreate
  alias Challenge.Users.Get, as: UserGet

  defdelegate create_user(params), to: UserCreate, as: :call
  defdelegate get_user_by_id(params), to: UserGet, as: :by_id
end
