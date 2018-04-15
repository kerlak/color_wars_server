defmodule ColorWarsWeb.Router do
  use ColorWarsWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", ColorWarsWeb do
    pipe_through :api
  end
end
