defmodule CurrencyEnum do
  @moduledoc false

  use Ecto.Type

  @currency_codes [
    "EUR",
    "HRK"
  ]

  def type, do: :string

  def cast(value) do
    if value in @currency_codes do
      {:ok, value}
    else
      :error
    end
  end

  def load(value), do: {:ok, value}

  def dump(value), do: {:ok, value}
end
