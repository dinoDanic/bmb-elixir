defmodule MixTasks do
  use Mix.Task

  def run_setup(_args) do
    run("ecto.migrate")
    run("run priv/repo/seeds/seed_products.ex")
    run("run priv/repo/seeds/seed_categories.ex")
    run("run priv/repo/seeds/seed_products_categories.ex")
  end

  defp run(command) do
    IO.puts "Running: mix #{command}"
    System.cmd("mix", String.split(command), stderr_to_stdout: true)
  end
end
