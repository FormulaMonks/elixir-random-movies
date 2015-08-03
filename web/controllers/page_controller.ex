defmodule RandomMovies.PageController do
  use RandomMovies.Web, :controller

  def index(conn, %{"query" => query}) do
    case RandomMovies.Omdb.fetch(query) do
      {:ok, movie} ->
        render conn, "index.html", movie: movie
      {:error, _} ->
        render conn, "index.html", query: query, movie: nil
    end
  end
end
