#!/usr/bin/env elixir

defmodule Bmb.Seeds.ProductsInstructionsDownloadUrls do
  alias Bmb.Repo
  alias Bmb.Product

  @products_instructions_download_urls [
    %{product_id: 63, instructions_download_url: "https://firebasestorage.googleapis.com/v0/b/bmb-next.appspot.com/o/support%2Finstructions%2F013-hr-si-en-de-cz-hu-ru-0142014.pdf?alt=media&token=62ed29ff-f452-422e-b3fe-10ca73dc9b95"},
    %{product_id: 411, instructions_download_url: "https://firebasestorage.googleapis.com/v0/b/bmb-next.appspot.com/o/support%2Finstructions%2F10-hr-si-en-de-cz-hu-ru-0142014.pdf?alt=media&token=ef79b8cb-1e3b-4d38-b418-7392944ef900"},
    %{product_id: 414, instructions_download_url: "https://firebasestorage.googleapis.com/v0/b/bmb-next.appspot.com/o/support%2Finstructions%2F10-hr-si-en-de-cz-hu-ru-0142014.pdf?alt=media&token=ef79b8cb-1e3b-4d38-b418-7392944ef900"},
    %{product_id: 414, instructions_download_url: "https://firebasestorage.googleapis.com/v0/b/bmb-next.appspot.com/o/support%2Finstructions%2F10-hr-si-en-de-cz-hu-ru-0142014.pdf?alt=media&token=ef79b8cb-1e3b-4d38-b418-7392944ef900"},
    %{product_id: 1, instructions_download_url: "https://firebasestorage.googleapis.com/v0/b/bmb-next.appspot.com/o/support%2Finstructions%2F100-hr-0142016.pdf?alt=media&token=9700d3e1-691e-4fd7-af15-922ed5b848f9"},
    %{product_id: 48, instructions_download_url: "https://firebasestorage.googleapis.com/v0/b/bmb-next.appspot.com/o/support%2Finstructions%2F1500-hr-0142016.pdf?alt=media&token=9707b49a-8c07-4891-b9a2-48dd76c4396d"},
    %{product_id: 49, instructions_download_url: "https://firebasestorage.googleapis.com/v0/b/bmb-next.appspot.com/o/support%2Finstructions%2F1500-hr-0142016.pdf?alt=media&token=9707b49a-8c07-4891-b9a2-48dd76c4396d"},
    %{product_id: 412, instructions_download_url: "https://firebasestorage.googleapis.com/v0/b/bmb-next.appspot.com/o/support%2Finstructions%2F2-hr-si-en-de-cz-hu-ru-0142014.pdf?alt=media&token=c8d95875-5d5d-4f11-82b6-190bcb87a90b"},
    %{product_id: 76, instructions_download_url: "https://firebasestorage.googleapis.com/v0/b/bmb-next.appspot.com/o/support%2Finstructions%2F3-hr-si-en-de-cz-hu-ru-0142014.pdf?alt=media&token=81bc865e-5d95-464a-b2ad-1432b9ae3d63"},
    %{product_id: 174, instructions_download_url: "https://firebasestorage.googleapis.com/v0/b/bmb-next.appspot.com/o/support%2Finstructions%2F505-hr-si-en-de-cz-hu-ru-0142014.pdf?alt=media&token=33d4a6e2-cb2c-445e-9497-64d6e00d2b5e"},
    %{product_id: 29, instructions_download_url: "https://firebasestorage.googleapis.com/v0/b/bmb-next.appspot.com/o/support%2Finstructions%2F52-1-hr-en-si-de.pdf?alt=media&token=65517951-32e7-4f5b-beae-582faadcd3e2"},
    %{product_id: 675, instructions_download_url: "https://firebasestorage.googleapis.com/v0/b/bmb-next.appspot.com/o/support%2Finstructions%2F55-1-hr-si-en-de-cz-hu-ru-0142014.pdf?alt=media&token=b1da9b92-b312-4a85-a68a-53bbfb86cb8e"},
    %{product_id: 59, instructions_download_url: "https://storage.googleapis.com/bmb-next.appspot.com/support/instructions/553-hr-si-en-de-cz-hu-ru-0142014.pdf?GoogleAccessId=service-380181071881@gcp-sa-firebasestorage.iam.gserviceaccount.com&Expires=1689184554&Signature=LRL8ZDcVQo31xXtO4FWHcO8adcFrh14T6rX/UnLL%2BUTBd2aRcmIjp7WxGnfvQhZePICJH3oqLY6h0aC2nlA/iCvCgeZkOA/m4axDR0eNwYtjIYkdBHDnxPCcz9gINMxnDF/d2LubUS2Lxo5d/nNAj2AVQdx1E1qwECfKLLWKn5Bw8VzbjaukiclG9HFVll8rNjClUweYP3EEAJdVpIjOikq9Btd0Q7fvtrZFoe1g4LVZXWwkBYkSRoVHbHBzb5%2Bvxoc2O0QXWaQ8vPcD3IGzNACzxt0449P0jOg0R7DQpKRx9L4KgwD78/nz7kU0ULdp5TASTlc0qqeOTzmP0OZlIg%3D%3D"},
    %{product_id: 61, instructions_download_url: "https://storage.googleapis.com/bmb-next.appspot.com/support/instructions/553-hr-si-en-de-cz-hu-ru-0142014.pdf?GoogleAccessId=service-380181071881@gcp-sa-firebasestorage.iam.gserviceaccount.com&Expires=1689184554&Signature=LRL8ZDcVQo31xXtO4FWHcO8adcFrh14T6rX/UnLL%2BUTBd2aRcmIjp7WxGnfvQhZePICJH3oqLY6h0aC2nlA/iCvCgeZkOA/m4axDR0eNwYtjIYkdBHDnxPCcz9gINMxnDF/d2LubUS2Lxo5d/nNAj2AVQdx1E1qwECfKLLWKn5Bw8VzbjaukiclG9HFVll8rNjClUweYP3EEAJdVpIjOikq9Btd0Q7fvtrZFoe1g4LVZXWwkBYkSRoVHbHBzb5%2Bvxoc2O0QXWaQ8vPcD3IGzNACzxt0449P0jOg0R7DQpKRx9L4KgwD78/nz7kU0ULdp5TASTlc0qqeOTzmP0OZlIg%3D%3D"},
    %{product_id: 62, instructions_download_url: "https://firebasestorage.googleapis.com/v0/b/bmb-next.appspot.com/o/support%2Finstructions%2F557-hr-si-en-de-cz-hu-ru-0142014.pdf?alt=media&token=1077b862-3499-4bbf-a437-7ffa9211f120"},
    %{product_id: 462, instructions_download_url: "https://firebasestorage.googleapis.com/v0/b/bmb-next.appspot.com/o/support%2Finstructions%2F557-hr-si-en-de-cz-hu-ru-0142014.pdf?alt=media&token=1077b862-3499-4bbf-a437-7ffa9211f120"},
    %{product_id: 64, instructions_download_url: "https://storage.googleapis.com/bmb-next.appspot.com/support/instructions/604-hr-si-en-de-cz-hu-ru-0142014.pdf?GoogleAccessId=service-380181071881@gcp-sa-firebasestorage.iam.gserviceaccount.com&Expires=1689184637&Signature=hSGnoj12iPFJBoHthSbrQhQvqtgev3tWivK%2BqZldQJBhLmmrsMFKMedaBXVf06sr%2BM9qXLwx6PZmsYaPBgT03iK6AuNYn9rq9gBeI3HCrSr4pcD5gSgCeUi8BnrOsWUuSW9GKRCQkBjOKuVRS3UZXCJnO2tlSiP348PVLA2IyWAePy9Dh/MOSUHkL7k4zl/E9YHoVDd7Pj2mpSVEp9YBeVw1Cs4FTpDWygj4rKEqImBjLyijnOFKK2pcR%2B2yOU8efWG1NGMIicfeTCGAJoJL8d7Kc5cJuhFN1Trt6eeRk/Ah035sP3kTnXSXyS267W/XbFa7pdBoqGXuhJ1rw72lcQ%3D%3D"},
    %{product_id: 311, instructions_download_url: "https://firebasestorage.googleapis.com/v0/b/bmb-next.appspot.com/o/support%2Finstructions%2F606-hr-si-en-de-cz-hu-ru-0142014.pdf?alt=media&token=07b64852-c6de-4a32-b7e1-be1be09418b4"},
    %{product_id: 81, instructions_download_url: "https://storage.googleapis.com/bmb-next.appspot.com/support/instructions/liapor-serija-hr-si-en-de-cz-hu-ru-0142014.pdf?GoogleAccessId=service-380181071881@gcp-sa-firebasestorage.iam.gserviceaccount.com&Expires=1689184825&Signature=c1HKTXQqjVyd2MfOoa1B6qqZM5SU/b0y/IDRu6wYPltjk0QMZMkAiEiEkZTZt%2BEWjp0qv1rSJANAzsisIZ8Gk5yCf8d/jZeOirpCPZ8lFC1ysmM1S9Ucizqav8f60AkaVtsQbSUmb/r%2BbgIzHqd02AfeBb9d9AbvfaBwH%2B/P3dJOA4zm0xDKByAnFodjufITO%2BAAkgz579yzzFMR7r0fN1yGgKeOqEvl5aOZQCGwCpATcpufA4OjjZrxf3geU6sUK8LcIdCtdH%2BqQO0PnEkYDt3kvLRiiswVJuq5U7sK0KvvNx5901DY56b8mN9OoYBqh6DacccvJ6/n%2B/Awn/E6zQ%3D%3D"},
    %{product_id: 78, instructions_download_url: "https://storage.googleapis.com/bmb-next.appspot.com/support/instructions/liapor-serija-hr-si-en-de-cz-hu-ru-0142014.pdf?GoogleAccessId=service-380181071881@gcp-sa-firebasestorage.iam.gserviceaccount.com&Expires=1689184825&Signature=c1HKTXQqjVyd2MfOoa1B6qqZM5SU/b0y/IDRu6wYPltjk0QMZMkAiEiEkZTZt%2BEWjp0qv1rSJANAzsisIZ8Gk5yCf8d/jZeOirpCPZ8lFC1ysmM1S9Ucizqav8f60AkaVtsQbSUmb/r%2BbgIzHqd02AfeBb9d9AbvfaBwH%2B/P3dJOA4zm0xDKByAnFodjufITO%2BAAkgz579yzzFMR7r0fN1yGgKeOqEvl5aOZQCGwCpATcpufA4OjjZrxf3geU6sUK8LcIdCtdH%2BqQO0PnEkYDt3kvLRiiswVJuq5U7sK0KvvNx5901DY56b8mN9OoYBqh6DacccvJ6/n%2B/Awn/E6zQ%3D%3D"},
    %{product_id: 712, instructions_download_url: "https://firebasestorage.googleapis.com/v0/b/bmb-next.appspot.com/o/support%2Finstructions%2Fupute%2004S%CC%8C-1.pdf?alt=media&token=66dfc69b-9fe8-49d3-8e2f-d251d17cf684"},
    %{product_id: 724, instructions_download_url: "https://storage.googleapis.com/bmb-next.appspot.com/support/instructions/upute%2004S%CC%8C-2.pdf?GoogleAccessId=service-380181071881@gcp-sa-firebasestorage.iam.gserviceaccount.com&Expires=1689184893&Signature=ZqunJ8jL2AlNhmsoE9EsyubJghui7m5xXRNJUFDI6GX%2BABQKjIZIEaS9JGl%2B4K5I2YZeEpEZwpmuI7moWMS6kK7Xgvj6iEG9ukE6yO5QnyoHma2mCeVqL083kXrEiw6IeO8j57HEpePcoCcifTLsK%2BkHVvZdO/lZy0Yc8tJRAexR0jw1pjUSpphyYRsV8ikPtml%2BHKbYXRuDuLvStEhVIIsWqOUb9bqb1hSZdb3aCHr51y9BoQBd80dst4MUieOzFz/N6D7c0gl7%2B71RNrQBmb0Q0H6IYIXx8vpd%2BiLnAHqpUPUZyAeW5Tcs2h9BrwolWDVnR1ewu1w5QDfPZT4Cyw%3D%3D"},
    %{product_id: 716, instructions_download_url: "https://firebasestorage.googleapis.com/v0/b/bmb-next.appspot.com/o/support%2Finstructions%2Fupute%2004S%CC%8CFO-2.pdf?alt=media&token=1bbcaee7-a067-4abe-9a59-9dd9ba4fae4c"}
  ]

  def run do
    Enum.each(@products_instructions_download_urls, fn %{product_id: product_id, instructions_download_url: url} ->
      product = Repo.get!(Product, product_id)
      changeset = Ecto.Changeset.change(product, instructions_download_url: url)
      Repo.update!(changeset)
    end)
  end
end

Bmb.Seeds.ProductsInstructionsDownloadUrls.run()
