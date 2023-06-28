defmodule Bmb.ImageResolver do
  def validate_product_image_upload(_parent, %{image_name: image_name}, _ctx) do
    case Bmb.Repo.get_by(Bmb.Image, name: image_name) do
      nil -> {:ok, true}
      _ -> {:ok, false}
    end
  end
end
