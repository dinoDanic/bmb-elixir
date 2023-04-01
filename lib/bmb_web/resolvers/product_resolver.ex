defmodule Bmb.ProductResolver do
  alias Bmb.Product
  alias Bmb.Repo

  def all_products(_root, _args, _info) do
    {:ok, Repo.all(Product)}
  end
end
