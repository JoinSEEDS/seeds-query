defmodule SeedsQueryWeb.Router do
  use SeedsQueryWeb, :router

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/api" do
    pipe_through(:api)
    forward("/", Absinthe.Plug, schema: SeedsQueryWeb.SchemaNew)
  end

  forward("/graphiql", Absinthe.Plug.GraphiQL,
    interface: :playground,
    schema: SeedsQueryWeb.Schema
  )
end
