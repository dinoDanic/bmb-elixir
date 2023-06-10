alias Bmb.Repo
alias Schemas.Account

%Account{}
|> Account.changeset(%{
  first_name: "Kodius",
  last_name: "Test",
  password: "Ruda,actv1!",
  username: "kodius_test",
  email: "user@kodius.com"
})
|> Repo.insert()
