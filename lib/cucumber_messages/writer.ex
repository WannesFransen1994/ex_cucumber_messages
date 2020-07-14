defmodule ExCucumberMessages.Writer do
  defp unstruct(%{__struct__: _} = map), do: map |> Map.from_struct() |> unstruct()
  defp unstruct(%{} = map), do: Enum.map(map, fn {k, v} -> {k, unstruct(v)} end) |> Enum.into(%{})
  defp unstruct(list) when is_list(list), do: Enum.map(list, fn el -> unstruct(el) end)
  defp unstruct(just_a_value), do: just_a_value

  def envelopes_to_ndjson!(list_of_envelopes) when is_list(list_of_envelopes) do
    Enum.map(list_of_envelopes, &(&1 |> unstruct |> Jason.encode!()))
  end
end
