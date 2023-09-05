alias Bmb.Repo
alias Schemas.Account

%Account{}
|> Account.changeset(%{
  first_name: "BMB",
  last_name: "Admin",
  password: "bmb_1",
  username: "bmb_admin",
  email: "petrabogdan777@gmail.com"
  # email: "bozica.dananic@gmail.com"
})
|> Repo.insert()
