alias Bmb.Repo
alias Schemas.Account

%Account{}
|> Account.changeset(%{
  first_name: "BMB",
  last_name: "Admin",
  password: "Ruda,actv1!",
  username: "bmb_admin",
  email: "dino.danic@gmail.com"
})
|> Repo.insert()
