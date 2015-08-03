defmodule RandomMovies.Router do
  use RandomMovies.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", RandomMovies do
    pipe_through :browser # Use the default browser stack

    get "/:query", PageController, :index
  end
end
