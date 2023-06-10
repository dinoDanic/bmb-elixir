defmodule BmbWeb.Auth.CustomMiddleware do
  defmacro __using__(_) do
    quote do
      # alias KodiStragaWeb.API.Graphql.Middleware
      alias BmbWeb.Auth.RequireAuth

      def middleware(middleware, field, object) do
        authorized_fields = [
          :edit_product
        ]

        if field.__reference__.module === Absinthe.Type.BuiltIns.Introspection do
          middleware
        else
          if Enum.member?(authorized_fields, field.identifier) do
            [RequireAuth | middleware]
          else
            middleware
          end
        end
      end
    end
  end
end
