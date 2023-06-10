defmodule Bmb do
  @moduledoc """
  Bmb keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

  def child_spec(_arg) do
    children = [
      Bmb.Repo
      # {Absinthe.Subscription, KodiStragaWeb.Endpoint}
    ]

    %{
      id: __MODULE__,
      type: :supervisor,
      start: {Supervisor, :start_link, [children, [strategy: :one_for_one]]}
    }
  end
end
