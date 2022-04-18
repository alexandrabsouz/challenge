defmodule Challenge do
  alias Challenge.Users.Create, as: UserCreate

  defdelegate create_user(params), to: UserCreate, as: :call
end
