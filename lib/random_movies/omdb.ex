defmodule RandomMovies.Omdb do
  @user_agent [ {"User-agent", "Elixir"} ]

  def fetch(title) do
    find_by_title_url(title)
    |> HTTPoison.get(@user_agent)
    |> handle_response
  end

  defp find_by_title_url(title) do
    "http://omdbapi.com/?t=#{title}"
  end

  defp handle_response({:ok, %HTTPoison.Response{body: body}}) do
    case body do
      "{\"Response\":\"False\",\"Error\":\"Movie not found!\"}" ->
        {:error, "Not found"}
      _ ->
        decode_as_movie body
    end
  end

  defp handle_response({:error, %HTTPoison.Error{reason: reason}}) do
    {:error, reason}
  end

  defp decode_as_movie(body) do
    Poison.decode body, as: RandomMovies.Movie
  end
end
