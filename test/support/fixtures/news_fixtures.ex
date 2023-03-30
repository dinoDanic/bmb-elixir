defmodule Bmb.NewsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Bmb.News` context.
  """

  @doc """
  Generate a link.
  """
  def link_fixture(attrs \\ %{}) do
    {:ok, link} =
      attrs
      |> Enum.into(%{
        description: "some description",
        url: "some url"
      })
      |> Bmb.News.create_link()

    link
  end
end
