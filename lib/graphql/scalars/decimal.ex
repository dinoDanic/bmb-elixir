defmodule BmbWeb.Graphql.Scalars.Decimal do
  use Absinthe.Schema.Notation

  scalar :decimal do
    parse(fn
      %{value: value}, _ ->
        Decimal.parse(value)

      # Temporary fix when decimal field isn't sent from the client.
      # TODO: Fix to skip the field if field isn't sent.
      %Absinthe.Blueprint.Input.Null{}, _ ->
        {:ok, Decimal.new(0)}

      _, _ ->
        :error
    end)

    serialize(&to_string/1)
  end
end

